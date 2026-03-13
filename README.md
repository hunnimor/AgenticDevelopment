## AI Developer Agents

AI Developer Agents is a framework for orchestrating a **team of specialized AI software developers** that collaborate like a real engineering organization.  
Given a **Product Requirements Document (PRD)** or even a rough idea, the system coordinates multiple expert agents to design, implement, test, and deliver complete software projects.

The framework is intentionally **domain‑agnostic**: the same workflow can be applied to build:

- Web applications
- Backend services and APIs
- Mobile applications
- AI/ML systems and data pipelines
- CLI tools
- Automation and integration scripts

The repository is designed to run inside AI‑native IDEs and agent platforms, but the concepts are general and can be adapted to any orchestration runtime.

---

## Core Concepts

- **Orchestrator Agent (`AGENT.md`)**  
  A senior “tech lead” AI that owns the end‑to‑end delivery. It reads the PRD, decomposes the work, assigns tasks to specialist agents, tracks progress, and ensures architectural and quality consistency.

- **Product Requirements Document (PRD)**  
  A structured description of the target system (see `PRD.md`) that drives all downstream work. PRDs can be generated from a user idea using the process in `Create-PRD.md`.

- **Specialized Developer Agents (`Agents/`)**  
  Role‑based agents that mirror a modern software team:
  - `architect-agent` – system design and technical architecture
  - `backend-agent` – services, APIs, persistence
  - `frontend-agent` – UI and client applications
  - `ai-engineer-agent` – ML models, data, and AI systems
  - `devops-agent` – deployment, infra, CI/CD
  - `qa-agent` – testing and quality assurance

- **Commands (`Commands/`)**  
  A small, composable command set each agent can execute:
  - `design-architecture` – high‑level and detailed design
  - `create-file` – materialize files and directory structure
  - `generate-code` – implement features and logic
  - `refactor` – improve, restructure, and pay down technical debt
  - `run-tests` – execute and interpret automated tests

- **Skills (`SKILL.md`)**  
  A shared description of what the overall agent team is capable of: architecture, backend, frontend, AI/ML, testing, deployment, and documentation.

---

## High‑Level Workflow

1. **Collect input**  
   - User provides an **idea** or a **PRD**.  
   - If only an idea is provided, the orchestrator invokes the **Create‑PRD** flow to convert it into a structured PRD (see `Create-PRD.md`).

2. **Understand and scope**  
   - Orchestrator reads the PRD (`AGENT.md`) and validates:
     - Target platform(s) (web, backend, mobile, AI system, CLI, etc.)
     - Functional and non‑functional requirements
     - Constraints and priorities

3. **Architecture & planning**  
   - Orchestrator delegates to `architect-agent` using:
     - `design-architecture` to propose overall system design
     - Optional `refactor` passes on the architecture as requirements evolve
   - Architecture output includes:
     - System context and component diagrams (conceptually)
     - Service boundaries, data model and APIs
     - Technology choices (stack, frameworks, infra)
     - Milestones and work breakdown

4. **Task decomposition & assignment**  
   - Orchestrator splits the work into concrete tasks and milestones:
     - Backend endpoints, database schemas, queues
     - Frontend views, components, and flows
     - AI/ML pipelines, models, and evaluation
     - DevOps pipelines, infra definitions, deployment targets
     - QA strategies, test suites, and validation flows
   - Each task is assigned to the **most appropriate agent** via commands (create/generate/refactor/test).

5. **Implementation loop**  
   - Each specialized agent:
     - Uses `create-file` to scaffold structure.
     - Uses `generate-code` to implement features.
     - Requests or uses `design-architecture` when cross‑cutting design decisions are needed.
     - Uses `refactor` to keep code healthy as requirements change.
   - The orchestrator:
     - Coordinates dependencies between agents.
     - Ensures consistency with the PRD and architecture.
     - Requests cross‑agent reviews when needed (e.g., backend ↔ frontend API contracts).

