#!/bin/bash

# Script para listar agentes disponíveis no framework

FRAMEWORK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AGENTS_DIR="$FRAMEWORK_DIR/agents"
REGISTRY="$FRAMEWORK_DIR/registry.json"

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

show_help() {
    cat << EOF
Uso: $0 [OPÇÕES]

Lista agentes disponíveis no Claude Subagents Framework.

OPÇÕES:
    --category NOME     Filtra por categoria
    --detailed          Mostra informações detalhadas
    -h, --help          Mostra esta ajuda

EXEMPLOS:
    # Listar todos os agentes
    $0

    # Listar agentes de uma categoria
    $0 --category backend

    # Listar com detalhes
    $0 --detailed
EOF
}

list_agents_simple() {
    local filter_category=$1

    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}  Claude Subagents Framework - Agentes Disponíveis${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}\n"

    for category in "$AGENTS_DIR"/*; do
        if [ -d "$category" ]; then
            category_name=$(basename "$category")

            # Filtrar categoria se especificado
            if [ -n "$filter_category" ] && [ "$category_name" != "$filter_category" ]; then
                continue
            fi

            # Mapear nomes para português
            case $category_name in
                strategists) display_name="Estrategistas" ;;
                researchers) display_name="Pesquisadores" ;;
                designers) display_name="Designers" ;;
                frontend) display_name="Frontend" ;;
                backend) display_name="Backend" ;;
                testers) display_name="Testadores" ;;
                devops) display_name="DevOps" ;;
                analytics) display_name="Analytics" ;;
                *) display_name=$category_name ;;
            esac

            echo -e "${GREEN}▸ $display_name${NC} ${YELLOW}($category_name)${NC}"

            local count=0
            for agent in "$category"/*.md; do
                if [ -f "$agent" ] && [ "$(basename "$agent")" != "README.md" ]; then
                    agent_name=$(basename "$agent" .md)
                    echo "  • $agent_name"
                    ((count++))
                fi
            done

            if [ $count -eq 0 ]; then
                echo -e "  ${YELLOW}(nenhum agente disponível)${NC}"
            fi

            echo ""
        fi
    done
}

list_agents_detailed() {
    local filter_category=$1

    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}  Agentes Disponíveis (Detalhado)${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}\n"

    for category in "$AGENTS_DIR"/*; do
        if [ -d "$category" ]; then
            category_name=$(basename "$category")

            # Filtrar categoria se especificado
            if [ -n "$filter_category" ] && [ "$category_name" != "$filter_category" ]; then
                continue
            fi

            for agent in "$category"/*.md; do
                if [ -f "$agent" ] && [ "$(basename "$agent")" != "README.md" ]; then
                    agent_name=$(basename "$agent" .md)

                    echo -e "${GREEN}▸ $agent_name${NC} ${YELLOW}[$category_name]${NC}"

                    # Extrair descrição do arquivo
                    local description=$(sed -n '/^## Descrição/,/^##/p' "$agent" | sed '1d;$d' | head -3 | sed 's/^[[:space:]]*//')

                    if [ -n "$description" ]; then
                        echo -e "${CYAN}$description${NC}"
                    fi

                    # Extrair versão se existir
                    local version=$(grep -m 1 "^## Versão" "$agent" | sed 's/## Versão//' | xargs)
                    if [ -n "$version" ]; then
                        echo -e "  Versão: $version"
                    fi

                    echo ""
                fi
            done
        fi
    done
}

# Parse argumentos
CATEGORY=""
DETAILED=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --category)
            CATEGORY="$2"
            shift 2
            ;;
        --detailed)
            DETAILED=true
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

# Executar listagem
if [ "$DETAILED" = true ]; then
    list_agents_detailed "$CATEGORY"
else
    list_agents_simple "$CATEGORY"
fi
