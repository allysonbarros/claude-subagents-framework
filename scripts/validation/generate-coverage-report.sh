#!/bin/bash

# generate-coverage-report.sh - Gera relatório de cobertura de agentes
# Uso: ./generate-coverage-report.sh [--format json|markdown|html]

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
PROJECT_FILE="$FRAMEWORK_ROOT/PROJECT_IDEAS.md"

# Configuração padrão
FORMAT="markdown"
OUTPUT_FILE=""

# Parse argumentos
while [[ $# -gt 0 ]]; do
    case $1 in
        --format)
            FORMAT="$2"
            shift 2
            ;;
        --output)
            OUTPUT_FILE="$2"
            shift 2
            ;;
        -h|--help)
            echo "Uso: $0 [options]"
            echo ""
            echo "Opções:"
            echo "  --format <type>   Formato: json, markdown, html (default: markdown)"
            echo "  --output <file>   Arquivo de saída (default: stdout)"
            echo "  -h, --help        Mostra esta ajuda"
            exit 0
            ;;
        *)
            shift
            ;;
    esac
done

# Se não especificou output, usar stdout ou arquivo padrão
if [ -z "$OUTPUT_FILE" ]; then
    if [ "$FORMAT" != "markdown" ]; then
        OUTPUT_FILE="/tmp/coverage-report-$(date +%Y%m%d-%H%M%S).$FORMAT"
    fi
fi

# Função para log
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}" >&2
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}" >&2
}

# Header
echo "" >&2
echo "====================================================" >&2
echo "  📊 Relatório de Cobertura - Rambo Code Experts" >&2
echo "====================================================" >&2
echo "" >&2

log_info "Coletando dados..."

# Extrair totais
TOTAL_AGENTS=$(jq '.agents | length' "$REGISTRY")
TOTAL_CATEGORIES=$(jq '.categories | length' "$REGISTRY")

# Contar agentes por categoria
declare -A AGENTS_BY_CATEGORY
declare -A CATEGORY_NAMES

while IFS= read -r category_id; do
    category_name=$(jq -r ".categories[] | select(.id == \"$category_id\") | .name" "$REGISTRY")
    count=$(jq -r ".agents[] | select(.category == \"$category_id\") | .id" "$REGISTRY" | wc -l)

    AGENTS_BY_CATEGORY[$category_id]=$count
    CATEGORY_NAMES[$category_id]=$category_name
done < <(jq -r '.categories[].id' "$REGISTRY")

# Análise de cobertura por projeto
declare -A PROJECT_COVERAGE

for project_id in {1..10}; do
    # Extrair agentes mencionados no projeto
    project_section=$(awk "/## .* Projeto $project_id:/,/^## /" "$PROJECT_FILE" 2>/dev/null || echo "")

    if [ -n "$project_section" ]; then
        agent_count=$(echo "$project_section" | grep -oP '\d+\.\s+\K[^→]+(?=→)' | wc -l)
        PROJECT_COVERAGE[$project_id]=$agent_count
    else
        PROJECT_COVERAGE[$project_id]=0
    fi
done

log_success "Dados coletados!"
echo "" >&2

