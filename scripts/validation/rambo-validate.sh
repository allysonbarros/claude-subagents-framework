#!/bin/bash

# rambo-validate.sh - Script master para todos os comandos de validação
# Uso: ./rambo-validate.sh <command> [args...]

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Diretório base
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Banner
show_banner() {
    echo -e "${MAGENTA}"
    cat << 'EOF'
    ____                  __
   / __ \____ _____ ___  / /_  ____
  / /_/ / __ `/ __ `__ \/ __ \/ __ \
 / _, _/ /_/ / / / / / / /_/ / /_/ /
/_/ |_|\__,_/_/ /_/ /_/_.___/\____/

  Code Experts - Validation Tools
EOF
    echo -e "${NC}"
    echo ""
}

# Função para exibir uso
usage() {
    show_banner

    echo -e "${BOLD}Uso:${NC} $0 <command> [args...]"
    echo ""
    echo -e "${BOLD}Comandos Disponíveis:${NC}"
    echo ""
    echo -e "  ${CYAN}agent${NC} <id> [options]"
    echo "    Valida um agente específico"
    echo "    Exemplo: $0 agent react-specialist --verbose"
    echo ""
    echo -e "  ${CYAN}project${NC} <id> [options]"
    echo "    Valida todos os agentes de um projeto"
    echo "    Exemplo: $0 project 1 --summary"
    echo ""
    echo -e "  ${CYAN}coverage${NC} [options]"
    echo "    Gera relatório de cobertura"
    echo "    Exemplo: $0 coverage --format html --output report.html"
    echo ""
    echo -e "  ${CYAN}test${NC} <agent-id> [options]"
    echo "    Testa o fluxo de um agente"
    echo "    Exemplo: $0 test api-developer --interactive"
    echo ""
    echo -e "  ${CYAN}all${NC}"
    echo "    Valida todos os projetos (resumo)"
    echo "    Exemplo: $0 all"
    echo ""
    echo -e "  ${CYAN}report${NC}"
    echo "    Gera relatório completo HTML"
    echo "    Exemplo: $0 report"
    echo ""
    echo -e "  ${CYAN}list${NC}"
    echo "    Lista todos os agentes disponíveis"
    echo "    Exemplo: $0 list"
    echo ""
    echo -e "  ${CYAN}help${NC}"
    echo "    Mostra esta ajuda"
    echo ""
    echo -e "${BOLD}Projetos Disponíveis:${NC}"
    echo "  1 - SaaS Analytics Platform"
    echo "  2 - AI-Powered Code Assistant"
    echo "  3 - Data Pipeline Orchestration"
    echo "  4 - Design System & Components"
    echo "  5 - Enterprise Security Platform"
    echo "  6 - Multi-Agent Collaboration"
    echo "  7 - Code Quality Platform"
    echo "  8 - Full-Stack Social Media"
    echo "  9 - E-Learning Platform"
    echo "  10 - E-Commerce Platform"
    echo ""
    echo -e "${BOLD}Exemplos de Uso:${NC}"
    echo ""
    echo "  # Validar um agente específico"
    echo "  $0 agent react-specialist"
    echo ""
    echo "  # Validar projeto completo"
    echo "  $0 project 1"
    echo ""
    echo "  # Gerar relatório HTML"
    echo "  $0 report"
    echo ""
    echo "  # Testar agente interativamente"
    echo "  $0 test api-developer --interactive"
    echo ""
    echo "  # Validar tudo"
    echo "  $0 all"
    echo ""
}

# Parse comando
COMMAND="${1:-}"

if [ -z "$COMMAND" ]; then
    usage
    exit 1
fi

shift || true  # Remove o primeiro argumento

# Executar comando
case $COMMAND in
    agent|a)
        show_banner
        exec "$SCRIPT_DIR/validate-agent.sh" "$@"
        ;;

    project|p)
        show_banner
        exec "$SCRIPT_DIR/validate-project.sh" "$@"
        ;;

    coverage|c)
        show_banner
        exec "$SCRIPT_DIR/generate-coverage-report.sh" "$@"
        ;;

    test|t)
        show_banner
        exec "$SCRIPT_DIR/test-agent-flow.sh" "$@"
        ;;

    all)
        show_banner
        echo -e "${BLUE}Validando todos os projetos...${NC}"
        echo ""

        FAILED=0
        for i in {1..10}; do
            echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
            echo -e "${BOLD}Projeto $i${NC}"
            echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

            if "$SCRIPT_DIR/validate-project.sh" "$i" --summary; then
                echo ""
            else
                FAILED=$((FAILED + 1))
                echo ""
            fi
        done

        echo ""
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${BOLD}Resumo Final${NC}"
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""

        if [ $FAILED -eq 0 ]; then
            echo -e "${GREEN}✅ Todos os 10 projetos válidos!${NC}"
            exit 0
        else
            echo -e "${RED}❌ $FAILED projeto(s) com problemas${NC}"
            echo -e "${YELLOW}⚠️  Execute individualmente para detalhes${NC}"
            exit 1
        fi
        ;;

    report|r)
        show_banner
        echo -e "${BLUE}Gerando relatório completo...${NC}"
        echo ""

        REPORT_FILE="/tmp/rambo-validation-report-$(date +%Y%m%d-%H%M%S).html"

        "$SCRIPT_DIR/generate-coverage-report.sh" --format html --output "$REPORT_FILE"

        echo ""
        echo -e "${GREEN}✅ Relatório gerado: $REPORT_FILE${NC}"
        echo ""

        # Tentar abrir no navegador
        if command -v xdg-open &> /dev/null; then
            echo -e "${BLUE}Abrindo no navegador...${NC}"
            xdg-open "$REPORT_FILE" 2>/dev/null || true
        elif command -v open &> /dev/null; then
            echo -e "${BLUE}Abrindo no navegador...${NC}"
            open "$REPORT_FILE" 2>/dev/null || true
        else
            echo -e "${YELLOW}Abra manualmente: $REPORT_FILE${NC}"
        fi
        ;;

    list|ls)
        show_banner
        echo -e "${BLUE}Listando todos os agentes...${NC}"
        echo ""

        FRAMEWORK_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
        REGISTRY="$FRAMEWORK_ROOT/registry.json"

        if ! command -v jq &> /dev/null; then
            echo -e "${RED}❌ jq não está instalado${NC}"
            exit 1
        fi

        CATEGORIES=$(jq -r '.categories[] | .id' "$REGISTRY")

        for category_id in $CATEGORIES; do
            category_name=$(jq -r ".categories[] | select(.id == \"$category_id\") | .name" "$REGISTRY")

            echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
            echo -e "${BOLD}$category_name${NC}"
            echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
            echo ""

            jq -r ".agents[] | select(.category == \"$category_id\") | \"  ${GREEN}•${NC} \(.name) ${YELLOW}(\(.id))${NC}\"" "$REGISTRY" | while read -r line; do
                echo -e "$line"
            done

            echo ""
        done

        TOTAL=$(jq '.agents | length' "$REGISTRY")
        echo -e "${BOLD}Total: $TOTAL agentes${NC}"
        echo ""
        ;;

    help|h|-h|--help)
        usage
        ;;

    *)
        echo -e "${RED}❌ Comando inválido: $COMMAND${NC}"
        echo ""
        usage
        exit 1
        ;;
esac
