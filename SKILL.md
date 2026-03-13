## AI Developer Agents – Shared Skills

This document defines the **capability model** for the AI Developer Agents framework.  
It describes the skills that the **team of agents collectively possesses**, and which individual agents specialize in.

The skills are grouped into:

- Software architecture
- Backend development
- Frontend development
- AI/ML engineering
- Testing and quality assurance
- Deployment, DevOps, and infrastructure
- Documentation and knowledge sharing

Each skill category includes:

- **What the agents can do**
- **Typical outputs**
- **How other agents depend on it**

---

## 1. Software Architecture

**Primary owner**: `architect-agent`  
**Other participants**: Orchestrator, `backend-agent`, `frontend-agent`, `ai-engineer-agent`, `devops-agent`

### Capabilities

- Interpret PRDs and translate them into:
  - System boundaries and components.
  - Service decomposition and layering.
  - Data flows and integration patterns.
- Choose appropriate architectural styles:
  - Monolith vs. microservices.
  - Event‑driven vs. request/response.
  - Modular and hexagonal architectures.
- Design:
  - API contracts and versioning strategies.
  - Data models, schemas, and relationships.
  - Caching, scalability, and performance strategies.
- Consider cross‑cutting concerns:
  - Authentication and authorization.
  - Observability (logging, metrics, tracing).
  - Reliability, fault tolerance, and degradation strategies.

### Typical Outputs

- High‑level architecture overview.
- Component and service breakdown.
- Data model sketches and key entities.
- Technology and framework recommendations.
- Non‑functional requirement mappings.

### Dependencies and Interactions

- Guides all implementation agents on **how** to structure code and services.
- Works closely with:
  - `backend-agent` for API and data details.
  - `frontend-agent` for client/server integration.
  - `ai-engineer-agent` for model serving and data needs.
  - `devops-agent` for deployment and operational fit.

---

## 2. Backend Development

**Primary owner**: `backend-agent`  
**Other participants**: Orchestrator, `architect-agent`, `ai-engineer-agent`

### Capabilities

- Design and implement:
  - REST/GraphQL/gRPC APIs.
  - Business logic and domain services.
  - Background workers and scheduled jobs.
- Model and interact with data:
  - ORM or query builder usage.
  - Schema migrations and data validation.
- Integrate with external systems:
  - Third‑party APIs, webhooks, messaging systems.
- Implement cross‑cutting server concerns:
  - Input validation and error handling.
  - Authentication and authorization checks.
  - Logging and metrics instrumentation.

### Typical Outputs

- Backend service code and project structure.
- API endpoints and documentation (e.g., OpenAPI specs).
- Database schema definition and migrations.
- Integration modules and adapters.

### Dependencies and Interactions

- Depends on:
  - Architecture decisions from `architect-agent`.
  - Infrastructure guidance from `devops-agent`.
- Supports:
  - `frontend-agent` via well‑defined APIs.
  - `ai-engineer-agent` with data and model serving endpoints.
  - `qa-agent` with testable and observable interfaces.

---

## 3. Frontend Development

**Primary owner**: `frontend-agent`  
**Other participants**: Orchestrator, `architect-agent`, `backend-agent`

### Capabilities

- Design and implement UIs for:
  - Web applications (SPAs/MPAs).
  - Potentially mobile frontends (via web or cross‑platform frameworks).
- Translate UX flows and wireframes into:
  - Pages, screens, and navigations.
  - Reusable components and design systems.
- Integrate with backends:
  - API consumption, data fetching, and caching.
  - State management and error handling.
- Ensure usability and accessibility:
  - Responsive design.
  - Keyboard navigation and a11y best practices (where relevant).

### Typical Outputs

- Frontend project structure and build configuration.
- UI components, pages, routing, and global state management.
- Theming, styling, and layout definitions.
- Client‑side validation and UX enhancements.

### Dependencies and Interactions

- Depends on:
  - API contracts from `backend-agent`.
  - Architectural constraints from `architect-agent`.
- Provides:
  - User‑facing representation of features.
  - Feedback on UI feasibility to orchestrator and architect.

---

## 4. AI/ML Engineering

**Primary owner**: `ai-engineer-agent`  
**Other participants**: Orchestrator, `architect-agent`, `backend-agent`, `devops-agent`

### Capabilities

