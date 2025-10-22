# Exemplo: Setup Inicial de Projeto

Este exemplo demonstra como usar múltiplos agentes do framework para configurar um novo projeto do zero.

## Cenário

Você está iniciando um novo projeto web full-stack com React no frontend e Node.js no backend, e quer estabelecer boas práticas desde o início.

## Workflow Recomendado

### Fase 1: Planejamento Estratégico

**Agentes Utilizados:** `product-manager`, `tech-lead`

```bash
# Instalar agentes estratégicos
./scripts/install.sh --category strategists --dest ~/meu-projeto/.claude/agents/
```

**Comandos no Claude Code:**

```
Use o agente product-manager para criar um PRD (Product Requirements Document)
baseado na seguinte ideia: [descrição da sua ideia]
```

```
Use o agente tech-lead para definir a arquitetura do sistema, considerando:
- Stack: React + Node.js
- Deploy: AWS
- Banco de dados: PostgreSQL
```

### Fase 2: Pesquisa e Decisões Técnicas

**Agentes Utilizados:** `tech-scout`

```bash
./scripts/install.sh --agent tech-scout --dest ~/meu-projeto/.claude/agents/
```

**Comandos no Claude Code:**

```
Use o agente tech-scout para pesquisar e recomendar:
1. Biblioteca de state management para React
2. Framework web para Node.js
3. ORM para PostgreSQL
```

### Fase 3: Setup de Infraestrutura

**Agentes Utilizados:** `docker-expert`, `ci-cd-specialist`

```bash
./scripts/install.sh --category devops --dest ~/meu-projeto/.claude/agents/
```

**Comandos no Claude Code:**

```
Use o agente docker-expert para criar:
1. Dockerfile para frontend
2. Dockerfile para backend
3. docker-compose.yml para desenvolvimento local
```

```
Use o agente ci-cd-specialist para configurar GitHub Actions com:
1. Testes automatizados
2. Build e deploy
3. Code quality checks
```

### Fase 4: Implementação Frontend

**Agentes Utilizados:** `react-specialist`, `ui-designer`

```bash
./scripts/install.sh --category frontend --dest ~/meu-projeto/.claude/agents/
./scripts/install.sh --category designers --dest ~/meu-projeto/.claude/agents/
```

**Comandos no Claude Code:**

```
Use o agente ui-designer para criar um design system básico com:
- Paleta de cores
- Tipografia
- Componentes base
```

```
Use o agente react-specialist para implementar:
1. Estrutura de pastas
2. Componentes base do design system
3. Configuração de rotas
```

### Fase 5: Implementação Backend

**Agentes Utilizados:** `api-builder`, `database-expert`

```bash
./scripts/install.sh --category backend --dest ~/meu-projeto/.claude/agents/
```

**Comandos no Claude Code:**

```
Use o agente database-expert para criar o schema do banco de dados
baseado nos requisitos do PRD
```

```
Use o agente api-builder para implementar:
1. Estrutura REST API
2. Autenticação JWT
3. Endpoints principais
```

### Fase 6: Testes e Quality Assurance

**Agentes Utilizados:** `unit-tester`, `integration-tester`

```bash
./scripts/install.sh --category testers --dest ~/meu-projeto/.claude/agents/
```

**Comandos no Claude Code:**

```
Use o agente unit-tester para criar testes unitários para:
1. Componentes React principais
2. Funções utilitárias
3. Lógica de negócio
```

```
Use o agente integration-tester para criar testes de integração:
1. Fluxos de autenticação
2. CRUD de entidades principais
3. Integração frontend-backend
```

### Fase 7: Documentação

**Comandos no Claude Code:**

```
Crie documentação completa do projeto incluindo:
1. README.md
2. CONTRIBUTING.md
3. API documentation
4. Setup instructions
```

## Resultado Esperado

Ao final deste workflow, você terá:

- Projeto estruturado com boas práticas
- Infraestrutura configurada (Docker, CI/CD)
- Frontend e Backend implementados
- Testes automatizados
- Documentação completa

## Dicas

1. **Execute fases sequencialmente**: Cada fase depende da anterior
2. **Revise os outputs**: Sempre revise o que os agentes produziram antes de avançar
3. **Customize agentes**: Adapte os prompts dos agentes para seu contexto específico
4. **Combine agentes**: Use múltiplos agentes em paralelo quando fizer sentido

## Tempo Estimado

- Fase 1: 1-2 horas
- Fase 2: 1 hora
- Fase 3: 2-3 horas
- Fase 4: 4-6 horas
- Fase 5: 4-6 horas
- Fase 6: 3-4 horas
- Fase 7: 1-2 horas

**Total: 16-24 horas** (vs. 40-60 horas sem os agentes)
