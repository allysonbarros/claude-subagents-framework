# Exemplo: Desenvolvimento de Nova Feature

Este exemplo demonstra como usar os agentes para desenvolver uma feature completa, do planejamento ao deploy.

## Cenário

Você precisa adicionar um sistema de notificações em tempo real na sua aplicação existente.

## Workflow Recomendado

### Fase 1: Análise e Planejamento

**Agentes:** `product-manager`, `codebase-explorer`

```
Use o agente codebase-explorer para mapear:
1. Arquitetura atual da aplicação
2. Pontos de integração para notificações
3. Bibliotecas e padrões já utilizados
```

```
Use o agente product-manager para:
1. Detalhar requisitos da feature
2. Definir casos de uso
3. Identificar edge cases
```

### Fase 2: Design Técnico

**Agentes:** `tech-lead`, `api-builder`

```
Use o agente tech-lead para definir:
1. Arquitetura da solução (WebSockets vs Server-Sent Events)
2. Estrutura de dados das notificações
3. Estratégia de persistência
```

```
Use o agente api-builder para especificar:
1. Endpoints necessários
2. Eventos do WebSocket
3. Schema do banco de dados
```

### Fase 3: Design de Interface

**Agentes:** `ui-designer`, `react-specialist`

```
Use o agente ui-designer para criar:
1. Componente de notificação (toast/banner)
2. Centro de notificações
3. Estados visuais (lida/não lida)
```

```
Use o agente react-specialist para planejar:
1. Estrutura de componentes React
2. Gerenciamento de estado
3. Context/Provider para notificações
```

### Fase 4: Implementação Backend

**Agentes:** `api-builder`, `database-expert`

```
Use o agente database-expert para:
1. Criar migration do schema de notificações
2. Adicionar índices apropriados
3. Configurar relacionamentos
```

```
Use o agente api-builder para implementar:
1. Servidor WebSocket
2. Endpoints REST para notificações
3. Lógica de broadcast e targeting
```

### Fase 5: Implementação Frontend

**Agentes:** `react-specialist`, `css-expert`

```
Use o agente react-specialist para implementar:
1. Hook useNotifications
2. NotificationProvider
3. Componentes de UI
4. Integração com WebSocket
```

```
Use o agente css-expert para:
1. Animações de entrada/saída
2. Responsividade
3. Temas dark/light
```

### Fase 6: Testes

**Agentes:** `unit-tester`, `integration-tester`

```
Use o agente unit-tester para criar testes:
1. Hook useNotifications
2. Componentes React
3. Funções utilitárias
```

```
Use o agente integration-tester para testar:
1. Fluxo completo de notificação
2. Conexão WebSocket
3. Persistência e recuperação
4. Casos edge (desconexão, reconexão)
```

### Fase 7: DevOps e Deploy

**Agentes:** `ci-cd-specialist`, `docker-expert`

```
Use o agente ci-cd-specialist para:
1. Atualizar pipeline de CI/CD
2. Adicionar testes da nova feature
3. Configurar deploy gradual (feature flag)
```

```
Use o agente docker-expert para:
1. Atualizar configurações se necessário
2. Verificar escalabilidade do WebSocket
3. Configurar health checks
```

### Fase 8: Monitoramento

**Agentes:** `data-analyst`

```
Use o agente data-analyst para configurar:
1. Tracking de eventos de notificação
2. Métricas de performance
3. Dashboard de monitoramento
```

## Checklist de Conclusão

- [ ] Requisitos documentados
- [ ] Arquitetura definida e aprovada
- [ ] Design de UI aprovado
- [ ] Backend implementado e testado
- [ ] Frontend implementado e testado
- [ ] Testes automatizados passando
- [ ] Code review realizado
- [ ] Deploy em staging
- [ ] QA em staging
- [ ] Monitoramento configurado
- [ ] Deploy em produção
- [ ] Documentação atualizada

## Comandos Úteis

```bash
# Listar agentes usados neste workflow
./scripts/list-agents.sh --category strategists
./scripts/list-agents.sh --category researchers
./scripts/list-agents.sh --category designers
./scripts/list-agents.sh --category frontend
./scripts/list-agents.sh --category backend
./scripts/list-agents.sh --category testers
./scripts/list-agents.sh --category devops
./scripts/list-agents.sh --category analytics

# Sincronizar todos os agentes antes de começar
for agent in product-manager codebase-explorer tech-lead api-builder ui-designer react-specialist database-expert css-expert unit-tester integration-tester ci-cd-specialist data-analyst; do
    ./scripts/sync-agent.sh $agent ~/meu-projeto
done
```

## Variações do Workflow

### Feature Simples
Para features mais simples, você pode pular:
- Fase 2 (Design Técnico) - Se a solução for óbvia
- Fase 8 (Monitoramento) - Se não for crítico

### Feature Crítica
Para features críticas, adicione:
- **Security Review**: Use agente de segurança antes do deploy
- **Performance Testing**: Teste de carga antes de produção
- **Rollback Plan**: Documente estratégia de rollback

### Feature Experimental
Para experimentos:
- Adicione **Feature Flags** desde o início
- Configure **A/B Testing** com agente de analytics
- Implemente **Métricas de Sucesso** claras

## Tempo Estimado

- Fase 1: 2-3 horas
- Fase 2: 2-3 horas
- Fase 3: 2-3 horas
- Fase 4: 4-6 horas
- Fase 5: 4-6 horas
- Fase 6: 3-4 horas
- Fase 7: 2-3 horas
- Fase 8: 1-2 horas

**Total: 20-30 horas** (vs. 40-60 horas sem os agentes)

## Dicas de Produtividade

1. **Trabalhe em Paralelo**: Frontend e Backend podem ser desenvolvidos simultaneamente após o design
2. **TDD**: Escreva testes antes da implementação quando possível
3. **Code Review Contínuo**: Revise código incrementalmente, não apenas no final
4. **Deploy Pequeno**: Faça deploys incrementais quando possível
