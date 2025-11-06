# 🎯 Guia de Validação dos Subagentes

Este guia mostra como usar os scripts de automação para validar os subagentes do framework Rambo Code Experts.

## 🚀 Quick Start

### Instalação Rápida

```bash
# 1. Clone o repositório (se ainda não fez)
git clone https://github.com/allysonbarros/claude-subagents-framework.git
cd claude-subagents-framework

# 2. Instale dependências
sudo apt-get install jq  # Ubuntu/Debian
# ou
brew install jq          # macOS

# 3. Torne os scripts executáveis (já feito!)
chmod +x scripts/validation/*.sh

# 4. Teste a instalação
./scripts/validation/rambo-validate.sh help
```

---

## 📋 Uso Básico

### Script Master: `rambo-validate.sh`

Este é o ponto de entrada principal para todos os comandos de validação.

```bash
cd scripts/validation
./rambo-validate.sh <command> [args...]
```

### Comandos Principais

```bash
# Ver todos os comandos disponíveis
./rambo-validate.sh help

# Listar todos os agentes
./rambo-validate.sh list

# Validar um agente específico
./rambo-validate.sh agent react-specialist

# Validar um projeto completo
./rambo-validate.sh project 1

# Testar fluxo de um agente
./rambo-validate.sh test api-developer --interactive

# Gerar relatório de cobertura
./rambo-validate.sh coverage

# Validar todos os projetos
./rambo-validate.sh all

# Gerar relatório HTML completo
./rambo-validate.sh report
```

---

## 🎓 Tutoriais Passo-a-Passo

### Tutorial 1: Validar Seu Primeiro Agente

**Objetivo**: Verificar se um agente está configurado corretamente.

```bash
# Passo 1: Listar agentes disponíveis
./rambo-validate.sh list

# Passo 2: Escolher um agente (ex: react-specialist)
./rambo-validate.sh agent react-specialist

# Passo 3: Ver detalhes completos
./rambo-validate.sh agent react-specialist --verbose

# Resultado esperado:
# ✅ Agente encontrado no registry
# ✅ Arquivo do agente encontrado
# ✅ Estrutura do arquivo válida
# Score de Qualidade: 100/100
```

**Interpretando o resultado:**
- **Score 90-100**: Agente perfeito, pronto para uso
- **Score 70-89**: Agente funcional, mas pode melhorar
- **Score <70**: Requer atenção, faltam seções importantes

---

### Tutorial 2: Validar um Projeto Completo

**Objetivo**: Garantir que todos os agentes de um projeto estão prontos.

```bash
# Passo 1: Escolher um projeto (ex: Projeto 1 - SaaS Analytics)
./rambo-validate.sh project 1

# Passo 2: Ver apenas resumo (mais rápido)
./rambo-validate.sh project 1 --summary

# Passo 3: Gerar relatório JSON
./rambo-validate.sh project 1 --report

# Resultado esperado:
# Total de Agentes: 15
# ✅ Válidos: 15
# Taxa de Sucesso: 100%
```

**O que fazer se houver falhas:**
```bash
# Se algum agente falhar, validar individualmente:
./rambo-validate.sh agent <agent-id> --verbose

# Verificar o arquivo do agente:
cat agents/<category>/<agent-id>.md

# Corrigir problemas e validar novamente
```

---

### Tutorial 3: Testar Fluxo de um Agente

**Objetivo**: Simular a execução de um agente em um cenário real.

```bash
# Passo 1: Testar modo interativo (escolher cenário)
./rambo-validate.sh test react-specialist --interactive

# Passo 2: Testar cenário específico
./rambo-validate.sh test api-developer --scenario api-endpoint

# Passo 3: Ver fluxo detalhado
./rambo-validate.sh test database-specialist --verbose

# Resultado esperado:
# 🎬 Simulando Fluxo do Agente
# → Passo 1: Invocação do agente
# → Passo 2: Agente analisa o contexto
# → Passo 3: Seleção de ferramentas
# → Passo 4: Execução das tarefas
# → Passo 5: Resultado da execução
# ✅ Tarefa concluída com sucesso!
# Taxa de sucesso: 98%
```

