#!/bin/bash

# validate-agent.sh - Valida se um agente específico está funcional
# Uso: ./validate-agent.sh <agent-id> [--project <project-id>]

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Diretório base
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FRAMEWORK_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
AGENTS_DIR="$FRAMEWORK_ROOT/agents"
REGISTRY="$FRAMEWORK_ROOT/registry.json"

# Função para exibir uso
usage() {
    echo "Uso: $0 <agent-id> [options]"
    echo ""
    echo "Opções:"
    echo "  --project <id>    ID do projeto para validar contexto"
    echo "  --verbose         Output detalhado"
    echo "  --report          Gera relatório JSON"
    echo "  -h, --help        Mostra esta ajuda"
    echo ""
    echo "Exemplos:"
    echo "  $0 react-specialist"
    echo "  $0 api-developer --project 1 --verbose"
    exit 1
}

# Parse argumentos
AGENT_ID=""
PROJECT_ID=""
VERBOSE=false
GENERATE_REPORT=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --project)
            PROJECT_ID="$2"
            shift 2
            ;;
        --verbose)
            VERBOSE=true
            shift
            ;;
        --report)
            GENERATE_REPORT=true
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            if [ -z "$AGENT_ID" ]; then
                AGENT_ID="$1"
            fi
            shift
            ;;
    esac
done

if [ -z "$AGENT_ID" ]; then
    echo -e "${RED}❌ Erro: Agent ID é obrigatório${NC}"
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

# Início da validação
echo ""
echo "================================================"
echo "  🔍 Validador de Agentes - Rambo Code Experts"
echo "================================================"
echo ""

log_info "Validando agente: $AGENT_ID"

# 1. Verificar se o agente existe no registry
log_info "Verificando registro do agente..."

if ! command -v jq &> /dev/null; then
    log_error "jq não está instalado. Instale com: sudo apt-get install jq"
    exit 1
fi

AGENT_DATA=$(jq -r ".agents[] | select(.id == \"$AGENT_ID\")" "$REGISTRY")

if [ -z "$AGENT_DATA" ]; then
    log_error "Agente '$AGENT_ID' não encontrado no registry.json"
    exit 1
fi

log_success "Agente encontrado no registry"

# Extrair informações do agente
AGENT_NAME=$(echo "$AGENT_DATA" | jq -r '.name')
AGENT_CATEGORY=$(echo "$AGENT_DATA" | jq -r '.category')
AGENT_VERSION=$(echo "$AGENT_DATA" | jq -r '.version')
AGENT_DESCRIPTION=$(echo "$AGENT_DATA" | jq -r '.description')

if [ "$VERBOSE" = true ]; then
    echo ""
    echo "Informações do Agente:"
    echo "  Nome: $AGENT_NAME"
    echo "  Categoria: $AGENT_CATEGORY"
    echo "  Versão: $AGENT_VERSION"
    echo "  Descrição: $AGENT_DESCRIPTION"
    echo ""
fi

# 2. Verificar se o arquivo do agente existe
log_info "Verificando arquivo do agente..."

AGENT_FILE="$AGENTS_DIR/$AGENT_CATEGORY/$AGENT_ID.md"

if [ ! -f "$AGENT_FILE" ]; then
    log_error "Arquivo do agente não encontrado: $AGENT_FILE"
    exit 1
fi

log_success "Arquivo do agente encontrado"

# 3. Validar estrutura do arquivo
log_info "Validando estrutura do arquivo..."

# Verificar seções obrigatórias
REQUIRED_SECTIONS=("# $AGENT_NAME" "## Expertise" "## Tools Available")
MISSING_SECTIONS=()

for section in "${REQUIRED_SECTIONS[@]}"; do
    if ! grep -q "$section" "$AGENT_FILE"; then
        MISSING_SECTIONS+=("$section")
    fi
done

