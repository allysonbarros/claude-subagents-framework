#!/bin/bash

# Script para sincronizar/atualizar um agente específico do framework

set -e

FRAMEWORK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AGENTS_DIR="$FRAMEWORK_DIR/agents"

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

show_help() {
    cat << EOF
Uso: $0 AGENT_NAME [PROJECT_PATH]

Sincroniza/atualiza um agente do framework para o projeto.

ARGUMENTOS:
    AGENT_NAME      Nome do agente a sincronizar
    PROJECT_PATH    Caminho do projeto (padrão: diretório atual)

EXEMPLOS:
    # Sincronizar agente no projeto atual
    $0 product-manager

    # Sincronizar agente em projeto específico
    $0 product-manager ~/meu-projeto
EOF
}

sync_agent() {
    local agent_name=$1
    local project_path=${2:-.}

    # Procurar o agente no framework
    local source_file=""
    local category=""

    for cat_dir in "$AGENTS_DIR"/*; do
        if [ -d "$cat_dir" ]; then
            local agent_file="$cat_dir/$agent_name.md"

            if [ -f "$agent_file" ]; then
                source_file="$agent_file"
                category=$(basename "$cat_dir")
                break
            fi
        fi
    done

    if [ -z "$source_file" ]; then
        echo -e "${RED}✗${NC} Agente '$agent_name' não encontrado no framework"
        exit 1
    fi

    # Procurar o agente no projeto
    local dest_file=""
    local search_paths=(
        "$project_path/.claude/agents/$agent_name.md"
        "$project_path/.claude/agents/$category/$agent_name.md"
        "$project_path/agents/$agent_name.md"
        "$project_path/agents/$category/$agent_name.md"
    )

    for path in "${search_paths[@]}"; do
        if [ -f "$path" ]; then
            dest_file="$path"
            break
        fi
    done

    if [ -z "$dest_file" ]; then
        echo -e "${YELLOW}!${NC} Agente não encontrado no projeto"
        echo -e "  Deseja instalar em $project_path/.claude/agents/? (y/n)"
        read -r response

        if [[ "$response" =~ ^[Yy]$ ]]; then
            dest_file="$project_path/.claude/agents/$agent_name.md"
            mkdir -p "$(dirname "$dest_file")"
        else
            exit 0
        fi
    fi

    # Comparar versões (se existir campo de versão)
    if [ -f "$dest_file" ]; then
        local source_version=$(grep -m 1 "^## Versão" "$source_file" | sed 's/## Versão//' | xargs)
        local dest_version=$(grep -m 1 "^## Versão" "$dest_file" | sed 's/## Versão//' | xargs)

        if [ -n "$source_version" ] && [ -n "$dest_version" ]; then
            echo -e "${BLUE}Versão atual:${NC} $dest_version"
            echo -e "${BLUE}Nova versão:${NC} $source_version"
        fi
    fi

    # Copiar arquivo
    cp "$source_file" "$dest_file"
    echo -e "${GREEN}✓${NC} Agente '$agent_name' sincronizado em $dest_file"
}

# Parse argumentos
if [ $# -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
    exit 0
fi

sync_agent "$@"