6. **Testing and validation**  
   - `qa-agent` designs and implements tests:
     - Unit, integration, end‑to‑end, and performance tests where applicable.
   - `run-tests` is invoked iteratively:
     - On each significant milestone.
     - After refactorings or architecture changes.
   - Failures are routed back to the responsible agent for fixes.

7. **Deployment & delivery**  
   - `devops-agent` prepares:
     - Infrastructure definitions (e.g., IaC).
     - CI/CD pipelines.
     - Deployment strategies (e.g., rolling, blue/green).
   - Orchestrator validates that:
     - The deployment approach matches non‑functional requirements.
     - Documentation is complete and consistent with final behavior.

8. **Documentation & hand‑off**  
   - All agents contribute to documentation:
     - Architecture and decisions.
     - API contracts, data models, and operations.
     - How to run, test, and extend the system.
   - Output is suitable for a human team to continue development or operations.

---

## Supported Project Types

The framework is intentionally flexible. Examples of projects it can handle include:

- **Web applications**
  - Full‑stack apps with SPA/MPA frontends and REST/GraphQL backends.
  - Authentication, role‑based access control, and dashboards.

- **Backend services**
  - Microservices or monoliths.
  - Event‑driven systems, background workers, or cron‑based jobs.
  - API gateways and service meshes (at design level).

- **Mobile applications**
  - Native or cross‑platform frontends.
  - Offline‑first patterns and synchronization with backend services.

- **AI/ML systems**
  - Training pipelines, model serving, and monitoring.
  - Data ingestion, feature engineering, and evaluation loops.

- **CLI tools**
  - Developer productivity tools.
  - Data processing utilities.

- **Automation scripts**
  - Integrations across SaaS platforms.
  - Workflow and operations automation.

The orchestrator’s decomposition logic is written to remain generic: any new application type can be accommodated by updating PRD patterns, architecture templates, and agent skill prompts.

---

## Repository Structure

At a glance:

- `README.md` – Overview and conceptual documentation (this file).
- `AGENT.md` – The orchestrator / coordinator agent specification.
- `PRD.md` – Example PRD demonstrating the format and level of detail.
- `Create-PRD.md` – How to convert user ideas into structured PRDs.
- `SKILL.md` – Shared capability definition for the agent team.
- `Commands/` – Command specs each agent can execute.
  - `create-file.md`
  - `generate-code.md`
  - `run-tests.md`
  - `refactor.md`
  - `design-architecture.md`
- `Agents/` – Role‑based developer agent definitions.
  - `architect-agent.md`
  - `backend-agent.md`
  - `frontend-agent.md`
  - `ai-engineer-agent.md`
  - `devops-agent.md`
  - `qa-agent.md`

---

## How to Use This Framework

1. **Integrate into an AI orchestration environment**  
   - Map each markdown file to an agent or command definition in your platform of choice.
   - Use the orchestrator (`AGENT.md`) as the entrypoint.

2. **From idea to PRD**
   - Feed a high‑level idea into a “PRD creator” agent that follows `Create-PRD.md`.
   - Review and optionally refine the generated PRD.

3. **From PRD to implementation**
   - Provide the PRD to the orchestrator agent.
   - Allow the orchestrator to spin up role agents as needed and execute the defined commands.

4. **Inspect and iterate**
   - Inspect generated architecture, code, and tests.
   - Adjust PRD or constraints and re‑run orchestration as necessary.

---

## Extending the Framework

You can extend AI Developer Agents by:

- **Adding new agent roles**  
  E.g., `security-engineer-agent`, `data-engineer-agent`, `product-manager-agent`.

- **Adding new commands**  
  E.g., `run-benchmark`, `generate-diagram`, `migrate-database`.

- **Customizing skills**  
  Narrow or expand the skills in `SKILL.md` to match your organization’s standards.

- **Encoding organization‑specific practices**  
  Integrate coding standards, architecture decision records (ADRs), and review checklists directly into the agent and command specs.

This repository is meant to be a **starting point** for building robust, repeatable multi‑agent software delivery pipelines.