if [ ${#MISSING_SECTIONS[@]} -gt 0 ]; then
    log_warning "Seções faltando no arquivo:"
    for section in "${MISSING_SECTIONS[@]}"; do
        echo "    - $section"
    done
else
    log_success "Estrutura do arquivo válida"
fi

# 4. Verificar dependências
log_info "Verificando dependências..."

# Extrair ferramentas mencionadas
TOOLS_MENTIONED=$(grep -o -E "(Read|Write|Edit|Grep|Glob|Bash|Task|WebFetch|WebSearch)" "$AGENT_FILE" | sort -u)

if [ "$VERBOSE" = true ] && [ -n "$TOOLS_MENTIONED" ]; then
    echo ""
    echo "Ferramentas mencionadas:"
    echo "$TOOLS_MENTIONED" | sed 's/^/    - /'
    echo ""
fi

# 5. Validar contexto do projeto (se fornecido)
if [ -n "$PROJECT_ID" ]; then
    log_info "Validando contexto do projeto $PROJECT_ID..."

    PROJECT_FILE="$FRAMEWORK_ROOT/PROJECT_IDEAS.md"

    if [ ! -f "$PROJECT_FILE" ]; then
        log_warning "Arquivo de projetos não encontrado"
    else
        # Verificar se o agente está listado no projeto
        PROJECT_SECTION=$(awk "/## .* Projeto $PROJECT_ID:/,/^## /" "$PROJECT_FILE")

        if echo "$PROJECT_SECTION" | grep -q "$AGENT_NAME"; then
            log_success "Agente está listado no Projeto $PROJECT_ID"
        else
            log_warning "Agente não está listado no Projeto $PROJECT_ID"
        fi
    fi
fi

# 6. Análise de qualidade
log_info "Analisando qualidade do agente..."

WORD_COUNT=$(wc -w < "$AGENT_FILE")
LINE_COUNT=$(wc -l < "$AGENT_FILE")

if [ "$VERBOSE" = true ]; then
    echo ""
    echo "Estatísticas:"
    echo "  Palavras: $WORD_COUNT"
    echo "  Linhas: $LINE_COUNT"
    echo ""
fi

QUALITY_SCORE=0

# Pontuação baseada em completude
[ $WORD_COUNT -gt 100 ] && QUALITY_SCORE=$((QUALITY_SCORE + 25))
[ $WORD_COUNT -gt 300 ] && QUALITY_SCORE=$((QUALITY_SCORE + 25))
[ ${#MISSING_SECTIONS[@]} -eq 0 ] && QUALITY_SCORE=$((QUALITY_SCORE + 25))
[ $LINE_COUNT -gt 50 ] && QUALITY_SCORE=$((QUALITY_SCORE + 25))

# Resultado final
echo ""
echo "================================================"
echo "  📊 Resultado da Validação"
echo "================================================"
echo ""
echo "Agente: $AGENT_NAME ($AGENT_ID)"
echo "Categoria: $AGENT_CATEGORY"
echo "Versão: $AGENT_VERSION"
echo ""

if [ ${#MISSING_SECTIONS[@]} -eq 0 ]; then
    echo -e "${GREEN}Status: ✅ VÁLIDO${NC}"
else
    echo -e "${YELLOW}Status: ⚠️  VÁLIDO COM AVISOS${NC}"
fi

echo "Score de Qualidade: $QUALITY_SCORE/100"
echo ""

# Gerar relatório JSON se solicitado
if [ "$GENERATE_REPORT" = true ]; then
    REPORT_FILE="/tmp/agent-validation-$AGENT_ID-$(date +%s).json"

    cat > "$REPORT_FILE" << EOF
{
  "agent_id": "$AGENT_ID",
  "agent_name": "$AGENT_NAME",
  "category": "$AGENT_CATEGORY",
  "version": "$AGENT_VERSION",
  "timestamp": "$(date -Iseconds)",
  "validation": {
    "registry_exists": true,
    "file_exists": true,
    "structure_valid": $([ ${#MISSING_SECTIONS[@]} -eq 0 ] && echo "true" || echo "false"),
    "missing_sections": $(printf '%s\n' "${MISSING_SECTIONS[@]}" | jq -R . | jq -s .),
    "quality_score": $QUALITY_SCORE,
    "word_count": $WORD_COUNT,
    "line_count": $LINE_COUNT
  }
}
EOF

    log_success "Relatório gerado: $REPORT_FILE"
fi

# Exit code baseado no resultado
if [ ${#MISSING_SECTIONS[@]} -eq 0 ]; then
    exit 0
else
    exit 1
fi
