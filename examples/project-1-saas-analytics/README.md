# 📊 Projeto 1: SaaS Analytics Platform - Exemplo Prático

Este exemplo mostra **passo-a-passo** como usar os 15 agentes do framework para construir uma plataforma SaaS Analytics completa.

## 🎯 Objetivo do Projeto

Criar uma plataforma SaaS de analytics com:
- Dashboard de métricas em tempo real
- API RESTful com FastAPI
- Frontend React com TypeScript
- Sistema de autenticação JWT
- Tracking de eventos de usuário
- Testes A/B de features

---

## 👥 Agentes Utilizados (15)

1. Product Manager
2. Tech Architect
3. API Designer
4. Security Specialist
5. FastAPI Specialist
6. Database Specialist
7. React Specialist
8. State Manager
9. UI Designer
10. UX Specialist
11. Event Tracker
12. Metrics Analyst
13. A/B Tester
14. Performance Optimizer
15. Docker Specialist
16. CI/CD Engineer

---

## 🚀 Fluxo Completo de Implementação

### Fase 1: Planejamento e Arquitetura (Dia 1)

---

#### 📝 Passo 1: Product Manager - Definir Requisitos

**Como invocar:**
```
Use o agente product-manager para analisar os requisitos deste projeto de plataforma SaaS Analytics
```

**Prompt detalhado:**
```
Contexto:
Queremos criar uma plataforma SaaS de analytics para empresas B2B acompanharem métricas de produto.

Requisitos iniciais:
- Dashboard com métricas em tempo real
- Sistema de usuários e autenticação
- API para integração com apps
- Tracking de eventos customizados
- Relatórios exportáveis

Tarefas:
1. Defina as principais features (MVP vs Future)
2. Crie user stories para o MVP
3. Identifique os stakeholders e suas necessidades
4. Priorize as features usando framework MoSCoW
5. Estime esforço e timeline
```

**Output esperado:**
```markdown
# Product Requirements Document (PRD)

## Visão do Produto
Plataforma SaaS de analytics que permite empresas B2B rastrearem e
analisarem métricas de produto em tempo real.

## Features MVP (Must Have)
1. **Autenticação e Usuários**
   - Login/Signup com email
   - Perfis de usuário
   - Gestão de organizações

2. **Dashboard de Métricas**
   - Visualização de eventos em tempo real
   - Gráficos de linha, barra e pizza
   - Filtros por período

3. **API de Tracking**
   - Endpoint para enviar eventos
   - SDK JavaScript
   - Autenticação via API key

4. **Eventos Customizados**
   - Definir eventos personalizados
   - Propriedades customizadas
   - Metadados

## User Stories

### US1: Login de Usuário
**Como** gerente de produto
**Quero** fazer login na plataforma
**Para** acessar os dashboards da minha organização

**Critérios de Aceitação:**
- Login com email e senha
- Recuperação de senha via email
- Sessão persiste por 7 dias
- 2FA opcional

### US2: Visualizar Dashboard
**Como** gerente de produto
**Quero** ver métricas em tempo real
**Para** acompanhar performance do produto

**Critérios de Aceitação:**
- Dashboard carrega em < 2s
- Atualização automática a cada 30s
- Filtros por data funcionam
- Exportar para CSV/PDF

(... mais 10 user stories)

## Timeline Estimado
- Sprint 1 (2 semanas): Autenticação + Setup
- Sprint 2 (2 semanas): API de Tracking
- Sprint 3 (2 semanas): Dashboard Básico
- Sprint 4 (2 semanas): Features Avançadas
- Sprint 5 (1 semana): Testes e Deploy

Total: 9 semanas
```

**Arquivos criados:**
- `docs/prd.md`
- `docs/user-stories.md`

---

#### 🏗️ Passo 2: Tech Architect - Definir Arquitetura

**Como invocar:**
```
Use o agente tech-architect para definir a arquitetura técnica da plataforma SaaS Analytics baseado no PRD
```

