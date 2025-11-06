# ⚡ Quick Start - Scripts de Validação

## 🎯 Comece em 3 Minutos

### Passo 1: Instalação (30 segundos)

```bash
# Instalar dependência
sudo apt-get install jq  # Ubuntu/Debian
# ou
brew install jq          # macOS

# Scripts já estão executáveis! ✅
```

### Passo 2: Primeiro Teste (1 minuto)

```bash
# Vá para o diretório do framework
cd claude-subagents-framework

# Rode o comando de ajuda
./scripts/validation/rambo-validate.sh help

# Você verá:
#     ____                  __
#    / __ \____ _____ ___  / /_  ____
#   / /_/ / __ `/ __ `__ \/ __ \/ __ \
#  / _, _/ /_/ / / / / / / /_/ / /_/ /
# /_/ |_|\__,_/_/ /_/ /_/_.___/\____/
#
#   Code Experts - Validation Tools
```

### Passo 3: Primeira Validação (1 minuto)

```bash
# Validar um agente
./scripts/validation/rambo-validate.sh agent react-specialist

# Você verá o resultado:
# ✅ Agente encontrado no registry
# ✅ Arquivo do agente encontrado
# Score de Qualidade: 75/100
```

🎉 **Pronto!** Você já está usando os scripts de validação!

---

## 🚀 Comandos Essenciais

### 1. Listar Todos os Agentes

```bash
./scripts/validation/rambo-validate.sh list
```

**Output:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Estrategistas
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  • Product Manager (product-manager)
  • Tech Architect (tech-architect)
  • API Designer (api-designer)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Frontend
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  • React Specialist (react-specialist)
  • State Manager (state-manager)
  ...

Total: 50 agentes
```

---

### 2. Validar um Agente Específico

```bash
# Validação simples
./scripts/validation/rambo-validate.sh agent react-specialist

# Validação detalhada
./scripts/validation/rambo-validate.sh agent api-developer --verbose

# Validar no contexto de um projeto
./scripts/validation/rambo-validate.sh agent database-specialist --project 1
```

**Output:**
```
================================================
  🔍 Validador de Agentes - Rambo Code Experts
================================================

ℹ️  Validando agente: react-specialist
✅ Agente encontrado no registry
✅ Arquivo do agente encontrado
✅ Estrutura do arquivo válida

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

### 3. Validar um Projeto Completo

```bash
# Validação resumida (rápido)
./scripts/validation/rambo-validate.sh project 1 --summary

# Validação completa (detalhado)
./scripts/validation/rambo-validate.sh project 1

# Com relatório JSON
./scripts/validation/rambo-validate.sh project 1 --report
```

**Output (resumo):**
```
====================================================
  🎯 Validador de Projetos - Rambo Code Experts
====================================================

ℹ️  Validando projeto: SaaS Analytics Platform (ID: 1)
✅ Encontrados 15 agentes para validar

✅ product-manager
✅ tech-architect
✅ api-designer
✅ fastapi-specialist
✅ database-specialist
... (todos os 15 agentes)

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

### 4. Testar Fluxo de um Agente

```bash
# Teste básico
./scripts/validation/rambo-validate.sh test react-specialist

# Teste interativo (escolher cenário)
./scripts/validation/rambo-validate.sh test api-developer --interactive

# Teste com cenário específico
./scripts/validation/rambo-validate.sh test database-specialist --scenario database-query
```

**Output:**
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
```

---

### 5. Gerar Relatórios

```bash
# Relatório Markdown (terminal)
./scripts/validation/rambo-validate.sh coverage

# Relatório JSON (para CI/CD)
./scripts/validation/rambo-validate.sh coverage --format json --output coverage.json

# Relatório HTML visual (abre no navegador)
./scripts/validation/rambo-validate.sh report
```

**Relatório HTML:**
- Gráficos interativos
- Estatísticas completas
- Visual moderno
- Abre automaticamente

---

