## Command: `design-architecture`

The `design-architecture` command is used by agents to **create or evolve the technical architecture** of a system based on the PRD and constraints.  
It is the primary tool for aligning all implementation work with a coherent, well‑reasoned design.

---

## Purpose

- Translate PRD requirements into:
  - System components and boundaries.
  - Data flows and integration patterns.
  - Technology and deployment choices.
- Provide clear guidance to all specialized agents on **how the system should be built**.

---

## When to Use

- At the start of a new project, prior to major implementation.
- When requirements or constraints significantly change.
- Before large feature additions that could affect core structure.
- Prior to major refactor efforts to ensure the target architecture is well defined.

---

## Inputs

An agent invoking `design-architecture` (usually the orchestrator) should provide:

- **PRD or equivalent requirements** (required)
  - Clear description of the system, features, and non‑functional requirements.
- **Constraints and preferences** (required where known)
  - Tech stack constraints (languages, frameworks, cloud provider).
  - Compliance, security, performance requirements.
  - Team capabilities or organizational standards.
- **Project type(s)** (required)
  - Web app, backend service, mobile app, AI/ML system, CLI tool, automation script, etc.
- **Existing architecture** (optional)
  - If evolving a legacy or partially implemented system, include current diagrams/structure.

---

## Outputs

The `design-architecture` command should produce:

- **High‑level overview**
  - Short description of the architecture in plain language.

- **Component and service breakdown**
  - List of major components/services (e.g., web client, API gateway, worker, model server).
  - Responsibilities and interactions.

- **Data model and storage**
  - Key entities and relationships.
  - Chosen storage technologies (e.g., SQL/NoSQL, blob storage, message queues).

- **Integration and communication patterns**
  - How components communicate (REST, GraphQL, gRPC, events, queues).
  - External dependencies (third‑party APIs, legacy systems).

- **Cross‑cutting concerns**
  - AuthN/AuthZ strategy.
  - Observability (logging, metrics, tracing).
  - Resilience patterns (retries, timeouts, circuit breakers).

- **Deployment and operations (conceptual)**
  - Expected deployment topology.
  - Environments (dev, staging, prod).
  - Scalability strategy.

- **Guidance for agents**
  - Specific instructions for `backend-agent`, `frontend-agent`, `ai-engineer-agent`, `devops-agent`, `qa-agent` on how to apply the architecture in their work.

---

## Architectural Styles and Considerations

When designing architecture, agents should consider:

- **Simplicity vs. flexibility**
  - Prefer the simplest architecture that satisfies requirements, while allowing for reasonable growth.

- **Monolith vs. microservices**
  - Monolith or modular monolith for smaller or early‑stage systems.
  - Microservices for clear domain boundaries, independent scaling, or organizational reasons.

- **Event‑driven vs. request/response**
  - Use events where asynchronous behavior and decoupling are important.
  - Use synchronous APIs when direct, immediate responses are required.

- **AI/ML integration**
  - Embed models in existing services vs. dedicated model serving services.
  - Data ingestion, feature stores, and monitoring infrastructure.

---

## Examples

- **Full‑stack web app**
  - SPA frontend calling a backend API.
  - Backend with modular domain services and a relational database.
  - Background workers for scheduled tasks.
  - Optional AI service for recommendations.

- **Backend service**
  - Single service exposing REST endpoints.
  - Separate worker for long‑running jobs.
  - Database and cache layers.

- **AI system**
  - Data ingestion and processing pipeline.
  - Training service with experiment tracking.
  - Model registry and serving endpoint.

- **CLI tool / automation script**
  - Single binary or script with modular internal components.
  - Optional integration with remote APIs or services.

---

## Interaction with Other Commands

- **With `create-file`**
  - Architecture defines the initial project and folder structure.
  - `create-file` then materializes the defined modules, services, and configs.

- **With `generate-code`**
  - `generate-code` must follow architectural boundaries and contracts.
  - Architecture may specify patterns (e.g., controllers, services, repositories) to be used in code.

- **With `refactor`**
  - `design-architecture` defines the **target** structure.
  - `refactor` is used to gradually move the implementation toward that target when existing code diverges.

- **With `run-tests`**
  - Architecture should consider testability.
  - Test strategies defined by `qa-agent` should align with architectural boundaries.

---

## Interaction with Agents

- **Architect-Agent**
  - Primary owner of this command; produces the architecture artifacts.

- **Orchestrator**
  - Requests initial and updated architecture.
  - Uses architecture to derive tasks and coordinate agents.

- **Backend / Frontend / AI Engineer**
  - Use the architecture as guidance for:
    - Module boundaries.
    - API design.
    - Data flows.
    - Integration points.

- **Devops-Agent**
  - Uses architecture to design deployment and infrastructure.

- **QA-Agent**
  - Uses architecture to define test layers and integration points.

`design-architecture` ensures that the multi‑agent team **builds the right system in the right way**, providing a shared blueprint that aligns all implementation and operations work.