**Prompt detalhado:**
```
Contexto:
Temos o PRD definido para uma plataforma SaaS Analytics (veja docs/prd.md).

Requisitos técnicos:
- Deve escalar para 1M+ eventos/dia
- Latência de API < 200ms
- 99.9% uptime
- Multi-tenant (isolamento de dados)
- Real-time updates

Stack sugerido:
- Backend: FastAPI + PostgreSQL
- Frontend: React + TypeScript
- Real-time: WebSockets
- Cache: Redis

Tarefas:
1. Desenhe a arquitetura de alto nível
2. Defina os componentes principais e suas responsabilidades
3. Escolha tecnologias e justifique
4. Identifique pontos de escalabilidade
5. Defina estratégia de deploy e infraestrutura
```

**Output esperado:**
```markdown
# Arquitetura Técnica - SaaS Analytics Platform

## Diagrama de Alto Nível

```
┌─────────────┐
│   Browser   │
└──────┬──────┘
       │
       ▼
┌─────────────────────────────────────┐
│         CDN (CloudFlare)            │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│    Frontend (React + Vite)          │
│    - Dashboard UI                   │
│    - Charts (Recharts)              │
│    - State (Zustand)                │
└──────────────┬──────────────────────┘
               │
               ▼
┌─────────────────────────────────────┐
│    API Gateway (Nginx)              │
└──────────────┬──────────────────────┘
               │
       ┌───────┴───────┐
       ▼               ▼
┌─────────────┐  ┌─────────────┐
│  REST API   │  │  WebSocket  │
│  (FastAPI)  │  │   Server    │
└──────┬──────┘  └──────┬──────┘
       │                │
       └────────┬───────┘
                ▼
       ┌────────────────────┐
       │   Redis Cache      │
       │   - Sessions       │
       │   - Real-time data │
       └────────────────────┘
                │
                ▼
       ┌────────────────────┐
       │   PostgreSQL       │
       │   - Users          │
       │   - Events         │
       │   - Analytics      │
       └────────────────────┘
                │
                ▼
       ┌────────────────────┐
       │   Task Queue       │
       │   (Celery+Redis)   │
       └────────────────────┘
```

## Componentes Principais

### 1. Frontend (React + TypeScript)
**Responsabilidades:**
- UI/UX do dashboard
- Visualização de métricas
- Gerenciamento de estado
- WebSocket client para real-time

**Tecnologias:**
- React 18 com hooks
- TypeScript para type safety
- Zustand para state management
- Recharts para gráficos
- TailwindCSS para styling

**Justificativa:**
- React: Ecosystem maduro, performance
- TypeScript: Type safety, melhor DX
- Zustand: Simples, menos boilerplate que Redux

### 2. Backend API (FastAPI)
**Responsabilidades:**
- REST API endpoints
- Autenticação JWT
- Validação de dados
- Business logic
- WebSocket management

**Tecnologias:**
- FastAPI: Async, auto-docs, validation
- Pydantic: Data validation
- SQLAlchemy: ORM
- Alembic: Migrations
- Pytest: Testing

**Justificativa:**
- FastAPI: Performance (async), OpenAPI automático
- Pydantic: Validation robusta
- SQLAlchemy: ORM maduro, suporta async

### 3. Database (PostgreSQL)
**Schema Design:**
```sql
-- Users e Organizations (multi-tenant)
CREATE TABLE organizations (
    id UUID PRIMARY KEY,
    name VARCHAR(255),
    created_at TIMESTAMP
);

CREATE TABLE users (
    id UUID PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id),
    email VARCHAR(255) UNIQUE,
    hashed_password VARCHAR(255),
    created_at TIMESTAMP
);

-- Events (particionado por mês)
CREATE TABLE events (
    id BIGSERIAL PRIMARY KEY,
    organization_id UUID,
    event_name VARCHAR(255),
    properties JSONB,
    user_id VARCHAR(255),
    timestamp TIMESTAMP,
    INDEX idx_org_timestamp (organization_id, timestamp),
    INDEX idx_event_name (event_name)
) PARTITION BY RANGE (timestamp);

