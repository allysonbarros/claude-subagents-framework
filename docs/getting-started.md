# Começando com o Claude Subagents Framework

Guia para começar a usar o framework de subagentes em seus projetos.

## Pré-requisitos

- Claude Code instalado e configurado
- Git
- Bash (Linux/macOS) ou Git Bash (Windows)

## Instalação

### 1. Clone o Repositório

```bash
git clone https://github.com/seu-usuario/claude-subagents-framework.git
cd claude-subagents-framework
```

### 2. Torne os Scripts Executáveis

```bash
chmod +x scripts/*.sh
```

### 3. Explore os Agentes Disponíveis

```bash
./scripts/list-agents.sh
```

## Usando Agentes no seu Projeto

### Instalação Rápida

Para instalar um agente específico:

```bash
./scripts/install.sh --agent product-manager --dest ~/meu-projeto/.claude/agents/
```

Para instalar uma categoria completa:

```bash
./scripts/install.sh --category strategists --dest ~/meu-projeto/.claude/agents/
```

### Estrutura Recomendada no Projeto

```
meu-projeto/
├── .claude/
│   └── agents/
│       ├── product-manager.md
│       ├── tech-lead.md
│       └── ...
├── src/
└── ...
```

## Invocando Agentes no Claude Code

Após instalar os agentes, você pode invocá-los no Claude Code:

```
Use o agente product-manager para analisar os requisitos deste projeto
```

ou

```
Execute o agente tech-lead para definir a arquitetura do sistema
```

## Workflows Recomendados

Veja os exemplos em `/examples` para workflows completos:

- `project-setup-workflow.md` - Setup inicial de projetos
- `feature-development-workflow.md` - Desenvolvimento de features

## Sincronizando Agentes

Para atualizar um agente já instalado:

```bash
./scripts/sync-agent.sh product-manager ~/meu-projeto
```

Isso substituirá a versão local pela versão mais recente do framework.

## Customizando Agentes

### Para Uso Pessoal

1. Copie o agente para seu projeto
2. Edite conforme necessário
3. Use normalmente no Claude Code

### Para Compartilhar com o Time

1. Faça um fork do repositório
2. Adicione/modifique agentes
3. Compartilhe o fork com o time
4. Use como fonte central para o time

## Criando Novos Agentes

1. Use o template: `templates/agent-template.md`
2. Preencha todas as seções
3. Coloque na categoria apropriada
4. Atualize o `registry.json`
5. Teste o agente
6. Documente casos de uso

Veja `docs/contributing.md` para detalhes.

## Dicas

### Organize seus Agentes

Mantenha uma estrutura organizada:

```
.claude/
├── agents/
│   ├── strategists/
│   ├── frontend/
│   └── backend/
└── commands/
```

### Use Versionamento

Sempre note a versão do agente que está usando. Se atualizar, teste antes de usar em produção.

### Combine Agentes

Agentes funcionam melhor quando combinados. Por exemplo:
- `codebase-explorer` + `tech-lead` para refatorações
- `ui-designer` + `react-specialist` para novas interfaces
- `api-builder` + `unit-tester` para APIs testadas

### Crie Workflows

Documente seus workflows favoritos para tarefas recorrentes.

## Troubleshooting

### Agente não encontrado

Verifique se o agente está instalado:
```bash
ls -la ~/meu-projeto/.claude/agents/
```

### Script não executa

Verifique permissões:
```bash
chmod +x scripts/*.sh
```

### Agente não responde como esperado

1. Verifique a versão do agente
2. Sincronize com a versão mais recente
3. Revise o prompt do agente
4. Ajuste o contexto da sua solicitação

## Próximos Passos

- Explore os agentes disponíveis: `./scripts/list-agents.sh --detailed`
- Leia os workflows de exemplo em `/examples`
- Contribua com novos agentes: `docs/contributing.md`
- Compartilhe feedback e sugestões

## Suporte

- Issues: GitHub Issues
- Discussões: GitHub Discussions
- Documentação: `/docs`
