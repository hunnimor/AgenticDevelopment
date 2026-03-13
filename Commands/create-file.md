## Command: `create-file`

The `create-file` command is used by agents to **create or overwrite files and directory structures** in a repository.  
It is typically the first command executed when scaffolding new modules, services, or documentation.

---

## Purpose

- Materialize architecture and design decisions as concrete files.
- Create source code files, configuration files, test files, documentation, and scripts.
- Ensure a **consistent, intentional structure** for the codebase before or alongside implementation.

---

## When to Use

- Starting a new project or service.
- Adding a new feature that requires new modules, components, or configuration.
- Introducing tests or docs where no files exist yet.
- Creating infrastructure or CI/CD definitions.

---

## Inputs

An agent invoking `create-file` should provide at least:

- **File path** (required)
  - Relative to the repository root, e.g.:
    - `src/api/users.ts`
    - `frontend/components/Button.tsx`
    - `.github/workflows/ci.yml`
- **File type / intent** (required)
  - Short description (e.g., “React component”, “Express route handler”, “pytest module”, “Kubernetes manifest”).
- **Initial content** (optional but recommended)
  - Minimal placeholder or fully scaffolded content.
  - Should respect project conventions (lint rules, formatting, naming).
- **Context** (optional but useful)
  - Which feature, milestone, or PRD section this file supports.

---

## Outputs

- A **new file** created in the repository or an **existing file overwritten** (depending on policy).
- A log or short description capturing:
  - What was created.
  - Why it was created (feature or task).
  - Any follow‑up actions (e.g., “backend-agent will implement logic with `generate-code`”).

---

## Lifecycle and Coordination

1. **Architectural planning**
   - `architect-agent` may suggest file/module layout.
2. **Scaffolding**
   - Implementation agents (`backend-agent`, `frontend-agent`, `ai-engineer-agent`, `devops-agent`, `qa-agent`) call `create-file` to scaffold.
3. **Implementation**
   - Agents use `generate-code` to fill files with logic and tests.
4. **Refinement**
   - `refactor` may later move or split files; `create-file` can be used again to create new locations during refactors.

---

## Examples

- **Backend**
  - Create `src/api/users.ts` with a basic handler skeleton for user management endpoints.
  - Create `migrations/001_create_users_table.sql` with an empty migration template.

- **Frontend**
  - Create `src/components/UserTable.tsx` with a minimal component structure.
  - Create `src/routes/Dashboard.tsx` for a new dashboard page.

- **AI/ML**
  - Create `ml/pipelines/train_model.py` for training code.
  - Create `ml/models/README.md` describing stored models and versions.

- **DevOps**
  - Create `.github/workflows/ci.yml` with a CI pipeline stub.
  - Create `infra/k8s/api-deployment.yaml` with placeholders.

- **QA**
  - Create `tests/api/test_users.py` with an empty test class and TODOs.

---

## Interaction with Agents

- **Orchestrator**
  - Decides **what** needs to be created and **which agent** owns each file.
  - Ensures file layout aligns with architecture.

- **Architect-Agent**
  - Provides recommended folder structures and naming conventions.

- **Backend / Frontend / AI Engineer**
  - Invoke `create-file` to establish module boundaries before implementing logic.

- **DevOps-Agent**
  - Uses `create-file` for infra, CI/CD, and environment configuration.

- **QA-Agent**
  - Uses `create-file` to create test suites, fixtures, and test data definitions.

Agents should treat `create-file` as a **deliberate step**: each created file should have a clear purpose and be traceable back to the PRD and architecture.