-- Métricas agregadas (materializado)
CREATE MATERIALIZED VIEW daily_metrics AS
SELECT
    organization_id,
    event_name,
    DATE(timestamp) as date,
    COUNT(*) as event_count,
    COUNT(DISTINCT user_id) as unique_users
FROM events
GROUP BY organization_id, event_name, DATE(timestamp);
```

**Justificativa:**
- PostgreSQL: Suporte JSONB, particionamento, MVCC
- Particionamento por timestamp: Performance em queries
- Materialized views: Agregações pré-calculadas

### 4. Cache Layer (Redis)
**Uso:**
- Session storage (JWT tokens)
- Real-time metrics cache
- Rate limiting
- Task queue backend

### 5. Task Queue (Celery)
**Tarefas assíncronas:**
- Envio de emails
- Geração de relatórios
- Agregação de métricas
- Exportação de dados

## Decisões de Arquitetura

### Multi-tenancy
**Abordagem:** Shared database, Row-level isolation

```python
# Toda query filtra por organization_id
def get_events(org_id: UUID, filters: dict):
    query = db.query(Event).filter(
        Event.organization_id == org_id,  # Sempre!
        **filters
    )
    return query.all()
```

**Vantagens:**
- Custo reduzido (um DB)
- Manutenção simples
- Backups centralizados

**Desvantagens mitigadas:**
- Risco de vazamento: Middleware automático
- Performance: Índices por org_id

### Real-time Updates
**Abordagem:** WebSockets + Redis Pub/Sub

```python
# Publisher (quando novo evento chega)
await redis.publish(
    f"org:{org_id}:events",
    json.dumps(event_data)
)

# Subscriber (WebSocket server)
async def listen_events(org_id: UUID):
    pubsub = redis.pubsub()
    await pubsub.subscribe(f"org:{org_id}:events")

    async for message in pubsub.listen():
        await websocket.send_json(message)
```

### Escalabilidade

**Horizontal Scaling:**
- API servers: Stateless, escala com load balancer
- WebSocket servers: Sticky sessions via Redis
- Workers: Celery workers adicionais

**Vertical Scaling:**
- PostgreSQL: Read replicas
- Redis: Redis Cluster

**Limites esperados:**
- 10K eventos/segundo por instância
- 1M eventos/dia = ~12 eventos/segundo (fácil)

## Infraestrutura e Deploy

### Ambiente de Produção
```yaml
# docker-compose.prod.yml (simplificado)
services:
  nginx:
    image: nginx:alpine
    ports: ["80:80", "443:443"]

  api:
    image: analytics-api:latest
    replicas: 3
    environment:
      DATABASE_URL: ${DATABASE_URL}
      REDIS_URL: ${REDIS_URL}

  websocket:
    image: analytics-ws:latest
    replicas: 2

  frontend:
    image: analytics-frontend:latest

  postgres:
    image: postgres:15
    volumes:
      - postgres-data:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine

  celery-worker:
    image: analytics-api:latest
    command: celery -A app.worker worker
    replicas: 2
```

### CI/CD Pipeline
```yaml
# .github/workflows/deploy.yml
name: Deploy
on:
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run tests
        run: |
          pytest tests/
          npm test

  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - name: Build Docker images
        run: |
          docker build -t api:${{ github.sha }} .
          docker build -t frontend:${{ github.sha }} frontend/

  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to production
        run: |
          kubectl set image deployment/api api=api:${{ github.sha }}
          kubectl set image deployment/frontend frontend=frontend:${{ github.sha }}
```

## Estratégia de Monitoramento

### Métricas Chave
- **Latência P95 da API** < 200ms
- **Uptime** > 99.9%
- **Erro rate** < 0.1%
- **Events processed/second**

### Ferramentas
- Prometheus: Coleta de métricas
- Grafana: Dashboards
- Sentry: Error tracking
- DataDog: APM (Application Performance Monitoring)

## Segurança

### Autenticação
- JWT tokens (15 min expiration)
- Refresh tokens (7 dias)
- 2FA via TOTP (opcional)

### Autorização
- RBAC (Role-Based Access Control)
- Roles: Admin, Member, Viewer

### Data Protection
- Encryption at rest (PostgreSQL)
- Encryption in transit (TLS)
- API rate limiting (100 req/min por IP)

## Próximos Passos

1. ✅ Arquitetura definida
2. → API Designer: Desenhar endpoints REST
3. → Database Specialist: Refinar schema
4. → Security Specialist: Implementar auth
5. → Implementação por módulos
```