---

### Tutorial 4: Gerar Relatórios de Cobertura

**Objetivo**: Ter visão geral do framework e sua cobertura.

```bash
# Passo 1: Relatório Markdown (terminal)
./rambo-validate.sh coverage

# Passo 2: Relatório JSON (para CI/CD)
./rambo-validate.sh coverage --format json --output coverage.json

# Passo 3: Relatório HTML (visual)
./rambo-validate.sh report

# O relatório HTML abrirá automaticamente no navegador!
```

**Conteúdo dos relatórios:**
- 📊 Total de agentes (50)
- 📂 Distribuição por categoria (10 categorias)
- 🎯 Cobertura por projeto (10 projetos)
- 📋 Lista completa com descrições

---

### Tutorial 5: Validação Completa (Auditoria)

**Objetivo**: Validar todo o framework de uma vez.

```bash
# Passo 1: Validar todos os 10 projetos
./rambo-validate.sh all

# Passo 2: Gerar relatório completo
./rambo-validate.sh report

# Passo 3: Revisar resultados
# - Se tudo verde: framework 100% válido!
# - Se houver problemas: ver logs de cada projeto
```

---

## 🔄 Workflows Práticos

### Workflow: Antes de um Release

```bash
#!/bin/bash
# pre-release-check.sh

echo "🔍 Executando checklist de release..."

# 1. Validar todos os projetos
echo "1/4 Validando todos os projetos..."
./rambo-validate.sh all || exit 1

# 2. Gerar relatório de cobertura
echo "2/4 Gerando relatório de cobertura..."
./rambo-validate.sh coverage --format json --output coverage.json

# 3. Validar agentes críticos
echo "3/4 Validando agentes críticos..."
CRITICAL_AGENTS=(
    "react-specialist"
    "api-developer"
    "database-specialist"
    "security-specialist"
    "ci-cd-engineer"
)

for agent in "${CRITICAL_AGENTS[@]}"; do
    echo "  Validando $agent..."
    ./rambo-validate.sh agent "$agent" --verbose || exit 1
done

# 4. Gerar relatório final
echo "4/4 Gerando relatório final..."
./rambo-validate.sh report

echo "✅ Checklist completo! Pronto para release."
```

### Workflow: CI/CD Integration

```yaml
# .github/workflows/validate.yml

name: Validate Agents

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  validate:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3

    - name: Install dependencies
      run: sudo apt-get update && sudo apt-get install -y jq

    - name: Validate all projects
      run: ./scripts/validation/rambo-validate.sh all

    - name: Generate coverage report
      run: |
        ./scripts/validation/rambo-validate.sh coverage \
          --format json \
          --output coverage.json

    - name: Upload coverage
      uses: actions/upload-artifact@v3
      with:
        name: coverage-report
        path: coverage.json
```

### Workflow: Desenvolvimento de Novo Agente

```bash
# 1. Criar novo agente
cp templates/agent-template.md agents/backend/new-agent.md

# 2. Editar o agente
vim agents/backend/new-agent.md

# 3. Adicionar ao registry.json
# (editar manualmente ou usar script)

# 4. Validar o novo agente
./rambo-validate.sh agent new-agent --verbose

# 5. Testar fluxos
./rambo-validate.sh test new-agent --interactive

# 6. Validar em contexto de projeto
./rambo-validate.sh agent new-agent --project 1

# 7. Se tudo OK, commit!
git add agents/backend/new-agent.md registry.json
git commit -m "feat: Add new-agent to backend category"
```

---

## 📊 Interpretando Resultados

### Scores de Qualidade

Os scripts calculam um score de 0-100 para cada agente:

**100 pontos** - Perfeito!
- ✅ Arquivo existe e está no registry
- ✅ Todas as seções obrigatórias presentes
- ✅ Conteúdo rico (>300 palavras)
- ✅ Bem estruturado (>50 linhas)

