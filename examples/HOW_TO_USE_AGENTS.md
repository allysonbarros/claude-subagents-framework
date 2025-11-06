# 🎯 Como Usar os Agentes em Projetos Reais - Guia Prático

Este guia mostra **exemplos concretos** de como invocar e usar os agentes do framework em projetos reais.

---

## 📋 Índice Rápido

1. [Template de Invocação](#template-de-invocação)
2. [Exemplos por Categoria](#exemplos-por-categoria)
3. [Fluxos Comuns](#fluxos-comuns)
4. [Boas Práticas](#boas-práticas)

---

## 🎨 Template de Invocação

### Formato Básico

```
Use o agente <nome-do-agente> para <objetivo-claro>
```

### Formato Completo (Recomendado)

```
Use o agente <nome-do-agente> para <objetivo>

Contexto:
<Descreva o contexto do projeto, arquivos relevantes, decisões já tomadas>

Requisitos:
<Liste requisitos específicos, constraints, preferências>

Stack/Tecnologias:
<Tecnologias que devem ser usadas>

Tarefas:
1. <Tarefa específica 1>
2. <Tarefa específica 2>
...

Output esperado:
<Descreva o que você quer receber: código, documentação, diagrama, etc>
```

---

## 📂 Exemplos por Categoria

### 🎯 1. ESTRATEGISTAS

#### Product Manager

**Exemplo 1: Analisar Requisitos de Feature**

```
Use o agente product-manager para analisar os requisitos de uma feature de notificações push

Contexto:
Temos uma app mobile de e-commerce com 50K usuários ativos.
Queremos adicionar notificações push para aumentar engagement.

Requisitos:
- Notificações de promoções
- Lembretes de carrinho abandonado
- Atualizações de pedido
- Permitir opt-out

Tarefas:
1. Defina user stories para cada tipo de notificação
2. Priorize usando MoSCoW
3. Estime esforço (S/M/L)
4. Identifique riscos e dependências
5. Sugira métricas de sucesso

Output esperado:
- PRD da feature
- User stories com critérios de aceitação
- Timeline estimado
```

**Exemplo 2: Priorizar Backlog**

```
Use o agente product-manager para priorizar nosso backlog de Q1

Contexto:
Startup SaaS B2B, time de 5 devs, 1000 clientes paying.

Features no backlog:
1. Integração com Salesforce
2. Dashboard customizável
3. Exportação para Excel
4. API pública
5. App mobile
6. Modo dark
7. Suporte SSO/SAML

Tarefas:
1. Priorize usando framework RICE (Reach, Impact, Confidence, Effort)
2. Identifique quick wins
3. Sugira ordem de implementação
4. Estime ROI de cada feature

Output esperado:
Backlog priorizado com justificativa
```

---

#### Tech Architect

**Exemplo 1: Arquitetura de Microserviços**

```
Use o agente tech-architect para desenhar a arquitetura de microserviços da nossa plataforma

Contexto:
Migrando monolito Rails para microserviços.
Tráfego atual: 10K req/min, crescendo 20%/mês.

Requisitos:
- Separar billing, auth, notifications em serviços
- Manter monolito para features legacy
- Usar event-driven architecture
- Deploy independente por serviço

Stack sugerido:
- Node.js/Python para novos serviços
- Kafka para events
- Kubernetes para orchestration

Tarefas:
1. Desenhe arquitetura de alto nível
2. Defina boundaries dos serviços
3. Escolha padrões de comunicação (sync/async)
4. Estratégia de data consistency
5. Plano de migração gradual

Output esperado:
- Diagrama de arquitetura (texto/mermaid)
- Decisões técnicas justificadas
- Plano de migração em fases
```

**Exemplo 2: Escolher Database**

```
Use o agente tech-architect para escolher o banco de dados ideal para nosso caso de uso

Contexto:
App de analytics em tempo real.
Precisamos armazenar milhões de eventos/dia.

Requisitos:
- Queries agregadas rápidas (GROUP BY, COUNT)
- Time-series data
- Retention de 2 anos
- Suportar 10K writes/segundo
- Budget limitado

Opções considerando:
- PostgreSQL + TimescaleDB
- ClickHouse
- MongoDB
- DynamoDB

Tarefas:
1. Compare as opções (pros/cons)
2. Considere custo, performance, operacional
3. Recomende solução principal + fallback
4. Justifique tecnicamente

Output esperado:
Análise comparativa e recomendação fundamentada
```

---

#### API Designer

**Exemplo: Design de API GraphQL**

```
Use o agente api-designer para criar o schema GraphQL de uma plataforma social

Contexto:
Rede social para profissionais (tipo LinkedIn).

Entidades principais:
- Users (perfis)
- Posts (texto, imagens, vídeo)
- Comments
- Reactions (like, celebrate, etc)
- Connections (seguir/ser seguido)

Requisitos:
- Feed personalizado (algoritmo)
- Notificações em tempo real
- Busca de usuários e posts
- Paginação (cursor-based)

Tarefas:
1. Desenhe schema GraphQL completo
2. Defina queries, mutations, subscriptions
3. Especifique tipos e relacionamentos
4. Inclua exemplos de queries
5. Considere N+1 problem (DataLoader)

Output esperado:
- schema.graphql completo
- Exemplos de uso
- Notas sobre performance
```

---

### 🔍 2. PESQUISADORES

#### Code Explorer

**Exemplo: Entender Codebase Legacy**

```
Use o agente code-explorer para entender como funciona o sistema de pagamentos nesta codebase

Contexto:
Código legado PHP/Laravel sem documentação.
Preciso adicionar novo método de pagamento (PIX).

Arquivos potencialmente relevantes:
- app/Services/PaymentService.php
- app/Models/Payment.php
- routes/api.php (payments)

Tarefas:
1. Mapeie o fluxo completo de um pagamento
2. Identifique classes e métodos principais
3. Encontre onde novos métodos são registrados
4. Identifique dependências externas (APIs)
5. Sugira onde adicionar código PIX

Output esperado:
- Diagrama de fluxo do pagamento
- Lista de arquivos a modificar
- Pontos de extensão identificados
```

---

#### Tech Scout

**Exemplo: Pesquisar Biblioteca para Feature**

```
Use o agente tech-scout para encontrar a melhor biblioteca de gráficos para nosso dashboard React

Contexto:
Dashboard analytics com React + TypeScript.
Preciso renderizar ~20 gráficos simultaneamente.

Requisitos:
- Suporte a line, bar, pie, area charts
- Performance com datasets grandes (10K+ pontos)
- TypeScript support
- Customização visual
- SSR compatible (Next.js)
- Bundle size razoável

Opções a considerar:
- Recharts
- Victory
- Chart.js (react-chartjs-2)
- visx (Airbnb)
- Plotly

Tarefas:
1. Compare features de cada biblioteca
2. Avalie performance (benchmarks)
3. Verifique bundle size
4. Considere DX e documentação
5. Recomende top 2 opções

Output esperado:
Tabela comparativa + recomendação justificada
```

---

#### Dependency Analyzer

**Exemplo: Auditoria de Segurança**

```
Use o agente dependency-analyzer para fazer auditoria de segurança do nosso package.json

Contexto:
Projeto Node.js crítico (fintech).
Última auditoria foi há 6 meses.

Arquivo:
package.json com ~50 dependencies

Tarefas:
1. Rode npm audit e analise vulnerabilidades
2. Identifique dependências desatualizadas
3. Encontre dependências não utilizadas
4. Verifique licenses (evitar GPL)
5. Sugira atualizações seguras
6. Identifique bundle bloat

Output esperado:
- Relatório de vulnerabilidades (críticas primeiro)
- Plano de atualização priorizado
- Scripts para limpeza
```

---

### 🎨 3. DESIGNERS

#### UI Designer

**Exemplo: Design de Componente**

```
Use o agente ui-designer para criar o design de um card de produto para e-commerce

Contexto:
E-commerce de moda, público jovem (18-30 anos).
Design system: Tailwind CSS.

Requisitos do card:
- Imagem do produto (hover = segunda imagem)
- Nome, preço, desconto se houver
- Badge "Novo" ou "Promoção"
- Botão "Adicionar ao carrinho"
- Ícone de favoritar
- 4-5 variações (cores)

Responsive:
- Mobile: 1 coluna
- Tablet: 2 colunas
- Desktop: 4 colunas

Tarefas:
1. Crie design em texto/ASCII ou Tailwind classes
2. Defina cores, espaçamentos, tipografia
3. Especifique estados (hover, active, disabled)
4. Inclua animações sutis
5. Considere acessibilidade (WCAG 2.1 AA)

Output esperado:
- HTML + Tailwind CSS do componente
- Variações de estado
- Notas de acessibilidade
```

---

#### UX Specialist

**Exemplo: Fluxo de Onboarding**

```
Use o agente ux-specialist para redesenhar o fluxo de onboarding da nossa app SaaS

Contexto:
SaaS de gestão de projetos.
Problema atual: 60% dos users não completam onboarding.
Tempo médio para "aha moment": 45 minutos (muito alto).

Dados:
- Drop-off maior na criação do primeiro projeto
- Usuários não entendem workspaces vs projects
- Muitos campos obrigatórios assustam

Requisitos:
- Reduzir para < 5 minutos
- Mostrar valor rápido (quick win)
- Permitir pular etapas
- Usar progressive disclosure

Tarefas:
1. Analise o fluxo atual e identifique friction points
2. Desenhe novo fluxo (user journey)
3. Aplique princípios de UX (progressive disclosure, chunking)
4. Defina primeira "vitória" do usuário
5. Sugira copy e microcopy
6. Inclua métricas para medir sucesso

Output esperado:
- User journey map (antes/depois)
- Wireframes de cada tela (texto)
- Copy sugerido
- Métricas de sucesso
```

---

### 💻 4. FRONTEND

#### React Specialist

**Exemplo 1: Componente Complexo**

```
Use o agente react-specialist para criar um componente de DataTable avançado

Contexto:
Dashboard admin, React 18 + TypeScript + Tailwind.

Requisitos:
- Paginação server-side
- Sorting multi-coluna
- Filtros por coluna
- Seleção de linhas (checkbox)
- Ações em batch
- Responsive (mobile = cards)
- Virtualization para 10K+ linhas
- Export to CSV

Dados de exemplo:
```typescript
interface User {
  id: string;
  name: string;
  email: string;
  role: 'admin' | 'user';
  createdAt: Date;
  status: 'active' | 'inactive';
}
```

Tarefas:
1. Crie componente DataTable genérico e reutilizável
2. Use React hooks (useState, useEffect, useMemo)
3. Implemente virtualization (react-window)
4. Adicione TypeScript types
5. Torne acessível (keyboard navigation)
6. Crie testes (React Testing Library)

Output esperado:
- Código completo do componente
- Tipos TypeScript
- Exemplo de uso
- Testes básicos
```

**Exemplo 2: Custom Hook**

```
Use o agente react-specialist para criar um hook useApi para chamadas HTTP

Contexto:
Precisamos de um hook reutilizável para chamadas de API.

Requisitos:
- Suporte GET, POST, PUT, DELETE
- Loading, error, data states
- Retry automático (3x)
- Cache de respostas (opcional)
- TypeScript genérico
- Integração com React Query

Exemplo de uso desejado:
```typescript
const { data, loading, error, refetch } = useApi<User[]>({
  url: '/api/users',
  method: 'GET',
  cache: true
});
```

Tarefas:
1. Implemente hook useApi
2. Adicione retry logic
3. Implemente cache simples
4. TypeScript generics
5. Tratamento de erros
6. Testes do hook

Output esperado:
Código completo + testes + exemplo de uso
```

---

#### State Manager

**Exemplo: Store com Zustand**

```
Use o agente state-manager para criar um store Zustand para carrinho de compras

Contexto:
E-commerce, usando Zustand para state global.

Requisitos do carrinho:
- Add/remove items
- Update quantity
- Calcular total
- Aplicar cupom de desconto
- Persistir no localStorage
- Sincronizar entre abas

Interface:
```typescript
interface CartItem {
  id: string;
  name: string;
  price: number;
  quantity: number;
  image: string;
}
```

Tarefas:
1. Crie store Zustand tipado
2. Implemente actions (add, remove, update, clear)
3. Adicione computed values (total, itemCount)
4. Persista com middleware
5. Adicione DevTools
6. Crie testes

Output esperado:
- Store completo
- Tipos TypeScript
- Exemplo de uso em componente
- Testes
```

---

### 🔧 5. BACKEND

#### FastAPI Specialist

**Exemplo: CRUD Completo**

```
Use o agente fastapi-specialist para criar um CRUD completo de produtos

Contexto:
API REST para e-commerce, FastAPI + PostgreSQL + SQLAlchemy.

Model:
```python
class Product:
    id: UUID
    name: str
    description: str
    price: Decimal
    stock: int
    category_id: UUID
    images: List[str]
    created_at: datetime
    updated_at: datetime
```

Requisitos:
- CRUD completo (Create, Read, Update, Delete)
- Paginação (limit/offset)
- Filtros (categoria, preço min/max, busca)
- Ordenação (preço, nome, data)
- Validação com Pydantic
- Documentação OpenAPI automática
- Testes com pytest

Tarefas:
1. Crie modelo SQLAlchemy
2. Crie schemas Pydantic (request/response)
3. Implemente endpoints REST
4. Adicione filtros e paginação
5. Tratamento de erros
6. Testes completos (>80% coverage)

Output esperado:
- models.py
- schemas.py
- routers/products.py
- tests/test_products.py
```

---

#### Database Specialist

**Exemplo: Otimizar Query Lenta**

```
Use o agente database-specialist para otimizar esta query que está lenta

Contexto:
PostgreSQL 15, tabela orders com 10M de registros.

Query problemática:
```sql
SELECT
    u.name,
    COUNT(o.id) as order_count,
    SUM(o.total) as total_spent
FROM users u
LEFT JOIN orders o ON o.user_id = u.id
WHERE o.created_at >= NOW() - INTERVAL '30 days'
GROUP BY u.id, u.name
ORDER BY total_spent DESC
LIMIT 100;
```

Problema:
- Demora 15 segundos
- Sem índices
- 100K usuários, 10M pedidos

Tarefas:
1. Analise EXPLAIN da query
2. Identifique bottlenecks
3. Sugira índices apropriados
4. Reescreva query se necessário
5. Considere materialized view
6. Estime melhoria de performance

Output esperado:
- Query otimizada
- DDL para índices
- EXPLAIN comparativo (antes/depois)
- Estimativa de performance
```

---

### 🧪 6. TESTADORES

#### Unit Tester

**Exemplo: Testes para Função de Validação**

```
Use o agente unit-tester para criar testes completos para esta função de validação de CPF

Contexto:
Projeto TypeScript/Jest.

Função a testar:
```typescript
function isValidCPF(cpf: string): boolean {
  // Remove caracteres não numéricos
  const cleaned = cpf.replace(/\D/g, '');

  // Valida tamanho
  if (cleaned.length !== 11) return false;

  // Valida dígitos repetidos
  if (/^(\d)\1{10}$/.test(cleaned)) return false;

  // Calcula dígitos verificadores
  // ... lógica de validação
  return true;
}
```

Tarefas:
1. Crie test suite completa (Jest)
2. Testes de casos válidos
3. Testes de casos inválidos
4. Edge cases (null, undefined, vazio)
5. Testes de formato (com/sem pontuação)
6. Coverage de 100%

Output esperado:
- isValidCPF.test.ts completo
- Mínimo 15 casos de teste
- Comentários explicando cada caso
```

---

#### E2E Tester

**Exemplo: Fluxo de Compra**

```
Use o agente e2e-tester para criar teste E2E do fluxo completo de compra

Contexto:
E-commerce, usando Playwright.

Fluxo a testar:
1. Usuário visita produto
2. Adiciona ao carrinho
3. Vai para checkout
4. Preenche endereço
5. Escolhe pagamento
6. Confirma pedido
7. Vê página de confirmação

Requisitos:
- Teste em Chrome e Firefox
- Mobile e desktop viewports
- Screenshot em caso de falha
- Retry em caso de timeout
- Dados de teste isolados

Tarefas:
1. Crie teste Playwright completo
2. Use Page Object Model
3. Adicione assertions apropriadas
4. Trate loading states
5. Configure retry e screenshots
6. Documente setup necessário

Output esperado:
- checkout.spec.ts completo
- Page objects
- Fixtures de teste
- README de setup
```

---

### ⚙️ 7. DEVOPS

#### Docker Specialist

**Exemplo: Dockerfile Multi-stage**

```
Use o agente docker-specialist para criar um Dockerfile otimizado para nossa app Next.js

Contexto:
App Next.js 14 com App Router, deploy em production.

Requisitos:
- Multi-stage build (build + runtime)
- Menor imagem possível
- Node.js 20 LTS
- Cache de node_modules
- Non-root user
- Health check
- .dockerignore apropriado

Tarefas:
1. Crie Dockerfile multi-stage
2. Otimize layers para cache
3. Use alpine quando possível
4. Configure health check
5. Crie .dockerignore
6. Documente build e run

Output esperado:
- Dockerfile otimizado
- .dockerignore
- docker-compose.yml (dev)
- Comandos de build/run
- Tamanho estimado da imagem
```

---

#### CI/CD Engineer

**Exemplo: Pipeline GitHub Actions**

```
Use o agente ci-cd-engineer para criar pipeline completo de CI/CD

Contexto:
Monorepo com frontend (Next.js) e backend (FastAPI).
Deploy em AWS ECS.

Requisitos:
- Trigger em push para main
- Testes paralelos (frontend + backend)
- Build de Docker images
- Deploy automático para staging
- Deploy manual para production
- Notificações no Slack

Tarefas:
1. Crie workflow GitHub Actions
2. Jobs paralelos para teste
3. Build e push de imagens Docker
4. Deploy para ECS
5. Rollback automático se falhar
6. Notificações de status

Output esperado:
- .github/workflows/deploy.yml completo
- Scripts auxiliares
- Documentação de secrets necessários
```

---

### 📊 8. ANALYTICS

#### Event Tracker

**Exemplo: Implementar Tracking**

```
Use o agente event-tracker para implementar tracking de eventos com Segment

Contexto:
App React, usando Segment como CDP.

Eventos a rastrear:
1. Page views
2. Button clicks (CTAs)
3. Form submissions
4. Purchases
5. User signup

Requisitos:
- Wrapper React para Segment
- TypeScript para eventos tipados
- Tracking de propriedades customizadas
- Suporte a user identification
- Modo debug
- Testes sem enviar dados reais

Tarefas:
1. Configure Segment SDK
2. Crie wrapper tipado
3. Implemente hook useTracking
4. Defina eventos e propriedades
5. Adicione user identification
6. Crie modo debug/staging

Output esperado:
- analytics.ts (wrapper)
- events.types.ts (eventos tipados)
- useTracking hook
- Exemplo de uso
- Testes
```

---

## 🔄 Fluxos Comuns de Trabalho

### Fluxo 1: Nova Feature End-to-End

```
1. Product Manager
   → Definir requisitos e user stories

2. Tech Architect
   → Desenhar solução técnica

3. API Designer (se precisar de API)
   → Design dos endpoints

4. UI Designer + UX Specialist
   → Design da interface

5. Backend Specialist (FastAPI/Django/etc)
   → Implementar API

6. Frontend Specialist (React/etc)
   → Implementar UI

7. Security Specialist
   → Revisar segurança

8. Unit Tester + E2E Tester
   → Criar testes

9. Performance Optimizer
   → Otimizar

10. DevOps (Docker + CI/CD)
    → Preparar deploy
```

### Fluxo 2: Debugging e Otimização

```
1. Code Explorer
   → Entender código problemático

2. Database Specialist (se query lenta)
   → Analisar e otimizar queries

3. Performance Optimizer
   → Profiling e otimizações

4. Test Strategist
   → Garantir não quebrou nada
```

### Fluxo 3: Projeto do Zero

```
1. Product Manager
   → PRD completo

2. Tech Architect
   → Arquitetura e stack

3. Design System Builder (se precisar)
   → Setup de design tokens

4. Security Specialist
   → Definir políticas de segurança

5. Database Specialist
   → Design de schema

6. Implementação paralela:
   - Backend specialists
   - Frontend specialists
   - DevOps (infra)

7. Testers (paralelo)
   → Testes desde o início (TDD)

8. Final: Deploy e monitoring
```

---

## ✅ Boas Práticas

### 1. Seja Específico

❌ **Ruim:**
```
Use o agente react-specialist para criar um componente
```

✅ **Bom:**
```
Use o agente react-specialist para criar um componente de DataTable com paginação server-side, sorting e filtros, usando React 18 + TypeScript + Tailwind CSS
```

### 2. Forneça Contexto

❌ **Ruim:**
```
Crie uma API REST
```

✅ **Bom:**
```
Use o agente fastapi-specialist para criar API REST de produtos

Contexto:
- E-commerce com 50K SKUs
- PostgreSQL database
- Precisa suportar 1K req/min
- Deploy em AWS Lambda

(+ detalhes do modelo, requisitos, etc)
```

### 3. Especifique Output Desejado

✅ **Bom:**
```
Output esperado:
- Código completo funcional
- Testes com >80% coverage
- Documentação de uso
- Exemplo de chamada da API
```

### 4. Itere e Refine

Não espere perfeição na primeira tentativa:

```
1ª tentativa: "Crie um componente de tabela"
2ª tentativa: "Adicione paginação ao componente"
3ª tentativa: "Otimize para 10K linhas com virtualization"
```

### 5. Use Múltiplos Agentes

Não tente fazer tudo com um agente:

✅ **Bom fluxo:**
```
1. Tech Architect → Define arquitetura
2. API Designer → Design da API
3. FastAPI Specialist → Implementa
4. Unit Tester → Cria testes
```

---

## 📚 Próximos Passos

- Ver exemplos completos em: [examples/project-1-saas-analytics/](project-1-saas-analytics/)
- Ver mais projetos: [PROJECT_IDEAS.md](../PROJECT_IDEAS.md)
- Validar agentes: [scripts/validation/](../scripts/validation/)

---

**Dica:** Copie e adapte os templates acima para seus projetos! 🚀