**Arquivos criados:**
- `docs/architecture.md`
- `docs/infrastructure.md`
- `diagrams/architecture-diagram.png`

---

#### 🎨 Passo 3: API Designer - Desenhar API RESTful

**Como invocar:**
```
Use o agente api-designer para criar o design completo da API REST da plataforma analytics
```

**Prompt detalhado:**
```
Contexto:
Temos a arquitetura definida (veja docs/architecture.md).
Stack: FastAPI + PostgreSQL + JWT auth

Requisitos da API:
- CRUD de usuários e organizações
- Endpoints de tracking de eventos
- Endpoints de consulta de métricas
- Autenticação e autorização
- Documentação OpenAPI

Tarefas:
1. Defina todos os endpoints REST
2. Especifique request/response schemas
3. Defina códigos de status HTTP
4. Crie especificação OpenAPI 3.0
5. Inclua exemplos de uso
```

**Output esperado:**
```yaml
# openapi.yaml
openapi: 3.0.0
info:
  title: SaaS Analytics API
  version: 1.0.0
  description: API for tracking and analyzing product metrics

servers:
  - url: https://api.analytics-platform.com/v1
    description: Production
  - url: http://localhost:8000/v1
    description: Development

security:
  - BearerAuth: []

components:
  securitySchemes:
    BearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT

  schemas:
    User:
      type: object
      properties:
        id:
          type: string
          format: uuid
        email:
          type: string
          format: email
        organization_id:
          type: string
          format: uuid
        created_at:
          type: string
          format: date-time
      example:
        id: "123e4567-e89b-12d3-a456-426614174000"
        email: "user@company.com"
        organization_id: "123e4567-e89b-12d3-a456-426614174001"
        created_at: "2025-01-01T10:00:00Z"

    Event:
      type: object
      required:
        - event_name
        - properties
      properties:
        event_name:
          type: string
          example: "button_clicked"
        properties:
          type: object
          additionalProperties: true
          example:
            button_id: "signup-btn"
            page: "/landing"
        user_id:
          type: string
          example: "user_123"
        timestamp:
          type: string
          format: date-time
      example:
        event_name: "purchase_completed"
        properties:
          product_id: "prod_123"
          amount: 99.99
          currency: "USD"
        user_id: "user_456"
        timestamp: "2025-01-15T14:30:00Z"

    MetricsQuery:
      type: object
      properties:
        event_names:
          type: array
          items:
            type: string
          example: ["page_view", "button_click"]
        start_date:
          type: string
          format: date
        end_date:
          type: string
          format: date
        group_by:
          type: string
          enum: [hour, day, week, month]
          default: day

    MetricsResponse:
      type: object
      properties:
        data:
          type: array
          items:
            type: object
            properties:
              date:
                type: string
              event_name:
                type: string
              count:
                type: integer
              unique_users:
                type: integer

    Error:
      type: object
      properties:
        error:
          type: string
        message:
          type: string
        details:
          type: object

paths:
  # ============================================
  # Autenticação
  # ============================================
  /auth/signup:
    post:
      summary: Criar nova conta
      tags: [Auth]
      security: []
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              required: [email, password, organization_name]
              properties:
                email:
                  type: string
                  format: email
                password:
                  type: string
                  minLength: 8
                organization_name:
                  type: string
            example:
              email: "john@company.com"
              password: "SecurePass123!"
              organization_name: "Acme Inc"
      responses:
        '201':
          description: Conta criada com sucesso
          content:
            application/json:
              schema:
                type: object
                properties:
                  user:
                    $ref: '#/components/schemas/User'
                  access_token:
                    type: string
                  refresh_token:
                    type: string
        '400':
          description: Dados inválidos
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
        '409':
          description: Email já cadastrado

  /auth/login:
    post:
      summary: Login
      tags: [Auth]
      security: []
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              required: [email, password]
              properties:
                email:
                  type: string
                password:
                  type: string
            example:
              email: "john@company.com"
              password: "SecurePass123!"
      responses:
        '200':
          description: Login bem-sucedido
          content:
            application/json:
              schema:
                type: object
                properties:
                  access_token:
                    type: string
                  refresh_token:
                    type: string
                  expires_in:
                    type: integer
                    example: 900
        '401':
          description: Credenciais inválidas

  /auth/refresh:
    post:
      summary: Renovar access token
      tags: [Auth]
      security: []
      requestBody:
        content:
          application/json:
            schema:
              type: object
              required: [refresh_token]
              properties:
                refresh_token:
                  type: string
      responses:
        '200':
          description: Token renovado
          content:
            application/json:
              schema:
                type: object
                properties:
                  access_token:
                    type: string
                  expires_in:
                    type: integer

  # ============================================
  # Events Tracking
  # ============================================
  /track:
    post:
      summary: Enviar evento de tracking
      tags: [Tracking]
      description: |
        Endpoint para rastrear eventos customizados.
        Eventos são processados de forma assíncrona.
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Event'
      responses:
        '202':
          description: Evento aceito para processamento
          content:
            application/json:
              schema:
                type: object
                properties:
                  status:
                    type: string
                    example: "accepted"
                  event_id:
                    type: string
        '400':
          description: Evento inválido
        '429':
          description: Rate limit excedido

  /track/batch:
    post:
      summary: Enviar múltiplos eventos
      tags: [Tracking]
      description: |
        Enviar até 100 eventos de uma vez.
        Mais eficiente que múltiplas chamadas individuais.
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                events:
                  type: array
                  maxItems: 100
                  items:
                    $ref: '#/components/schemas/Event'
      responses:
        '202':
          description: Batch aceito
          content:
            application/json:
              schema:
                type: object
                properties:
                  accepted:
                    type: integer
                  rejected:
                    type: integer
                  errors:
                    type: array
                    items:
                      type: object

  # ============================================
  # Métricas e Analytics
  # ============================================
  /metrics:
    post:
      summary: Consultar métricas
      tags: [Analytics]
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/MetricsQuery'
      responses:
        '200':
          description: Métricas retornadas
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/MetricsResponse'
              example:
                data:
                  - date: "2025-01-15"
                    event_name: "button_click"
                    count: 1250
                    unique_users: 450
                  - date: "2025-01-16"
                    event_name: "button_click"
                    count: 1340
                    unique_users: 480

  /metrics/realtime:
    get:
      summary: Métricas em tempo real
      tags: [Analytics]
      description: |
        Retorna métricas dos últimos 60 minutos,
        atualizadas a cada minuto.
      parameters:
        - name: event_name
          in: query
          schema:
            type: string
      responses:
        '200':
          description: Métricas em tempo real
          content:
            application/json:
              schema:
                type: object
                properties:
                  last_minute:
                    type: integer
                  last_hour:
                    type: integer
                  timeline:
                    type: array
                    items:
                      type: object
                      properties:
                        timestamp:
                          type: string
                        count:
                          type: integer

  /metrics/export:
    post:
      summary: Exportar relatório
      tags: [Analytics]
      requestBody:
        content:
          application/json:
            schema:
              allOf:
                - $ref: '#/components/schemas/MetricsQuery'
                - type: object
                  properties:
                    format:
                      type: string
                      enum: [csv, pdf, json]
      responses:
        '202':
          description: Exportação iniciada
          content:
            application/json:
              schema:
                type: object
                properties:
                  export_id:
                    type: string
                  status:
                    type: string
                    example: "processing"
                  download_url:
                    type: string
                    description: "Disponível quando status = completed"

  # ============================================
  # Users e Organizations
  # ============================================
  /users/me:
    get:
      summary: Obter perfil do usuário atual
      tags: [Users]
      responses:
        '200':
          description: Perfil do usuário
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'

    patch:
      summary: Atualizar perfil
      tags: [Users]
      requestBody:
        content:
          application/json:
            schema:
              type: object
              properties:
                email:
                  type: string
                name:
                  type: string
      responses:
        '200':
          description: Perfil atualizado

  /organizations/me:
    get:
      summary: Dados da organização
      tags: [Organizations]
      responses:
        '200':
          description: Dados da org
          content:
            application/json:
              schema:
                type: object
                properties:
                  id:
                    type: string
                  name:
                    type: string
                  plan:
                    type: string
                  api_key:
                    type: string
                  members_count:
                    type: integer

  /organizations/me/api-keys:
    get:
      summary: Listar API keys
      tags: [Organizations]
      responses:
        '200':
          description: Lista de API keys
          content:
            application/json:
              schema:
                type: array
                items:
                  type: object
                  properties:
                    id:
                      type: string
                    name:
                      type: string
                    key:
                      type: string
                    created_at:
                      type: string

    post:
      summary: Criar nova API key
      tags: [Organizations]
      requestBody:
        content:
          application/json:
            schema:
              type: object
              properties:
                name:
                  type: string
      responses:
        '201':
          description: API key criada
```

