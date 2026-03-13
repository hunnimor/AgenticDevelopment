## Command: `refactor`

The `refactor` command is used by agents to **improve the internal structure of the codebase** without changing its externally observable behavior.  
It is critical for maintaining long‑term quality as the system evolves.

---

## Purpose

- Reduce technical debt accumulated during rapid feature development.
- Improve readability, modularity, and maintainability.
- Align implementation with updated architecture and design decisions.
- Enable safer future changes by clarifying boundaries and responsibilities.

---

## When to Use

- After multiple iterations of `generate-code` have introduced duplication or complexity.
- When architecture or design changes require corresponding code reorganizations.
- When `run-tests` uncovers brittle areas sensitive to small changes.
- Before introducing major new features into a fragile area of the codebase.

---

## Inputs

An agent invoking `refactor` should clearly specify:

- **Scope** (required)
  - Specific files, modules, services, or components to refactor.
- **Goals** (required)
  - What should improve, such as:
    - Remove duplication.
    - Extract reusable components.
    - Clarify interfaces.
    - Rename ambiguous concepts.
    - Split large modules into cohesive units.
- **Constraints** (required)
  - No change to external behavior or public APIs (unless explicitly agreed).
  - Must pass `run-tests` before and after changes.
- **Context** (optional but recommended)
  - References to PRD sections, architecture docs, or previous issues motivating the refactor.

---

## Outputs

- Updated code with:
  - Clearer organization and naming.
  - Reduced complexity and duplication.
  - Better separation of concerns.
- A **summary** of refactoring steps and rationale.
- Confirmation that tests continue to pass (i.e., no behavior regressions).

---

## Refactoring Activities

Examples of tasks performed under `refactor`:

- **Code structure**
  - Extract helper functions or classes.
  - Move logic to appropriate modules or layers.
  - Remove dead code and unused abstractions.

- **API and module design (internal)**
  - Simplify function signatures.
  - Clarify interfaces between components.
  - Introduce or refine domain models.

- **Naming and clarity**
  - Rename variables, functions, modules for better intention‑revealing names.
  - Improve inline documentation where necessary (non‑obvious intent).

- **Tests**
  - Restructure tests to match refactored code.
  - Improve test readability and maintainability.

---

## Interaction with Other Commands

- **With `generate-code`**
  - Often follows periods of heavy feature development.
  - Can also accompany new features to keep quality high from the start.

- **With `run-tests`**
  - `run-tests` must be invoked after refactors to ensure behavior remains unchanged.
  - For large refactors, tests should also be run before to establish a baseline.

- **With `create-file`**
  - `refactor` may involve:
    - Creating new modules or directories to better organize code.
    - Moving content from older files to new ones created via `create-file`.

---

## Interaction with Agents

- **Architect-Agent**
  - Often initiates refactors when design evolves or when architecture drift is detected.
  - Guides high‑level restructuring decisions.

- **Backend / Frontend / AI Engineer**
  - Perform localized refactors within their domains.
  - Coordinate with each other when changes cross boundaries (e.g., shared models or utilities).

- **QA-Agent**
  - Ensures test coverage is sufficient to make refactors safe.
  - May add or improve tests before large refactors.

- **Devops-Agent**
  - May refactor deployment scripts and infrastructure definitions to:
    - Improve reusability.
    - Align with new environments or topologies.

- **Orchestrator**
  - Decides **when** to schedule refactor work vs. feature work.
  - Ensures refactors are tied to explicit goals and not done in isolation from product needs.

Used well, `refactor` keeps the codebase **healthy, adaptable, and easier for all agents (and humans) to work with over time**.

