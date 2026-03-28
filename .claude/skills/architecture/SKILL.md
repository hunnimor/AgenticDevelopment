# Architecture Skill

## Monolith vs Microservices

Start with a monolith. Split only when you have a real problem, not a theoretical one.

| Signal | Recommended approach |
|---|---|
| Team < 10 engineers | Monolith |
| Single deployment target | Monolith |
| Unclear domain boundaries | Monolith |
| Independent scaling needed for one component | Extract that service |
| Teams blocked by deployment coupling | Extract affected services |
| > 50 engineers across multiple teams | Microservices (with proper platform team) |

**The monolith-first rule:** A well-structured monolith with clear module boundaries can be split into services later. The reverse — collapsing a badly designed microservices mesh — is vastly more expensive.

---

## ADR Template

```markdown
# ADR-NNN: <Decision Title>

## Status
Proposed | Accepted | Deprecated | Superseded by ADR-NNN

## Context
What is the situation? What forces are at play?
What constraints exist (team size, timeline, budget, existing systems)?

## Decision
What did you decide to do?

## Consequences
**Positive:**
- ...

**Negative:**
- ...

**Risks:**
- ...
```

**Filled example:**

```markdown
# ADR-007: Use PostgreSQL for primary data store

## Status
Accepted

## Context
We need a database for a SaaS application with relational data (users, orgs, subscriptions).
Team of 4, all with PostgreSQL experience. Expected scale: < 1M rows per table for 2 years.
Evaluated: PostgreSQL, MongoDB, PlanetScale.

## Decision
Use PostgreSQL 16 managed via RDS.

## Consequences
**Positive:**
- ACID transactions simplify billing and inventory logic
- Team expertise → faster development
- Rich query planner handles analytical queries without a separate data warehouse for 12 months

**Negative:**
- Schema migrations require coordination (can't deploy freely without downtime planning)
- Vertical scaling limit: RDS db.r6g.4xlarge is the ceiling before we need read replicas

**Risks:**
- If we need to store unstructured event data at high volume, we'll need to add a separate
  time-series or document store. Revisit when events table > 100M rows.
```

---

## C4 Model — Four Levels of Abstraction

| Level | Shows | Audience |
|---|---|---|
| **Context** | Your system + external actors + integrations | Stakeholders, non-technical |
| **Container** | Services, databases, queues inside your system | Developers, architects |
| **Component** | Modules/packages inside one container | Developers |
| **Code** | Classes, functions | Rarely needed — code is the diagram |

Use Mermaid for C4 diagrams:
```
graph TD
  User-->|HTTPS|WebApp
  WebApp-->|REST|API
  API-->|SQL|DB[(PostgreSQL)]
  API-->|Publish|Queue[[SQS]]
  Queue-->|Subscribe|Worker
  Worker-->|SMTP|Email[SendGrid]
```

---

## API Design Principles

**Versioning:** Use URL versioning for breaking changes: `/v1/users`, `/v2/users`

**Error format — always consistent:**
```json
{
  "error": {
    "code": "VALIDATION_FAILED",
    "message": "Human-readable description",
    "details": [{ "field": "email", "issue": "invalid format" }],
    "request_id": "req_abc123"
  }
}
```

**Pagination — use cursor-based for large datasets:**
```json
{
  "data": [...],
  "pagination": {
    "cursor": "eyJpZCI6MTAwfQ==",
    "has_more": true,
    "limit": 20
  }
}
```

---

## 12-Factor App (Condensed)

| Factor | Practice |
|---|---|
| Config | Store in environment variables, never in code |
| Backing services | Treat DB, cache, queue as attached resources (configurable via URL) |
| Build/release/run | Strict separation — never modify code at runtime |
| Processes | Stateless — store state in backing service, not local memory |
| Port binding | Export services via port, not app server |
| Logs | Write to stdout — let the platform aggregate |
| Dev/prod parity | Keep dev, staging, prod as similar as possible |

---

## Trade-off Evaluation Framework

When evaluating an architectural decision, structure your analysis:

**1. List the forces** — what constraints, goals, and risks are you balancing?
> "We need consistency across services, but we also need services to deploy independently."

**2. List 2–3 options** with concrete consequences (not vague pros/cons):
```
Option A: Shared database
  + No data sync complexity
  - Deployment coupling: schema changes require coordinated deploys
  - Scaling ceiling: single DB is the bottleneck

Option B: Database per service + events
  + Services deploy independently
  + Each DB optimized for its service's query patterns
  - Eventual consistency: queries across services need event sourcing or CQRS
  - Operational cost: 3 databases to manage, monitor, back up
```

**3. State the recommendation** and the condition under which you'd change your mind:
> "Choose Option A until the teams need to deploy independently, or until DB contention shows up in metrics (> 80% connection pool utilization). Re-evaluate at 5 services."
