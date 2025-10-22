# Guia de Contribuição

Obrigado por considerar contribuir com o Claude Subagents Framework!

## Como Contribuir

### Reportando Bugs

Abra uma issue incluindo:
- Descrição clara do problema
- Passos para reproduzir
- Comportamento esperado vs atual
- Versão do agente
- Ambiente (OS, versão do Claude Code)

### Sugerindo Melhorias

Abra uma issue com:
- Descrição da melhoria
- Caso de uso
- Benefícios esperados
- Impacto em agentes existentes

### Contribuindo com Código

1. Fork o repositório
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Faça suas alterações
4. Teste suas alterações
5. Commit suas mudanças
6. Push para a branch
7. Abra um Pull Request

## Criando Novos Agentes

### 1. Escolha a Categoria

Determine em qual categoria seu agente se encaixa:
- **Estrategistas**: Planejamento e arquitetura
- **Pesquisadores**: Exploração e análise
- **Designers**: UI/UX
- **Frontend**: Desenvolvimento web client-side
- **Backend**: APIs e serviços
- **Testadores**: QA e testes
- **DevOps**: Infraestrutura e deploy
- **Analytics**: Dados e métricas

### 2. Use o Template

Copie `templates/agent-template.md` para a categoria apropriada:

```bash
cp templates/agent-template.md agents/[categoria]/[nome-do-agente].md
```

### 3. Preencha o Template

Complete todas as seções:

#### Descrição
- Seja conciso (2-3 frases)
- Explique o propósito do agente
- Destaque diferenciais

#### Capacidades
- Liste 5-10 capacidades principais
- Seja específico
- Use verbos de ação

#### Quando Usar
- 3-5 cenários práticos
- Seja específico com contextos
- Inclua contra-indicações

#### Ferramentas Disponíveis
- Liste todas as ferramentas do Claude Code que o agente usa
- Explique casos de uso específicos se necessário

#### Prompt do Agente
- Prompt completo e funcional
- Inclua contexto e papel
- Defina formato de saída
- Adicione exemplos
- Estabeleça limites e restrições

#### Exemplos de Uso
- Mínimo 2 exemplos práticos
- Inclua contexto, comando e resultado esperado
- Mostre casos de uso reais

#### Dependências
- Liste agentes complementares
- Explique sinergias

#### Limitações
- Seja honesto sobre limitações
- Ajude usuários a evitar frustrações

### 4. Teste o Agente

Antes de submeter:

1. **Teste Básico**
   - Instale o agente em um projeto de teste
   - Execute os comandos dos exemplos
   - Verifique se funciona como esperado

2. **Teste Edge Cases**
   - Teste com inputs inválidos
   - Teste em diferentes contextos
   - Verifique comportamento com projetos grandes

3. **Teste Integração**
   - Teste com agentes complementares
   - Verifique workflows completos

### 5. Atualize o Registry

Adicione entrada no `registry.json`:

```json
{
  "id": "nome-do-agente",
  "name": "Nome do Agente",
  "category": "categoria",
  "description": "Breve descrição",
  "path": "agents/categoria/nome-do-agente.md",
  "tags": ["tag1", "tag2"],
  "version": "1.0.0",
  "author": "Seu Nome",
  "tools": ["Read", "Write", "Edit"],
  "dependencies": ["outro-agente"],
  "createdAt": "2025-10-22"
}
```

### 6. Documente

Atualize o README da categoria em `agents/[categoria]/README.md`:

```markdown
## Agentes Disponíveis

### Nome do Agente
Breve descrição do agente e link para o arquivo.
```

## Padrões de Qualidade

### Nomenclatura
- Use kebab-case para arquivos: `product-manager.md`
- Use Title Case para nomes: "Product Manager"
- Seja descritivo mas conciso

### Prompts
- Seja claro e específico
- Use exemplos
- Defina formato de saída
- Estabeleça limitações
- Inclua contexto de domínio

### Documentação
- Escreva em português brasileiro
- Use markdown corretamente
- Inclua exemplos práticos
- Seja objetivo

### Versionamento
Seguimos Semantic Versioning:
- **MAJOR**: Mudanças incompatíveis
- **MINOR**: Novas funcionalidades compatíveis
- **PATCH**: Correções de bugs

Exemplos:
- `1.0.0` → `2.0.0`: Prompt completamente reformulado
- `1.0.0` → `1.1.0`: Nova capacidade adicionada
- `1.0.0` → `1.0.1`: Correção de typo ou melhoria menor

## Modificando Agentes Existentes

### Pequenas Mudanças
- Correções de texto
- Melhorias na documentação
- Novos exemplos

Podem ser feitas diretamente via PR.

### Mudanças Grandes
- Alteração no prompt principal
- Nova capacidade
- Mudança de comportamento

Abra uma issue primeiro para discussão.

## Review Process

1. **Automated Checks**
   - Formato do JSON
   - Links válidos
   - Estrutura do markdown

2. **Manual Review**
   - Qualidade do prompt
   - Clareza da documentação
   - Utilidade do agente
   - Testes realizados

3. **Feedback**
   - Responda ao feedback construtivamente
   - Faça ajustes solicitados
   - Itere até aprovação

## Código de Conduta

- Seja respeitoso
- Aceite críticas construtivas
- Foque no melhor para a comunidade
- Ajude outros contribuidores

## Dúvidas?

- Abra uma issue com a tag `question`
- Entre em discussões no GitHub
- Consulte exemplos existentes

## Checklist para PRs

Antes de submeter, verifique:

- [ ] Agente testado em cenários reais
- [ ] Template completo
- [ ] registry.json atualizado
- [ ] README da categoria atualizado
- [ ] Exemplos funcionais incluídos
- [ ] Documentação clara
- [ ] Versionamento correto
- [ ] Changelog atualizado
- [ ] Sem typos ou erros gramaticais

## Agradecimentos

Toda contribuição é valiosa! Obrigado por ajudar a melhorar o framework.