**Exemplos de uso:**

```bash
# 1. Signup
curl -X POST https://api.analytics-platform.com/v1/auth/signup \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@company.com",
    "password": "SecurePass123!",
    "organization_name": "Acme Inc"
  }'

# Response:
{
  "user": {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "email": "john@company.com",
    "organization_id": "org_123",
    "created_at": "2025-01-15T10:00:00Z"
  },
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}

# 2. Track event
curl -X POST https://api.analytics-platform.com/v1/track \
  -H "Authorization: Bearer <API_KEY>" \
  -H "Content-Type: application/json" \
  -d '{
    "event_name": "button_clicked",
    "properties": {
      "button_id": "cta-signup",
      "page": "/pricing"
    },
    "user_id": "user_456"
  }'

# Response:
{
  "status": "accepted",
  "event_id": "evt_789"
}

# 3. Query metrics
curl -X POST https://api.analytics-platform.com/v1/metrics \
  -H "Authorization: Bearer <TOKEN>" \
  -H "Content-Type: application/json" \
  -d '{
    "event_names": ["button_clicked", "page_view"],
    "start_date": "2025-01-01",
    "end_date": "2025-01-15",
    "group_by": "day"
  }'

# Response:
{
  "data": [
    {
      "date": "2025-01-15",
      "event_name": "button_clicked",
      "count": 1250,
      "unique_users": 450
    },
    ...
  ]
}
```

