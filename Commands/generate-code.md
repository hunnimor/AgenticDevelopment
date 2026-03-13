## Command: `generate-code`

The `generate-code` command is used by agents to **implement or update executable logic** in existing or newly created files.  
It is the primary command for turning designs, PRDs, and architecture into working software.

---

## Purpose

- Implement features, endpoints, UI components, data pipelines, and automation scripts.
- Translate specifications and architecture into maintainable, idiomatic code.
- Incrementally evolve the codebase while preserving correctness and style.

---

## When to Use

- After `create-file` has been called to scaffold structure.
- When adding new features or modifying existing behavior.
- When implementing:
  - Backend business logic and APIs.
  - Frontend screens and components.
  - AI/ML pipelines and model code.
  - CLI commands and automation scripts.
  - Infrastructure helpers (e.g., deployment scripts) where logic is required.

---

## Inputs

An agent invoking `generate-code` should provide:

- **Target file(s)** (required)
  - One or more paths to modify.
- **Change description** (required)
  - Plain‑language explanation of what needs to happen (e.g., “Implement POST /users endpoint to create a new user with validation and error handling”).
- **Reference specifications** (required when available)
  - Links or references to:
    - PRD sections.
    - Architecture documents.
    - API contracts.
- **Constraints** (optional but recommended)
  - Performance targets, style guidelines, error handling policies, etc.

---

## Outputs

- Updated source files containing:
  - New or modified functions, classes, or modules.
  - Corresponding tests when appropriate (or instructions to `qa-agent`).
- A brief **summary of changes**:
  - What was implemented.
  - Any notable design decisions or trade‑offs.

---

## Implementation Guidelines

- Follow **project conventions**:
  - Naming, folder structure, error handling patterns.
  - Linting and formatting rules.
- Strive for:
  - Readability and maintainability.
  - Clear separation of concerns.
  - Testability (dependency injection, clear interfaces).
- Avoid:
  - Unnecessary coupling to unrelated modules.
  - Premature optimization.
  - Large, monolithic functions or components.

---

## Examples

- **Backend**
  - Implement `createUser` handler:
    - Validate payload.
    - Create a user in the database.
    - Return appropriate HTTP status codes.
  - Implement a scheduled job to clean up stale sessions.

- **Frontend**
  - Implement `DashboardPage` component:
    - Fetch metrics from `/api/metrics`.
    - Render charts and tables with loading/error states.
  - Implement a reusable `Button` component consistent with design system.

- **AI/ML**
  - Implement training loop for an anomaly detection model.
  - Implement an inference endpoint that loads a model and responds with predictions.

- **CLI / Automation**
  - Implement a CLI command that:
    - Reads input from file or stdin.
    - Performs a transformation.
    - Writes results or exits with an appropriate status code.

---

## Interaction with Other Commands

- **With `create-file`**
  - Typically follows `create-file`:
    - `create-file` sets up structure.
    - `generate-code` fills in logic.

- **With `refactor`**
  - After repeated `generate-code` operations, the codebase may need structural improvements.
  - `refactor` is then used to reorganize and clean up code without changing external behavior.

- **With `run-tests`**
  - After significant code generation, agents should invoke `run-tests` (directly or via `qa-agent`) to ensure correctness.

---

## Interaction with Agents

- **Backend-Agent**
  - Main user for backend logic, endpoints, data access, and integrations.

- **Frontend-Agent**
  - Implements UI and client‑side logic using this command.

- **AI-Engineer-Agent**
  - Implements training, evaluation, and inference code.

- **Devops-Agent**
  - Uses `generate-code` to implement scripts, hooks, or small infrastructure helpers.

- **QA-Agent**
  - Uses `generate-code` to implement automated tests for all layers of the system.

The orchestrator coordinates **who** should call `generate-code` and **when**, ensuring that changes align with architecture and PRD requirements.

