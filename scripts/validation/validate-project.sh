#!/bin/bash

# validate-project.sh - Valida todos os agentes de um projeto específico
# Uso: ./validate-project.sh <project-id> [--report]

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Diretório base
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FRAMEWORK_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
REGISTRY="$FRAMEWORK_ROOT/registry.json"
PROJECT_FILE="$FRAMEWORK_ROOT/PROJECT_IDEAS.md"

# Função para exibir uso
usage() {
    echo "Uso: $0 <project-id> [options]"
    echo ""
    echo "IDs de Projetos disponíveis:"
    echo "  1 - SaaS Analytics Platform"
    echo "  2 - AI-Powered Code Assistant"
    echo "  3 - Data Pipeline Orchestration Platform"
    echo "  4 - Design System e Component Library"
    echo "  5 - Enterprise Security Platform"
    echo "  6 - Multi-Agent Collaboration System"
    echo "  7 - Code Quality and Analysis Platform"
    echo "  8 - Full-Stack Social Media App"
    echo "  9 - E-Learning Platform with AI Tutoring"
    echo "  10 - E-Commerce Platform with Recommendations"
    echo ""
    echo "Opções:"
    echo "  --report          Gera relatório completo"
    echo "  --summary         Mostra apenas resumo"
    echo "  -h, --help        Mostra esta ajuda"
    exit 1
}

# Parse argumentos
PROJECT_ID=""
GENERATE_REPORT=false
SUMMARY_ONLY=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --report)
            GENERATE_REPORT=true
            shift
            ;;
        --summary)
            SUMMARY_ONLY=true
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            if [ -z "$PROJECT_ID" ]; then
                PROJECT_ID="$1"
            fi
            shift
            ;;
    esac
done

if [ -z "$PROJECT_ID" ]; then
    echo -e "${RED}❌ Erro: Project ID é obrigatório${NC}"
    usage
fi

# Função para log
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Header
echo ""
echo "===================================================="
echo "  🎯 Validador de Projetos - Rambo Code Experts"
echo "===================================================="
echo ""

# Mapear ID para nome do projeto
declare -A PROJECT_NAMES
PROJECT_NAMES[1]="SaaS Analytics Platform"
PROJECT_NAMES[2]="AI-Powered Code Assistant"
PROJECT_NAMES[3]="Data Pipeline Orchestration Platform"
PROJECT_NAMES[4]="Design System e Component Library"
PROJECT_NAMES[5]="Enterprise Security Platform"
PROJECT_NAMES[6]="Multi-Agent Collaboration System"
PROJECT_NAMES[7]="Code Quality and Analysis Platform"
PROJECT_NAMES[8]="Full-Stack Social Media App"
PROJECT_NAMES[9]="E-Learning Platform with AI Tutoring"
PROJECT_NAMES[10]="E-Commerce Platform with Recommendations"

PROJECT_NAME="${PROJECT_NAMES[$PROJECT_ID]}"

if [ -z "$PROJECT_NAME" ]; then
    log_error "ID de projeto inválido: $PROJECT_ID"
    usage
fi

log_info "Validando projeto: $PROJECT_NAME (ID: $PROJECT_ID)"
echo ""

# Extrair agentes do projeto
log_info "Extraindo lista de agentes do projeto..."

# Extrair seção do projeto
PROJECT_SECTION=$(awk "/## .* Projeto $PROJECT_ID:/,/^## /" "$PROJECT_FILE")

# Extrair agentes da seção "Agentes Validados"
AGENTS_LINE=$(echo "$PROJECT_SECTION" | grep -A 1 "### Agentes Validados")

# Lista temporária de agentes
TEMP_AGENTS_FILE="/tmp/project-${PROJECT_ID}-agents.txt"

# Extrair nomes dos agentes mencionados no fluxo de validação
echo "$PROJECT_SECTION" | grep -oP '\d+\.\s+\K[^→]+(?=→)' | sed 's/^ *//;s/ *$//' > "$TEMP_AGENTS_FILE"

# Converter nomes para IDs
AGENT_IDS=()

while IFS= read -r agent_name; do
    # Buscar ID correspondente no registry
    agent_id=$(jq -r ".agents[] | select(.name == \"$agent_name\") | .id" "$REGISTRY")

    if [ -n "$agent_id" ] && [ "$agent_id" != "null" ]; then
        AGENT_IDS+=("$agent_id")
    fi
done < "$TEMP_AGENTS_FILE"

# Remover duplicatas
AGENT_IDS=($(printf '%s\n' "${AGENT_IDS[@]}" | sort -u))