**Arquivos criados:**
- `api/openapi.yaml`
- `api/examples/curl-examples.sh`
- `api/postman-collection.json`

---

### ➡️ Continua nos próximos passos...

[Ver exemplo completo em: `examples/project-1-saas-analytics/full-implementation.md`]

---

## 📁 Estrutura de Arquivos do Projeto

```
project-1-saas-analytics/
├── README.md (este arquivo)
├── full-implementation.md (implementação completa)
├── step-by-step.md (guia passo-a-passo)
├── code-samples/
│   ├── backend/
│   │   ├── main.py
│   │   ├── models.py
│   │   ├── routers/
│   │   └── tests/
│   ├── frontend/
│   │   ├── components/
│   │   ├── pages/
│   │   └── hooks/
│   └── docker/
│       ├── Dockerfile
│       └── docker-compose.yml
├── docs/
│   ├── prd.md
│   ├── architecture.md
│   └── api-design.md
└── prompts/
    ├── product-manager.md
    ├── tech-architect.md
    └── all-prompts.md
```

---

## 🎯 Próximos Passos

Para continuar este exemplo:

1. [full-implementation.md](full-implementation.md) - Implementação completa de todos os 15 agentes
2. [code-samples/](code-samples/) - Código real gerado pelos agentes
3. [prompts/](prompts/) - Todos os prompts utilizados

---

**Tempo estimado:** 9 semanas (2 sprints)
**Agentes:** 15 agentes especializados
**Stack:** FastAPI + React + PostgreSQL + Redis
**Deploy:** Docker + Kubernetes + CI/CD

