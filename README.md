# Rambo Code Experts

🎯 **Elite AI agents for code excellence** - A centralized framework of specialized subagents for Claude Code, organized by domains of expertise.

> **"First Blood" for your codebase** - Deploy elite AI agents that get the job done right, the first time.

## Visão Geral

Este repositório contém uma coleção curada de subagentes especializados que podem ser reutilizados em diferentes projetos. Os agentes estão organizados em 8 categorias principais, cada uma focada em um domínio específico do desenvolvimento de software.

## Categorias de Agentes

- **Estrategistas** (`agents/strategists/`) - Planejamento, arquitetura e decisões técnicas
- **Pesquisadores** (`agents/researchers/`) - Exploração de código e pesquisa técnica
- **Designers** (`agents/designers/`) - Design de interface e experiência do usuário
- **Frontend** (`agents/frontend/`) - Desenvolvimento de interfaces e experiências web
- **Backend** (`agents/backend/`) - APIs, serviços e lógica de negócio
- **Testadores** (`agents/testers/`) - Testes automatizados e garantia de qualidade
- **DevOps** (`agents/devops/`) - CI/CD, deployment e infraestrutura
- **Analytics** (`agents/analytics/`) - Análise de dados e experimentos

## Quick Start

### 🚀 Using the Rambo CLI (Recommended)

The easiest way to get started is with the Rambo CLI:

```bash
# Install globally
npm install -g rambo-code-experts

# Interactive mode - guided wizard for beginners
rambo interactive

# Quick commands
rambo list                    # List all available agents
rambo search react            # Search for agents
rambo install product-manager # Install specific agents
rambo info react-specialist   # Show agent details
```

### Manual Installation

#### Installing a Specific Agent

```bash
# Clone the repository
git clone https://github.com/allysonbarros/claude-subagents-framework.git

# Install a specific agent in your project
./scripts/install.sh --agent product-manager --dest ~/your-project/.claude/agents/
```

#### Installing a Complete Category

```bash
# Install all agents from a category
./scripts/install.sh --category strategists --dest ~/your-project/.claude/agents/
```

#### Listing Available Agents

```bash
# List all agents
./scripts/list-agents.sh

# List agents from a specific category
./scripts/list-agents.sh --category backend
```

## Estrutura do Repositório

```
claude-subagents-framework/
├── agents/              # Agentes organizados por categoria
├── scripts/             # Scripts de instalação e gerenciamento
├── templates/           # Templates para criar novos agentes
├── examples/            # Exemplos de workflows e uso
├── docs/                # Documentação adicional
└── registry.json        # Registro de todos os agentes disponíveis
```

## Uso em Projetos

Após instalar os agentes desejados no seu projeto, você pode invocá-los no Claude Code:

```
Use o agente product-manager para analisar os requisitos deste projeto
```

```
Use o agente react-specialist para criar um componente de navegação responsivo
```

Para mais informações sobre o CLI, veja [CLI README](./cli/README.md).

## Como Contribuir

1. Use o template em `templates/agent-template.md` como base
2. Adicione seu agente na categoria apropriada
3. Atualize o `registry.json` com os metadados do agente
4. Envie um Pull Request com a descrição detalhada

Veja `docs/contributing.md` para mais detalhes.

## Versionamento

Cada agente possui sua própria versão seguindo Semantic Versioning (semver). Isso permite que projetos fixem versões específicas de agentes.

## Licença

MIT

## Suporte

Para dúvidas ou sugestões, abra uma issue no repositório.