**75-99 pontos** - Muito bom
- ✅ Estrutura completa
- ⚠️ Poderia ter mais conteúdo

**50-74 pontos** - Funcional
- ⚠️ Faltam algumas seções
- ⚠️ Conteúdo básico

**<50 pontos** - Precisa melhorias
- ❌ Seções importantes faltando
- ❌ Conteúdo insuficiente

### Taxa de Sucesso de Projetos

**100%** - 🎉 Projeto perfeito!
- Todos os agentes válidos
- Sem warnings

**85-99%** - ⚠️ Projeto bom
- Alguns agentes com warnings menores
- Funcional mas pode melhorar

**<85%** - ❌ Projeto precisa atenção
- Agentes inválidos
- Requer correções

---

## 🛠️ Troubleshooting

### Problema: "jq not found"

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install jq

# macOS
brew install jq

# Verificar instalação
jq --version
```

### Problema: "Permission denied"

```bash
# Dar permissão de execução
chmod +x scripts/validation/*.sh

# Verificar
ls -la scripts/validation/*.sh
```

### Problema: "Agent not found"

```bash
# Verificar se existe no registry
cat registry.json | jq '.agents[] | select(.id == "agent-id")'

# Listar todos disponíveis
./rambo-validate.sh list

# Verificar ortografia do ID
```

### Problema: Script não encontra PROJECT_IDEAS.md

```bash
# Executar a partir da raiz do framework
cd /path/to/claude-subagents-framework
./scripts/validation/rambo-validate.sh project 1

# Verificar se arquivo existe
ls -la PROJECT_IDEAS.md
```

---

## 🎯 Casos de Uso por Persona

### Para Desenvolvedores

```bash
# Durante desenvolvimento
./rambo-validate.sh agent my-agent --verbose
./rambo-validate.sh test my-agent --interactive

# Antes de commit
./rambo-validate.sh agent my-agent --project 1
```

### Para Tech Leads

```bash
# Auditoria semanal
./rambo-validate.sh all
./rambo-validate.sh report

# Monitorar qualidade
./rambo-validate.sh coverage --format json
```

### Para QA

```bash
# Validação de release
./rambo-validate.sh all --verbose
./rambo-validate.sh report

# Testes de fluxo
for agent in react-specialist api-developer; do
    ./rambo-validate.sh test $agent
done
```

### Para CI/CD

```bash
# Pipeline de validação
./rambo-validate.sh all || exit 1
./rambo-validate.sh coverage --format json --output $ARTIFACT_DIR/coverage.json
```

---

## 📚 Recursos Adicionais

- **[README dos Scripts](scripts/validation/README.md)** - Documentação detalhada
- **[PROJECT_IDEAS.md](PROJECT_IDEAS.md)** - Ideias de projetos para validação
- **[registry.json](registry.json)** - Registro de todos os agentes
- **[Diretório de Agentes](agents/)** - Código fonte dos agentes

---

## 🤝 Contribuindo

Encontrou um problema ou tem sugestões?

1. Abra uma issue no GitHub
2. Descreva o problema ou sugestão
3. Se possível, inclua output dos scripts
4. Aguarde feedback da equipe

---

## 📈 Roadmap

Próximas funcionalidades planejadas:

- [ ] Validação de dependências entre agentes
- [ ] Benchmark de performance dos agentes
- [ ] Integração com IDEs (VS Code extension)
- [ ] Dashboard web interativo
- [ ] Testes automatizados de qualidade de output
- [ ] Métricas de uso em projetos reais

---

## 📞 Suporte

- **Issues**: https://github.com/allysonbarros/claude-subagents-framework/issues
- **Discussions**: https://github.com/allysonbarros/claude-subagents-framework/discussions
- **Email**: [seu-email]

---

**Última atualização**: 2025-11-06
**Versão**: 1.0.0
**Mantido por**: Rambo Code Experts Team 🎯
