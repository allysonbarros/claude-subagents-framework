# Claude Subagents Framework

Um framework centralizado de subagentes especializados para Claude Code, organizado por domínios de atuação.

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

### Instalando um Agente Específico

```bash
# Clonar o repositório
git clone https://github.com/seu-usuario/claude-subagents-framework.git

# Instalar um agente específico no seu projeto
./scripts/install.sh --agent product-manager --dest ~/seu-projeto/.claude/agents/
```

### Instalando uma Categoria Completa

```bash
# Instalar todos os agentes de uma categoria
./scripts/install.sh --category strategists --dest ~/seu-projeto/.claude/agents/
```

### Listando Agentes Disponíveis

```bash
# Listar todos os agentes
./scripts/list-agents.sh

# Listar agentes de uma categoria específica
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
