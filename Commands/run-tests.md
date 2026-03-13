## Command: `run-tests`

The `run-tests` command is used by agents to **execute automated tests** and interpret their results.  
It is essential for verifying correctness, preventing regressions, and enabling safe refactoring.

---

## Purpose

- Validate that implemented behavior matches:
  - PRD requirements.
  - Architecture and API contracts.
  - Non‑functional constraints where tests exist.
- Provide **fast feedback** to the orchestrator and specialist agents about the stability of the system.

---

## When to Use

- After implementing new features with `generate-code`.
- Before merging significant changes or completing a milestone.
- After `refactor` operations to confirm behavior is unchanged.
- During CI/CD pipelines as part of automated quality gates.

---

## Inputs

An agent invoking `run-tests` should specify:

- **Scope** (required)
  - Entire test suite (default), or
  - A subset (e.g., backend tests only, unit tests only, a specific test file).
- **Environment / configuration** (optional)
  - Test environment (local, CI, staging).
  - Environment variables or configuration profiles.
- **Context** (optional but recommended)
  - What changes are being tested (e.g., “new user registration flow”, “refactor of metrics calculation”).

---

## Outputs

- Test execution results, including:
  - Overall status (pass/fail).
  - Summary of passed/failed/skipped tests.
  - Details of failure(s), including stack traces or error messages.
- A short **interpretation** of results:
  - Likely causes of failures.
  - Which agent(s) should address them.
  - Whether changes are safe to proceed or require rollback/adjustments.

---

## Types of Tests

The framework encourages multiple layers of tests:

- **Unit tests**
  - Validate individual functions or components in isolation.

- **Integration tests**
  - Validate interaction between modules or services (e.g., backend API + database).

- **End‑to‑end tests**
  - Validate user‑visible flows across the stack (e.g., frontend ↔ backend ↔ database).

- **Performance or load tests** (optional)
  - Validate throughput, latency, and resource usage.

The specific mix and tooling depend on the project’s tech stack and PRD.

---

## Examples

- Run all tests:
  - `run-tests` on the entire repository test suite.

- Run backend tests:
  - `run-tests` with scope restricted to `tests/backend/` or equivalent.

- Run frontend tests:
  - `run-tests` on UI tests (e.g., Jest, Vitest, Cypress) depending on the stack.

- Run ML evaluation:
  - `run-tests` on ML evaluation scripts ensuring that:
    - Metrics thresholds are satisfied.
    - No major regressions in accuracy or other KPIs.

---

## Interaction with Other Commands

- **With `generate-code`**
  - After significant new code or bug fixes, `run-tests` should be invoked to validate the changes.

- **With `refactor`**
  - `run-tests` must be invoked before and after refactors to ensure behavior is preserved.

- **With `create-file`**
  - When new test files are created, `run-tests` verifies they are wired correctly into the test harness.

---

## Interaction with Agents

- **QA-Agent**
  - Primary owner of this command.
  - Designs test strategy and decides how and when tests must be run.

- **Backend / Frontend / AI Engineer**
  - May invoke `run-tests` locally for their domain to validate changes before handing them off.

- **Devops-Agent**
  - Integrates `run-tests` into CI/CD pipelines and ensures that:
    - Tests run reliably in automated environments.
    - Failures are clearly surfaced to developers.

- **Orchestrator**
  - Uses test results to:
    - Decide if a milestone is complete.
    - Prioritize bug fixing vs. new feature work.
    - Trigger refactor or stabilization phases when test failure rates are high.

Consistent use of `run-tests` ensures that the multi‑agent system maintains **high confidence** in the correctness and stability of the resulting software.

