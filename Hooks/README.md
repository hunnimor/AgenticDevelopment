## Hooks

This folder defines event-based hooks for orchestrating agent behavior automatically.

Hooks are triggered by lifecycle events and help enforce consistent workflow.

### Available Hooks

- `on-prd-received.md` - Runs when a new PRD is submitted.
- `on-task-assigned.md` - Runs when the orchestrator assigns a task.
- `on-code-generated.md` - Runs after code generation.
- `on-tests-failed.md` - Runs when test execution fails.

### Hook Contract

Each hook should define:

- Trigger event
- Inputs
- Actions
- Output/report format
- Escalation path