- Understand ML‑related requirements from the PRD:
  - Classification, regression, ranking, recommendations, anomaly detection, etc.
- Design data pipelines:
  - Data ingestion and cleaning.
  - Feature engineering and storage.
  - Training, validation, and evaluation loops.
- Select or design models:
  - Use classical ML, deep learning, or pre‑trained models as appropriate.
  - Balance performance, complexity, and operational constraints.
- Serve models:
  - Batch or online inference.
  - Latency and throughput considerations.
- Ensure ML quality:
  - Define metrics (e.g., accuracy, precision/recall, RMSE, AUC).
  - Consider drift detection and monitoring strategies.

### Typical Outputs

- Data pipeline and model training code.
- Model serving endpoints or libraries.
- Evaluation scripts and reports.
- Documentation of model behavior and limitations.

### Dependencies and Interactions

- Depends on:
  - Data access patterns and APIs from `backend-agent`.
  - Infrastructure from `devops-agent` (e.g., CPU/GPU resources, batch jobs).
- Provides:
  - ML capabilities to the rest of the system via agreed interfaces.
  - Guidance on what data is needed from the rest of the architecture.

---

## 5. Testing and Quality Assurance

**Primary owner**: `qa-agent`  
**Other participants**: All implementation agents

### Capabilities

- Interpret the PRD and architecture to create:
  - Test strategies and coverage plans.
  - Test cases for functional and non‑functional criteria.
- Implement automated tests:
  - Unit tests for backend, frontend, and ML components.
  - Integration tests for cross‑component flows.
  - End‑to‑end tests for user‑visible scenarios (where applicable).
- Use `run-tests` command to:
  - Execute test suites.
  - Interpret failures and report them to relevant agents.

### Typical Outputs

- Test plans and matrices.
- Automated test suites and configurations.
- Test data and fixtures.
- Test execution reports and defect descriptions.

### Dependencies and Interactions

- Depends on:
  - Code and interfaces defined by all other agents.
  - Clear acceptance criteria from the PRD and orchestrator.
- Provides:
  - Feedback on quality, regressions, and gaps.
  - Safety net for refactors requested by orchestrator or `architect-agent`.

---

## 6. Deployment, DevOps, and Infrastructure

**Primary owner**: `devops-agent`  
**Other participants**: Orchestrator, `architect-agent`, `backend-agent`, `ai-engineer-agent`

### Capabilities

- Design deployment topology:
  - Monolithic vs. microservice deployment strategies.
  - Containerization and orchestration (e.g., Docker, Kubernetes).
- Set up CI/CD pipelines:
  - Build, test, and deployment automation.
  - Static analysis and security checks where applicable.
- Manage environments:
  - Development, staging, production.
  - Configuration, secrets, and environment variables.
- Implement observability:
  - Logging, metrics, and alerting hooks.
  - Dashboards for health and performance.

### Typical Outputs

- Infrastructure‑as‑Code templates or configurations.
- CI/CD pipeline definitions.
- Environment setup, scripts, and documentation.
- Monitoring and logging configurations.

### Dependencies and Interactions

- Depends on:
  - Architectural constraints and service layout from `architect-agent`.
  - Application requirements from backend, frontend, and AI components.
- Supports:
  - Reliable, repeatable deployments for the entire system.
  - Feedback loop on operability and scalability.

---

## 7. Documentation and Knowledge Sharing

**Primary owners**: All agents, coordinated by Orchestrator  

### Capabilities

- Produce human‑readable documentation for:
  - Architecture and design decisions.
  - API contracts and data models.
  - Setup, deployment, and operational procedures.
  - Known limitations and future improvements.
- Keep documentation **in sync** with implemented behavior.
- Use consistent style and structure across documents.

### Typical Outputs

- README files and high‑level overviews.
- API references and usage guides.
- Onboarding docs for new developers or operators.
- Decision records for major changes.

### Dependencies and Interactions

- Draws on information from all other skills and agents.
- Supports:
  - Human teams who adopt and extend the system.
  - Clear communication of design intent and trade‑offs.

---

## Summary

The AI Developer Agents framework assumes a **multi‑disciplinary skill set** distributed across specialized agents.  
By clearly defining these skills:

- The **orchestrator** can assign the right work to the right agent.
- Each agent can reason about how their work fits into the wider system.
- The resulting software is more likely to be coherent, robust, and maintainable across a wide range of project types and domains.

