## Hook: on-task-assigned

### Trigger

Runs when the orchestrator assigns a task to any specialized agent.

### Inputs

- Task description
- Assigned agent role
- Dependencies
- Acceptance criteria

### Actions

1. Validate task is actionable and has measurable completion criteria.
2. Link task to PRD section and milestone.
3. Select recommended command sequence:
   - `create-file` -> `generate-code` -> `run-tests` (typical).
4. Register dependency checks (blocked/unblocked state).

### Outputs

- Task readiness status: `ready` / `blocked`
- Required dependencies
- Suggested execution plan