### 6. Validar Tudo

```bash
# Valida todos os 10 projetos
./scripts/validation/rambo-validate.sh all
```

**Output:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Projeto 1
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Total: 15 agentes
✅ Válidos: 15 (100%)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Projeto 2
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Total: 12 agentes
✅ Válidos: 12 (100%)

... (todos os 10 projetos)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Resumo Final
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Todos os 10 projetos válidos!
```

---

## 🎯 Casos de Uso Comuns

### Desenvolvedor: Validar Antes de Commit

```bash
# 1. Validar agente modificado
./scripts/validation/rambo-validate.sh agent my-agent --verbose

# 2. Testar fluxo
./scripts/validation/rambo-validate.sh test my-agent --interactive

# 3. Se tudo OK, commit!
git add agents/backend/my-agent.md
git commit -m "feat: Update my-agent"
```

---

### QA: Validar Release

```bash
# 1. Validar todos os projetos
./scripts/validation/rambo-validate.sh all

# 2. Gerar relatório para stakeholders
./scripts/validation/rambo-validate.sh report

# 3. Verificar cobertura
./scripts/validation/rambo-validate.sh coverage
```

---

### Tech Lead: Auditoria Semanal

```bash
# 1. Relatório de cobertura
./scripts/validation/rambo-validate.sh coverage > weekly-report.md

# 2. Validar projetos críticos
for project in 1 2 8 10; do
    ./scripts/validation/rambo-validate.sh project $project --summary
done

# 3. Identificar agentes com problemas
./scripts/validation/rambo-validate.sh all | grep "❌"
```

---

### CI/CD: Pipeline Automático

```bash
#!/bin/bash
# ci-validation.sh

set -e

echo "🔍 Validando framework..."

# Validar todos os projetos
./scripts/validation/rambo-validate.sh all

# Gerar relatório JSON
./scripts/validation/rambo-validate.sh coverage \
    --format json \
    --output coverage.json

echo "✅ Validação concluída!"
```

---

## 📚 Próximos Passos

### Explorar mais:

1. **Documentação completa**
   ```bash
   cat scripts/validation/README.md
   ```

2. **Guia de validação**
   ```bash
   cat VALIDATION_GUIDE.md
   ```

3. **Ideias de projetos**
   ```bash
   cat PROJECT_IDEAS.md
   ```

4. **Resumo de automação**
   ```bash
   cat AUTOMATION_SUMMARY.md
   ```

---

## 🆘 Precisa de Ajuda?

### Comando não funciona?

```bash
# Ver ajuda de qualquer comando
./scripts/validation/rambo-validate.sh help

# Ver opções de um comando específico
./scripts/validation/validate-agent.sh --help
```

### jq não instalado?

```bash
# Ubuntu/Debian
sudo apt-get install jq

# macOS
brew install jq

# Verificar
jq --version
```

### Permissão negada?

```bash
# Dar permissão de execução
chmod +x scripts/validation/*.sh

# Verificar
ls -la scripts/validation/*.sh
```

---

## 🎉 Você está pronto!

Agora você pode:

- ✅ Validar qualquer agente
- ✅ Validar projetos completos
- ✅ Testar fluxos de agentes
- ✅ Gerar relatórios profissionais
- ✅ Automatizar validações
- ✅ Integrar com CI/CD

**Comece agora:**

```bash
./scripts/validation/rambo-validate.sh list
```

---

## 📖 Recursos

- [README dos Scripts](scripts/validation/README.md) - Documentação técnica completa
- [Guia de Validação](VALIDATION_GUIDE.md) - Tutoriais passo-a-passo
- [Ideias de Projetos](PROJECT_IDEAS.md) - 10 projetos para validar agentes
- [Resumo de Automação](AUTOMATION_SUMMARY.md) - Visão geral executiva

---

**Última atualização:** 2025-11-06
**Status:** ✅ Pronto para uso
**Dificuldade:** 🟢 Iniciante-friendly