# Gerar relatório baseado no formato
case $FORMAT in
    json)
        log_info "Gerando relatório JSON..."

        # Construir objeto JSON
        {
            echo "{"
            echo "  \"generated_at\": \"$(date -Iseconds)\","
            echo "  \"framework\": {"
            echo "    \"total_agents\": $TOTAL_AGENTS,"
            echo "    \"total_categories\": $TOTAL_CATEGORIES"
            echo "  },"
            echo "  \"categories\": ["

            first=true
            for category_id in "${!AGENTS_BY_CATEGORY[@]}"; do
                if [ "$first" = false ]; then
                    echo "    ,"
                fi
                first=false

                echo "    {"
                echo "      \"id\": \"$category_id\","
                echo "      \"name\": \"${CATEGORY_NAMES[$category_id]}\","
                echo "      \"agent_count\": ${AGENTS_BY_CATEGORY[$category_id]}"
                echo -n "    }"
            done

            echo ""
            echo "  ],"
            echo "  \"projects\": ["

            first=true
            for project_id in {1..10}; do
                if [ "${PROJECT_COVERAGE[$project_id]}" -gt 0 ]; then
                    if [ "$first" = false ]; then
                        echo "    ,"
                    fi
                    first=false

                    echo "    {"
                    echo "      \"id\": $project_id,"
                    echo "      \"agent_count\": ${PROJECT_COVERAGE[$project_id]}"
                    echo -n "    }"
                fi
            done

            echo ""
            echo "  ]"
            echo "}"
        } > "${OUTPUT_FILE:-/dev/stdout}"
        ;;

    markdown)
        log_info "Gerando relatório Markdown..."

        {
            echo "# 📊 Relatório de Cobertura de Agentes"
            echo ""
            echo "**Gerado em:** $(date '+%Y-%m-%d %H:%M:%S')"
            echo ""
            echo "## 📈 Resumo Geral"
            echo ""
            echo "- **Total de Agentes:** $TOTAL_AGENTS"
            echo "- **Total de Categorias:** $TOTAL_CATEGORIES"
            echo "- **Total de Projetos:** 10"
            echo ""
            echo "## 📂 Agentes por Categoria"
            echo ""
            echo "| Categoria | Quantidade | Percentual |"
            echo "|-----------|------------|------------|"

            for category_id in $(jq -r '.categories[].id' "$REGISTRY"); do
                category_name="${CATEGORY_NAMES[$category_id]}"
                count="${AGENTS_BY_CATEGORY[$category_id]}"
                percentage=$(( (count * 100) / TOTAL_AGENTS ))

                printf "| %-20s | %10d | %9d%% |\n" "$category_name" "$count" "$percentage"
            done

            echo ""
            echo "## 🎯 Cobertura por Projeto"
            echo ""
            echo "| Projeto | Agentes Utilizados |"
            echo "|---------|-------------------|"

            declare -A PROJECT_NAMES
            PROJECT_NAMES[1]="SaaS Analytics Platform"
            PROJECT_NAMES[2]="AI-Powered Code Assistant"
            PROJECT_NAMES[3]="Data Pipeline Orchestration"
            PROJECT_NAMES[4]="Design System & Components"
            PROJECT_NAMES[5]="Enterprise Security Platform"
            PROJECT_NAMES[6]="Multi-Agent Collaboration"
            PROJECT_NAMES[7]="Code Quality Platform"
            PROJECT_NAMES[8]="Full-Stack Social Media"
            PROJECT_NAMES[9]="E-Learning Platform"
            PROJECT_NAMES[10]="E-Commerce Platform"

            for project_id in {1..10}; do
                if [ "${PROJECT_COVERAGE[$project_id]}" -gt 0 ]; then
                    printf "| %-30s | %17d |\n" "${PROJECT_NAMES[$project_id]}" "${PROJECT_COVERAGE[$project_id]}"
                fi
            done

            echo ""
            echo "## 🔝 Top Categorias"
            echo ""

            # Ordenar categorias por quantidade
            for category_id in $(jq -r '.categories[].id' "$REGISTRY"); do
                echo "${AGENTS_BY_CATEGORY[$category_id]} ${CATEGORY_NAMES[$category_id]}"
            done | sort -rn | head -5 | while read -r count name; do
                echo "- **$name:** $count agentes"
            done

            echo ""
            echo "## 📋 Lista Completa de Agentes"
            echo ""

            for category_id in $(jq -r '.categories[].id' "$REGISTRY"); do
                category_name="${CATEGORY_NAMES[$category_id]}"

                echo "### $category_name"
                echo ""

                jq -r ".agents[] | select(.category == \"$category_id\") | \"- **\(.name)** (\`\(.id)\`) - \(.description)\"" "$REGISTRY"

                echo ""
            done

            echo "---"
            echo ""
            echo "*Relatório gerado automaticamente pelo Rambo Code Experts Framework*"
        } > "${OUTPUT_FILE:-/dev/stdout}"
        ;;

    html)
        log_info "Gerando relatório HTML..."

        {
            cat << 'EOF'
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Relatório de Cobertura - Rambo Code Experts</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px;
            text-align: center;
        }

        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }

        .header .subtitle {
            font-size: 1.2em;
            opacity: 0.9;
        }

        .content {
            padding: 40px;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .stat-card .number {
            font-size: 3em;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .stat-card .label {
            font-size: 1.1em;
            opacity: 0.9;
        }

        h2 {
            color: #667eea;
            margin: 30px 0 20px 0;
            padding-bottom: 10px;
            border-bottom: 3px solid #667eea;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: #667eea;
            color: white;
            font-weight: 600;
        }

        tr:hover {
            background: #f5f5f5;
        }

        .category-section {
            margin: 30px 0;
            padding: 20px;
            background: #f9f9f9;
            border-radius: 8px;
        }

        .agent-item {
            padding: 10px;
            margin: 10px 0;
            background: white;
            border-left: 4px solid #667eea;
            border-radius: 4px;
        }

        .agent-name {
            font-weight: bold;
            color: #667eea;
        }

        .agent-id {
            color: #999;
            font-family: monospace;
            font-size: 0.9em;
        }

        .footer {
            background: #f9f9f9;
            padding: 20px;
            text-align: center;
            color: #666;
            font-size: 0.9em;
        }

        .progress-bar {
            width: 100%;
            height: 20px;
            background: #e0e0e0;
            border-radius: 10px;
            overflow: hidden;
            margin: 10px 0;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            transition: width 0.3s ease;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📊 Relatório de Cobertura</h1>
            <div class="subtitle">Rambo Code Experts Framework</div>
            <div style="margin-top: 20px; opacity: 0.8;">
EOF
            echo "                Gerado em: $(date '+%Y-%m-%d %H:%M:%S')"
            cat << 'EOF'
            </div>
        </div>

        <div class="content">
            <div class="stats">
                <div class="stat-card">
EOF
            echo "                    <div class=\"number\">$TOTAL_AGENTS</div>"
            cat << 'EOF'
                    <div class="label">Agentes</div>
                </div>
                <div class="stat-card">
EOF
            echo "                    <div class=\"number\">$TOTAL_CATEGORIES</div>"
            cat << 'EOF'
                    <div class="label">Categorias</div>
                </div>
                <div class="stat-card">
                    <div class="number">10</div>
                    <div class="label">Projetos</div>
                </div>
            </div>

            <h2>📂 Agentes por Categoria</h2>
            <table>
                <thead>
                    <tr>
                        <th>Categoria</th>
                        <th>Quantidade</th>
                        <th>Distribuição</th>
                    </tr>
                </thead>
                <tbody>
EOF

            for category_id in $(jq -r '.categories[].id' "$REGISTRY"); do
                category_name="${CATEGORY_NAMES[$category_id]}"
                count="${AGENTS_BY_CATEGORY[$category_id]}"
                percentage=$(( (count * 100) / TOTAL_AGENTS ))

                echo "                    <tr>"
                echo "                        <td><strong>$category_name</strong></td>"
                echo "                        <td>$count</td>"
                echo "                        <td>"
                echo "                            <div class=\"progress-bar\">"
                echo "                                <div class=\"progress-fill\" style=\"width: ${percentage}%\"></div>"
                echo "                            </div>"
                echo "                            ${percentage}%"
                echo "                        </td>"
                echo "                    </tr>"
            done

            cat << 'EOF'
                </tbody>
            </table>

            <h2>🎯 Cobertura por Projeto</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Projeto</th>
                        <th>Agentes</th>
                    </tr>
                </thead>
                <tbody>
EOF

            declare -A PROJECT_NAMES
            PROJECT_NAMES[1]="SaaS Analytics Platform"
            PROJECT_NAMES[2]="AI-Powered Code Assistant"
            PROJECT_NAMES[3]="Data Pipeline Orchestration"
            PROJECT_NAMES[4]="Design System & Components"
            PROJECT_NAMES[5]="Enterprise Security Platform"
            PROJECT_NAMES[6]="Multi-Agent Collaboration"
            PROJECT_NAMES[7]="Code Quality Platform"
            PROJECT_NAMES[8]="Full-Stack Social Media"
            PROJECT_NAMES[9]="E-Learning Platform"
            PROJECT_NAMES[10]="E-Commerce Platform"

            for project_id in {1..10}; do
                if [ "${PROJECT_COVERAGE[$project_id]}" -gt 0 ]; then
                    echo "                    <tr>"
                    echo "                        <td>$project_id</td>"
                    echo "                        <td>${PROJECT_NAMES[$project_id]}</td>"
                    echo "                        <td><strong>${PROJECT_COVERAGE[$project_id]}</strong></td>"
                    echo "                    </tr>"
                fi
            done

            cat << 'EOF'
                </tbody>
            </table>

            <h2>📋 Todos os Agentes</h2>
EOF

            for category_id in $(jq -r '.categories[].id' "$REGISTRY"); do
                category_name="${CATEGORY_NAMES[$category_id]}"

                echo "            <div class=\"category-section\">"
                echo "                <h3>$category_name</h3>"

                jq -r ".agents[] | select(.category == \"$category_id\") | \"\(.name)|\(.id)|\(.description)\"" "$REGISTRY" | while IFS='|' read -r name id desc; do
                    echo "                <div class=\"agent-item\">"
                    echo "                    <span class=\"agent-name\">$name</span>"
                    echo "                    <span class=\"agent-id\">($id)</span>"
                    echo "                    <div>$desc</div>"
                    echo "                </div>"
                done

                echo "            </div>"
            done

            cat << 'EOF'
        </div>

        <div class="footer">
            Relatório gerado automaticamente pelo Rambo Code Experts Framework
        </div>
    </div>
</body>
</html>
EOF
        } > "${OUTPUT_FILE:-/dev/stdout}"
        ;;

    *)
        echo "Formato inválido: $FORMAT" >&2
        exit 1
        ;;
esac

if [ -n "$OUTPUT_FILE" ]; then
    log_success "Relatório gerado: $OUTPUT_FILE"
    echo "" >&2
fi

exit 0
