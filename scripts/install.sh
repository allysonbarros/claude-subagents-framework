#!/bin/bash

# Script para instalar agentes do framework no projeto

set -e

FRAMEWORK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AGENTS_DIR="$FRAMEWORK_DIR/agents"

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

show_help() {
    cat << EOF
Uso: $0 [OPÇÕES]

Instala agentes do Claude Subagents Framework no seu projeto.

OPÇÕES:
    --agent NOME        Instala um agente específico
    --category NOME     Instala todos os agentes de uma categoria
    --dest PATH         Diretório de destino (obrigatório)
    --list              Lista agentes disponíveis
    -h, --help          Mostra esta ajuda

CATEGORIAS:
    strategists         Estrategistas
    researchers         Pesquisadores
    designers           Designers
    frontend            Frontend
    backend             Backend
    testers             Testadores
    devops              DevOps
    analytics           Analytics

EXEMPLOS:
    # Instalar agente específico
    $0 --agent product-manager --dest ~/meu-projeto/.claude/agents/

    # Instalar categoria completa
    $0 --category strategists --dest ~/meu-projeto/.claude/agents/

    # Listar agentes disponíveis
    $0 --list
EOF
}

list_agents() {
    echo -e "${BLUE}Agentes disponíveis:${NC}\n"

    for category in "$AGENTS_DIR"/*; do
        if [ -d "$category" ]; then
            category_name=$(basename "$category")
            echo -e "${GREEN}$category_name:${NC}"

            for agent in "$category"/*.md; do
                if [ -f "$agent" ] && [ "$(basename "$agent")" != "README.md" ]; then
                    agent_name=$(basename "$agent" .md)
                    echo "  - $agent_name"
                fi
            done
            echo ""
        fi
    done
}

install_agent() {
    local agent_name=$1
    local dest=$2

    # Procurar o agente em todas as categorias
    local found=false

    for category in "$AGENTS_DIR"/*; do
        if [ -d "$category" ]; then
            local agent_file="$category/$agent_name.md"

            if [ -f "$agent_file" ]; then
                mkdir -p "$dest"
                cp "$agent_file" "$dest/"
                echo -e "${GREEN}✓${NC} Agente '$agent_name' instalado em $dest"
                found=true
                break
            fi
        fi
    done

    if [ "$found" = false ]; then
        echo -e "${RED}✗${NC} Agente '$agent_name' não encontrado"
        exit 1
    fi
}

install_category() {
    local category=$1
    local dest=$2
    local category_dir="$AGENTS_DIR/$category"

    if [ ! -d "$category_dir" ]; then
        echo -e "${RED}✗${NC} Categoria '$category' não encontrada"
        exit 1
    fi

    local count=0
    mkdir -p "$dest"

    for agent in "$category_dir"/*.md; do
        if [ -f "$agent" ] && [ "$(basename "$agent")" != "README.md" ]; then
            cp "$agent" "$dest/"
            agent_name=$(basename "$agent" .md)
            echo -e "${GREEN}✓${NC} Agente '$agent_name' instalado"
            ((count++))
        fi
    done

    echo -e "\n${GREEN}$count${NC} agente(s) instalado(s) em $dest"
}

# Parse argumentos
AGENT=""
CATEGORY=""
DEST=""
LIST=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --agent)
            AGENT="$2"
            shift 2
            ;;
        --category)
            CATEGORY="$2"
            shift 2
            ;;
        --dest)
            DEST="$2"
            shift 2
            ;;
        --list)
            LIST=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo -e "${RED}Opção desconhecida: $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

# Executar ação
if [ "$LIST" = true ]; then
    list_agents
    exit 0
fi

if [ -z "$DEST" ]; then
    echo -e "${RED}✗${NC} Diretório de destino (--dest) é obrigatório"
    show_help
    exit 1
fi

if [ -n "$AGENT" ]; then
    install_agent "$AGENT" "$DEST"
elif [ -n "$CATEGORY" ]; then
    install_category "$CATEGORY" "$DEST"
else
    echo -e "${RED}✗${NC} Especifique --agent ou --category"
    show_help
    exit 1
fi
