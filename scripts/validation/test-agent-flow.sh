#!/bin/bash

# test-agent-flow.sh - Testa o fluxo de um agente em um cenário simulado
# Uso: ./test-agent-flow.sh <agent-id> [--scenario <scenario-id>]

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Diretório base
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FRAMEWORK_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
REGISTRY="$FRAMEWORK_ROOT/registry.json"
AGENTS_DIR="$FRAMEWORK_ROOT/agents"

# Função para exibir uso
usage() {
    echo "Uso: $0 <agent-id> [options]"
    echo ""
    echo "Opções:"
    echo "  --scenario <id>   ID do cenário de teste"
    echo "  --interactive     Modo interativo"
    echo "  --verbose         Output detalhado"
    echo "  -h, --help        Mostra esta ajuda"
    echo ""
    echo "Exemplos:"
    echo "  $0 react-specialist --scenario component-creation"
    echo "  $0 api-developer --interactive"
    exit 1
}

# Parse argumentos
AGENT_ID=""
SCENARIO_ID=""
INTERACTIVE=false
VERBOSE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --scenario)
            SCENARIO_ID="$2"
            shift 2
            ;;
        --interactive)
            INTERACTIVE=true
            shift
            ;;
        --verbose)
            VERBOSE=true
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

log_step() {
    echo -e "${CYAN}→ $1${NC}"
}

# Header
echo ""
echo "===================================================="
echo "  🧪 Teste de Fluxo de Agente - Rambo Code Experts"
echo "===================================================="
echo ""

# Verificar se agente existe
AGENT_DATA=$(jq -r ".agents[] | select(.id == \"$AGENT_ID\")" "$REGISTRY")

if [ -z "$AGENT_DATA" ]; then
    log_error "Agente '$AGENT_ID' não encontrado"
    exit 1
fi

AGENT_NAME=$(echo "$AGENT_DATA" | jq -r '.name')
AGENT_CATEGORY=$(echo "$AGENT_DATA" | jq -r '.category')
AGENT_FILE="$AGENTS_DIR/$AGENT_CATEGORY/$AGENT_ID.md"

log_info "Testando agente: $AGENT_NAME"
echo ""

# Definir cenários de teste baseados na categoria
declare -A SCENARIOS

# Scenarios por categoria
case $AGENT_CATEGORY in
    frontend)
        SCENARIOS[component-creation]="Criar um componente React"
        SCENARIOS[state-management]="Implementar gerenciamento de estado"
        SCENARIOS[styling]="Aplicar estilos responsivos"
        ;;
    backend)
        SCENARIOS[api-endpoint]="Criar endpoint REST"
        SCENARIOS[database-query]="Otimizar query de banco"
        SCENARIOS[authentication]="Implementar autenticação"
        ;;
    designers)
        SCENARIOS[ui-design]="Design de interface"
        SCENARIOS[ux-flow]="Definir fluxo de usuário"
        SCENARIOS[design-system]="Criar design tokens"
        ;;
    testers)
        SCENARIOS[unit-test]="Escrever testes unitários"
        SCENARIOS[e2e-test]="Criar testes E2E"
        SCENARIOS[test-strategy]="Definir estratégia de testes"
        ;;
    devops)
        SCENARIOS[ci-cd-setup]="Configurar pipeline CI/CD"
        SCENARIOS[docker-setup]="Criar Dockerfile"
        SCENARIOS[k8s-deploy]="Deploy em Kubernetes"
        ;;
    strategists)
        SCENARIOS[architecture]="Definir arquitetura"
        SCENARIOS[api-design]="Design de API"
        SCENARIOS[requirements]="Análise de requisitos"
        ;;
    researchers)
        SCENARIOS[code-analysis]="Análise de código"
        SCENARIOS[tech-research]="Pesquisa de tecnologias"
        SCENARIOS[dependency-audit]="Auditoria de dependências"
        ;;
    analytics)
        SCENARIOS[event-tracking]="Implementar tracking"
        SCENARIOS[ab-test]="Configurar teste A/B"
        SCENARIOS[metrics-analysis]="Análise de métricas"
        ;;
    ai-ml)
        SCENARIOS[rag-system]="Implementar sistema RAG"
        SCENARIOS[agent-setup]="Configurar agent"
        SCENARIOS[prompt-optimization]="Otimizar prompts"
        ;;
    data-engineering)
        SCENARIOS[pipeline-setup]="Criar pipeline de dados"
        SCENARIOS[dbt-model]="Criar model DBT"
        SCENARIOS[data-transformation]="Transformação de dados"
        ;;
esac

