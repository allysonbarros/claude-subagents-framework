# 🧪 Scripts de Validação - Rambo Code Experts

Este diretório contém scripts de automação para facilitar a validação e teste dos subagentes do framework.

## 📋 Scripts Disponíveis

### 1. `validate-agent.sh` - Validador Individual de Agentes

Valida se um agente específico está configurado corretamente.

#### Uso:
```bash
./validate-agent.sh <agent-id> [options]
```

#### Opções:
- `--project <id>` - Valida no contexto de um projeto específico
- `--verbose` - Output detalhado
- `--report` - Gera relatório JSON
- `-h, --help` - Mostra ajuda

#### Exemplos:
```bash
# Validação simples
./validate-agent.sh react-specialist

# Validação no contexto do projeto 1
./validate-agent.sh api-developer --project 1

# Validação com relatório JSON
./validate-agent.sh database-specialist --report --verbose
```

#### O que é verificado:
- ✅ Existência no registry.json
- ✅ Arquivo .md do agente existe
- ✅ Estrutura do arquivo (seções obrigatórias)
- ✅ Ferramentas mencionadas
- ✅ Qualidade do conteúdo (word count, etc)
- ✅ Contexto do projeto (se fornecido)

#### Output:
```
================================================
  🔍 Validador de Agentes - Rambo Code Experts
================================================

ℹ️  Validando agente: react-specialist
✅ Agente encontrado no registry
✅ Arquivo do agente encontrado
✅ Estrutura do arquivo válida
✅ Agente está listado no Projeto 1

================================================
  📊 Resultado da Validação
================================================

Agente: React Specialist (react-specialist)
Categoria: frontend
Versão: 1.0.0

Status: ✅ VÁLIDO
Score de Qualidade: 100/100
```

---

### 2. `validate-project.sh` - Validador de Projeto Completo

Valida todos os agentes de um projeto específico.

#### Uso:
```bash
./validate-project.sh <project-id> [options]
```

#### IDs de Projetos:
- `1` - SaaS Analytics Platform
- `2` - AI-Powered Code Assistant
- `3` - Data Pipeline Orchestration Platform
- `4` - Design System e Component Library
- `5` - Enterprise Security Platform
- `6` - Multi-Agent Collaboration System
- `7` - Code Quality and Analysis Platform
- `8` - Full-Stack Social Media App
- `9` - E-Learning Platform with AI Tutoring
- `10` - E-Commerce Platform with Recommendations

#### Opções:
- `--report` - Gera relatório completo JSON
- `--summary` - Mostra apenas resumo (mais rápido)
- `-h, --help` - Mostra ajuda

#### Exemplos:
```bash
# Validação completa do projeto 1
./validate-project.sh 1

# Validação rápida (apenas resumo)
./validate-project.sh 4 --summary

# Validação com relatório
./validate-project.sh 2 --report
```

#### Output:
```
====================================================
  🎯 Validador de Projetos - Rambo Code Experts
====================================================

ℹ️  Validando projeto: SaaS Analytics Platform (ID: 1)
ℹ️  Extraindo lista de agentes do projeto...
✅ Encontrados 15 agentes para validar

================================================
  🔍 Validando Agentes
================================================

✅ product-manager
✅ tech-architect
✅ api-designer
...

====================================================
  📊 Resumo da Validação
====================================================

Projeto: SaaS Analytics Platform
Total de Agentes: 15

✅ Válidos: 15
⚠️  Com Avisos: 0
❌ Inválidos: 0

Taxa de Sucesso: 100%

🎉 Projeto totalmente válido!
```

---

### 3. `generate-coverage-report.sh` - Gerador de Relatórios de Cobertura

Gera relatórios completos de cobertura de agentes do framework.

#### Uso:
```bash
./generate-coverage-report.sh [options]
```

#### Opções:
- `--format <type>` - Formato: json, markdown, html (default: markdown)
- `--output <file>` - Arquivo de saída (default: stdout)
- `-h, --help` - Mostra ajuda

#### Exemplos:
```bash
# Relatório Markdown para stdout
./generate-coverage-report.sh

# Relatório JSON
./generate-coverage-report.sh --format json --output coverage.json

# Relatório HTML
./generate-coverage-report.sh --format html --output report.html

# Abrir HTML no navegador
./generate-coverage-report.sh --format html --output /tmp/report.html && xdg-open /tmp/report.html
```

#### Formatos Disponíveis:

**Markdown** (`.md`)
- Formato legível
- Ideal para documentação
- Tabelas e listas organizadas