TOTAL_AGENTS=${#AGENT_IDS[@]}

if [ $TOTAL_AGENTS -eq 0 ]; then
    log_error "Nenhum agente encontrado para o projeto $PROJECT_ID"
    exit 1
fi

log_success "Encontrados $TOTAL_AGENTS agentes para validar"
echo ""

# Arrays para resultados
VALID_AGENTS=()
INVALID_AGENTS=()
WARNING_AGENTS=()

# Validar cada agente
echo "================================================"
echo "  🔍 Validando Agentes"
echo "================================================"
echo ""

for agent_id in "${AGENT_IDS[@]}"; do
    if [ "$SUMMARY_ONLY" = false ]; then
        echo -e "${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    fi

    # Executar validação
    if [ "$SUMMARY_ONLY" = true ]; then
        # Validação silenciosa
        if "$SCRIPT_DIR/validate-agent.sh" "$agent_id" --project "$PROJECT_ID" > /dev/null 2>&1; then
            VALID_AGENTS+=("$agent_id")
            echo -e "${GREEN}✅${NC} $agent_id"
        else
            # Verificar se tem warnings
            if "$SCRIPT_DIR/validate-agent.sh" "$agent_id" --project "$PROJECT_ID" 2>&1 | grep -q "VÁLIDO COM AVISOS"; then
                WARNING_AGENTS+=("$agent_id")
                echo -e "${YELLOW}⚠️${NC}  $agent_id"
            else
                INVALID_AGENTS+=("$agent_id")
                echo -e "${RED}❌${NC} $agent_id"
            fi
        fi
    else
        # Validação detalhada
        if "$SCRIPT_DIR/validate-agent.sh" "$agent_id" --project "$PROJECT_ID"; then
            VALID_AGENTS+=("$agent_id")
        else
            if "$SCRIPT_DIR/validate-agent.sh" "$agent_id" --project "$PROJECT_ID" 2>&1 | grep -q "warning"; then
                WARNING_AGENTS+=("$agent_id")
            else
                INVALID_AGENTS+=("$agent_id")
            fi
        fi
        echo ""
    fi
done

# Resumo Final
echo ""
echo "===================================================="
echo "  📊 Resumo da Validação"
echo "===================================================="
echo ""
echo "Projeto: $PROJECT_NAME"
echo "Total de Agentes: $TOTAL_AGENTS"
echo ""
echo -e "${GREEN}✅ Válidos: ${#VALID_AGENTS[@]}${NC}"
echo -e "${YELLOW}⚠️  Com Avisos: ${#WARNING_AGENTS[@]}${NC}"
echo -e "${RED}❌ Inválidos: ${#INVALID_AGENTS[@]}${NC}"
echo ""

# Calcular taxa de sucesso
SUCCESS_RATE=$(( (${#VALID_AGENTS[@]} * 100) / $TOTAL_AGENTS ))
echo "Taxa de Sucesso: $SUCCESS_RATE%"
echo ""

# Mostrar agentes com problemas
if [ ${#WARNING_AGENTS[@]} -gt 0 ]; then
    echo -e "${YELLOW}Agentes com Avisos:${NC}"
    for agent_id in "${WARNING_AGENTS[@]}"; do
        agent_name=$(jq -r ".agents[] | select(.id == \"$agent_id\") | .name" "$REGISTRY")
        echo "  - $agent_name ($agent_id)"
    done
    echo ""
fi

if [ ${#INVALID_AGENTS[@]} -gt 0 ]; then
    echo -e "${RED}Agentes Inválidos:${NC}"
    for agent_id in "${INVALID_AGENTS[@]}"; do
        agent_name=$(jq -r ".agents[] | select(.id == \"$agent_id\") | .name" "$REGISTRY")
        echo "  - $agent_name ($agent_id)"
    done
    echo ""
fi

# Gerar relatório se solicitado
if [ "$GENERATE_REPORT" = true ]; then
    REPORT_FILE="/tmp/project-validation-$PROJECT_ID-$(date +%Y%m%d-%H%M%S).json"

    # Converter arrays para JSON
    VALID_JSON=$(printf '%s\n' "${VALID_AGENTS[@]}" | jq -R . | jq -s .)
    WARNING_JSON=$(printf '%s\n' "${WARNING_AGENTS[@]}" | jq -R . | jq -s .)
    INVALID_JSON=$(printf '%s\n' "${INVALID_AGENTS[@]}" | jq -R . | jq -s .)

    cat > "$REPORT_FILE" << EOF
{
  "project_id": $PROJECT_ID,
  "project_name": "$PROJECT_NAME",
  "timestamp": "$(date -Iseconds)",
  "summary": {
    "total_agents": $TOTAL_AGENTS,
    "valid": ${#VALID_AGENTS[@]},
    "warnings": ${#WARNING_AGENTS[@]},
    "invalid": ${#INVALID_AGENTS[@]},
    "success_rate": $SUCCESS_RATE
  },
  "agents": {
    "valid": $VALID_JSON,
    "warnings": $WARNING_JSON,
    "invalid": $INVALID_JSON
  }
}
EOF

    log_success "Relatório gerado: $REPORT_FILE"
    echo ""
fi

# Status final
if [ ${#INVALID_AGENTS[@]} -eq 0 ]; then
    if [ ${#WARNING_AGENTS[@]} -eq 0 ]; then
        echo -e "${GREEN}🎉 Projeto totalmente válido!${NC}"
        exit 0
    else
        echo -e "${YELLOW}⚠️  Projeto válido com avisos${NC}"
        exit 1
    fi
else
    echo -e "${RED}❌ Projeto com problemas${NC}"
    exit 2
fi
