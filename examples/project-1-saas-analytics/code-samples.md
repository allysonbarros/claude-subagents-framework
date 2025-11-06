# 💻 Exemplos de Código Gerado pelos Agentes

Este documento mostra o código **real** gerado pelos agentes especializados durante a implementação do projeto SaaS Analytics.

---

## 🔐 Passo 4: Security Specialist - Implementar Autenticação JWT

**Como invocar:**
```
Use o agente security-specialist para implementar o sistema de autenticação JWT com refresh tokens
```

**Prompt:**
```
Implemente um sistema de autenticação completo com:
- JWT tokens (access + refresh)
- Hashing de senhas com bcrypt
- Proteção contra timing attacks
- Rate limiting
- CORS configurado

Stack: FastAPI + PostgreSQL