**JSON** (`.json`)
- Formato estruturado
- Ideal para processamento automático
- Integração com CI/CD

**HTML** (`.html`)
- Formato visual interativo
- Gráficos e estatísticas
- Ideal para apresentações

#### Conteúdo do Relatório:
- 📊 Estatísticas gerais (total de agentes, categorias, projetos)
- 📂 Distribuição de agentes por categoria
- 🎯 Cobertura por projeto
- 🔝 Top categorias
- 📋 Lista completa de agentes com descrições

---

### 4. `test-agent-flow.sh` - Teste de Fluxo de Agente

Simula a execução de um agente em um cenário específico.

#### Uso:
```bash
./test-agent-flow.sh <agent-id> [options]
```

#### Opções:
- `--scenario <id>` - ID do cenário de teste
- `--interactive` - Modo interativo (escolher cenário)
- `--verbose` - Output detalhado (mostra arquivo completo)
- `-h, --help` - Mostra ajuda

#### Exemplos:
```bash
# Teste simples
./test-agent-flow.sh react-specialist

# Teste com cenário específico
./test-agent-flow.sh api-developer --scenario api-endpoint

# Modo interativo
./test-agent-flow.sh database-specialist --interactive

# Modo verbose
./test-agent-flow.sh test-strategist --verbose
```

#### Cenários por Categoria:

**Frontend**
- `component-creation` - Criar um componente React
- `state-management` - Implementar gerenciamento de estado
- `styling` - Aplicar estilos responsivos

**Backend**
- `api-endpoint` - Criar endpoint REST
- `database-query` - Otimizar query de banco
- `authentication` - Implementar autenticação

**Designers**
- `ui-design` - Design de interface
- `ux-flow` - Definir fluxo de usuário
- `design-system` - Criar design tokens

**Testers**
- `unit-test` - Escrever testes unitários
- `e2e-test` - Criar testes E2E
- `test-strategy` - Definir estratégia de testes

**DevOps**
- `ci-cd-setup` - Configurar pipeline CI/CD
- `docker-setup` - Criar Dockerfile
- `k8s-deploy` - Deploy em Kubernetes

**Strategists**
- `architecture` - Definir arquitetura
- `api-design` - Design de API
- `requirements` - Análise de requisitos

**Researchers**
- `code-analysis` - Análise de código
- `tech-research` - Pesquisa de tecnologias
- `dependency-audit` - Auditoria de dependências

**Analytics**
- `event-tracking` - Implementar tracking
- `ab-test` - Configurar teste A/B
- `metrics-analysis` - Análise de métricas

**AI/ML**
- `rag-system` - Implementar sistema RAG
- `agent-setup` - Configurar agent
- `prompt-optimization` - Otimizar prompts

**Data Engineering**
- `pipeline-setup` - Criar pipeline de dados
- `dbt-model` - Criar model DBT
- `data-transformation` - Transformação de dados

#### Output:
```
====================================================
  🧪 Teste de Fluxo de Agente - Rambo Code Experts
====================================================

ℹ️  Testando agente: React Specialist
ℹ️  Cenário: Criar um componente React

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  🎬 Simulando Fluxo do Agente
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

→ Passo 1: Invocação do agente
   Prompt simulado:
   "Use o agente React Specialist para: Criar um componente React"

→ Passo 2: Agente analisa o contexto
   Expertise aplicada:
   - React 18+ com hooks
   - TypeScript
   - Componentes funcionais
   ...

→ Passo 3: Seleção de ferramentas
   Ferramentas disponíveis:
   - Read
   - Write
   - Edit
   - Grep

→ Passo 4: Execução das tarefas
   [1/3] Analisando estrutura do projeto...
   [2/3] Criando componente...
   [3/3] Aplicando testes...

→ Passo 5: Resultado da execução
✅ Tarefa concluída com sucesso!
   ✓ Todos os critérios atendidos
   ✓ Código gerado está funcional
   ✓ Testes passaram
   ✓ Documentação adicionada

   Taxa de sucesso: 98%

====================================================
  ✨ Resumo do Teste
====================================================

Agente: React Specialist
Categoria: frontend
Cenário: Criar um componente React
Status: ✅ SUCESSO
Taxa: 98%
```

---

## 🚀 Quick Start

### Instalação e Setup

1. **Tornar scripts executáveis:**
```bash
cd scripts/validation
chmod +x *.sh
```

2. **Verificar dependências:**
```bash
# jq é necessário para parsing JSON
sudo apt-get install jq  # Ubuntu/Debian
brew install jq          # macOS
```

3. **Validar um agente:**
```bash
./validate-agent.sh react-specialist
```