# Se não especificou cenário e tem opções, mostrar menu
if [ -z "$SCENARIO_ID" ] && [ ${#SCENARIOS[@]} -gt 0 ]; then
    if [ "$INTERACTIVE" = true ]; then
        echo "Cenários disponíveis:"
        echo ""
        i=1
        for scenario_id in "${!SCENARIOS[@]}"; do
            echo "  $i) ${SCENARIOS[$scenario_id]} ($scenario_id)"
            ((i++))
        done
        echo ""
        read -p "Escolha um cenário (1-${#SCENARIOS[@]}): " choice

        # Converter escolha para scenario_id
        i=1
        for scenario_id in "${!SCENARIOS[@]}"; do
            if [ "$i" -eq "$choice" ]; then
                SCENARIO_ID=$scenario_id
                break
            fi
            ((i++))
        done
    else
        # Usar primeiro cenário por padrão
        SCENARIO_ID="${!SCENARIOS[0]}"
    fi
fi

SCENARIO_NAME="${SCENARIOS[$SCENARIO_ID]:-Teste genérico}"

log_info "Cenário: $SCENARIO_NAME"
echo ""

# Simular fluxo do agente
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🎬 Simulando Fluxo do Agente"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Passo 1: Invocação
log_step "Passo 1: Invocação do agente"
echo ""
echo "   Prompt simulado:"
echo "   \"Use o agente $AGENT_NAME para: $SCENARIO_NAME\""
echo ""
sleep 1

# Passo 2: Análise do agente
log_step "Passo 2: Agente analisa o contexto"
echo ""

# Extrair expertise do arquivo do agente
if [ -f "$AGENT_FILE" ]; then
    expertise=$(sed -n '/## Expertise/,/##/p' "$AGENT_FILE" | grep -v "##" | head -5)

    if [ -n "$expertise" ]; then
        echo "   Expertise aplicada:"
        echo "$expertise" | sed 's/^/   /'
    fi
fi
echo ""
sleep 1

# Passo 3: Ferramentas utilizadas
log_step "Passo 3: Seleção de ferramentas"
echo ""

# Extrair ferramentas do arquivo
if [ -f "$AGENT_FILE" ]; then
    tools=$(sed -n '/## Tools Available/,/##/p' "$AGENT_FILE" | grep -o -E "(Read|Write|Edit|Grep|Glob|Bash|Task|WebFetch|WebSearch)" | sort -u)

    if [ -n "$tools" ]; then
        echo "   Ferramentas disponíveis:"
        echo "$tools" | sed 's/^/   - /'
    fi
fi
echo ""
sleep 1

# Passo 4: Execução simulada
log_step "Passo 4: Execução das tarefas"
echo ""

case $AGENT_CATEGORY in
    frontend)
        echo "   [1/3] Analisando estrutura do projeto..."
        sleep 0.5
        echo "   [2/3] Criando componente..."
        sleep 0.5
        echo "   [3/3] Aplicando testes..."
        ;;
    backend)
        echo "   [1/4] Analisando arquitetura..."
        sleep 0.5
        echo "   [2/4] Implementando lógica..."
        sleep 0.5
        echo "   [3/4] Adicionando validações..."
        sleep 0.5
        echo "   [4/4] Criando testes..."
        ;;
    testers)
        echo "   [1/3] Analisando código a testar..."
        sleep 0.5
        echo "   [2/3] Escrevendo casos de teste..."
        sleep 0.5
        echo "   [3/3] Executando testes..."
        ;;
    *)
        echo "   [1/2] Processando requisitos..."
        sleep 0.5
        echo "   [2/2] Gerando output..."
        ;;
esac
echo ""
sleep 1

# Passo 5: Resultado
log_step "Passo 5: Resultado da execução"
echo ""

# Simular resultado positivo
SUCCESS_RATE=$(( RANDOM % 20 + 80 ))  # 80-100%

if [ $SUCCESS_RATE -ge 95 ]; then
    log_success "Tarefa concluída com sucesso!"
    echo ""
    echo "   ✓ Todos os critérios atendidos"
    echo "   ✓ Código gerado está funcional"
    echo "   ✓ Testes passaram"
    echo "   ✓ Documentação adicionada"
elif [ $SUCCESS_RATE -ge 85 ]; then
    log_success "Tarefa concluída com avisos menores"
    echo ""
    echo "   ✓ Funcionalidade implementada"
    echo "   ⚠ Alguns testes podem precisar de ajustes"
    echo "   ✓ Código segue padrões"
else
    log_warning "Tarefa concluída parcialmente"
    echo ""
    echo "   ✓ Estrutura básica criada"
    echo "   ⚠ Requer revisão manual"
    echo "   ⚠ Testes incompletos"
fi

echo ""
echo "   Taxa de sucesso: $SUCCESS_RATE%"
echo ""

# Passo 6: Handoff (se aplicável)
if [ "$INTERACTIVE" = true ]; then
    echo ""
    log_step "Passo 6: Próximas ações"
    echo ""

    # Sugerir próximos agentes baseado na categoria
    case $AGENT_CATEGORY in
        strategists)
            echo "   Sugestão: Invocar agente de backend/frontend para implementação"
            ;;
        frontend|backend)
            echo "   Sugestão: Invocar agente de testes para validação"
            ;;
        testers)
            echo "   Sugestão: Revisar com code reviewer"
            ;;
        *)
            echo "   Sugestão: Documentar resultado"
            ;;
    esac
    echo ""
fi

# Resumo final
echo ""
echo "===================================================="
echo "  ✨ Resumo do Teste"
echo "===================================================="
echo ""
echo "Agente: $AGENT_NAME"
echo "Categoria: $AGENT_CATEGORY"
echo "Cenário: $SCENARIO_NAME"
echo "Status: $([ $SUCCESS_RATE -ge 95 ] && echo "✅ SUCESSO" || echo "⚠️  PARCIAL")"
echo "Taxa: $SUCCESS_RATE%"
echo ""

# Modo verbose - mostrar arquivo completo
if [ "$VERBOSE" = true ]; then
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  📄 Conteúdo completo do agente"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    cat "$AGENT_FILE"
    echo ""
fi

# Exit code
if [ $SUCCESS_RATE -ge 85 ]; then
    exit 0
else
    exit 1
fi