---

## 📊 Workflows Comuns

### Workflow 1: Validar Projeto Completo

```bash
# 1. Validar todos os agentes do projeto
./validate-project.sh 1 --report

# 2. Verificar agentes específicos com problemas
./validate-agent.sh product-manager --verbose

# 3. Gerar relatório de cobertura
./generate-coverage-report.sh --format html --output report.html
```

### Workflow 2: Testar Novos Agentes

```bash
# 1. Validar estrutura do agente
./validate-agent.sh new-agent-id --verbose

# 2. Testar fluxo do agente
./test-agent-flow.sh new-agent-id --interactive

# 3. Validar em contexto de projeto
./validate-agent.sh new-agent-id --project 1
```

### Workflow 3: Auditoria Completa

```bash
# 1. Gerar relatório de cobertura
./generate-coverage-report.sh --format markdown > coverage.md

# 2. Validar todos os 10 projetos
for i in {1..10}; do
    echo "Validando projeto $i..."
    ./validate-project.sh $i --summary
done

# 3. Testar amostra de agentes
./test-agent-flow.sh react-specialist
./test-agent-flow.sh api-developer
./test-agent-flow.sh database-specialist
```

### Workflow 4: CI/CD Integration

```bash
#!/bin/bash
# ci-validation.sh - Script para CI/CD

set -e

echo "🔍 Validando framework..."

# Validar estrutura de todos os projetos
for project_id in {1..10}; do
    if ! ./validate-project.sh "$project_id" --summary; then
        echo "❌ Projeto $project_id falhou na validação"
        exit 1
    fi
done

# Gerar relatório JSON
./generate-coverage-report.sh --format json --output coverage.json

echo "✅ Todas as validações passaram!"
```

---

## 🎯 Casos de Uso

### Para Desenvolvedores de Agentes

```bash
# Validar agente durante desenvolvimento
./validate-agent.sh my-new-agent --verbose

# Testar diferentes cenários
./test-agent-flow.sh my-new-agent --interactive
```

### Para QA/Testers

```bash
# Validar projeto antes de release
./validate-project.sh 1 --report

# Gerar relatório para stakeholders
./generate-coverage-report.sh --format html --output report.html
```

### Para Tech Leads

```bash
# Auditoria de cobertura
./generate-coverage-report.sh --format markdown

# Validar todos os projetos
for i in {1..10}; do ./validate-project.sh $i --summary; done
```

### Para CI/CD

```bash
# Validação automática em pipeline
./validate-project.sh $PROJECT_ID --report
EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
    echo "Pipeline failed: validation errors"
    exit 1
fi
```

---

## 🔧 Troubleshooting

### Erro: "jq not found"
```bash
# Instalar jq
sudo apt-get install jq  # Ubuntu/Debian
brew install jq          # macOS
```

### Erro: "Permission denied"
```bash
# Tornar scripts executáveis
chmod +x scripts/validation/*.sh
```

### Erro: "Agent not found in registry"
```bash
# Verificar se o agente existe
cat registry.json | jq '.agents[] | select(.id == "agent-id")'

# Listar todos os agentes disponíveis
cat registry.json | jq '.agents[].id'
```

### Erro: "Project file not found"
```bash
# Verificar se PROJECT_IDEAS.md existe
ls -la PROJECT_IDEAS.md

# Se não existir, executar a partir da raiz do framework
cd /path/to/claude-subagents-framework
./scripts/validation/validate-project.sh 1
```

---

## 📈 Métricas e KPIs

Os scripts geram as seguintes métricas:

### Por Agente:
- Score de qualidade (0-100)
- Word count
- Line count
- Seções faltando
- Ferramentas disponíveis

### Por Projeto:
- Total de agentes
- Agentes válidos
- Agentes com avisos
- Agentes inválidos
- Taxa de sucesso (%)

### Framework Geral:
- Total de agentes (50)
- Total de categorias (10)
- Distribuição por categoria
- Cobertura por projeto

---

## 🤝 Contribuindo

Se você criar novos scripts de validação:

1. Siga o padrão de naming: `action-target.sh`
2. Adicione help (`-h, --help`)
3. Use cores para output legível
4. Documente neste README
5. Adicione exemplos de uso

---

## 📚 Referências

- [PROJECT_IDEAS.md](../../PROJECT_IDEAS.md) - Projetos de validação
- [registry.json](../../registry.json) - Registro de agentes
- [agents/](../../agents/) - Diretório de agentes

---

**Última atualização:** 2025-11-06
**Versão:** 1.0.0
**Mantido por:** Rambo Code Experts Team
