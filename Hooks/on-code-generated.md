## Hook: on-code-generated

### Trigger

Runs after an agent completes a `generate-code` command.

### Inputs

- Changed files list
- Task identifier
- Agent identifier

### Actions

1. Run quality checks:
   - Lint/static checks (if configured)
   - Basic style and convention validation
2. Trigger targeted tests via `run-tests`.
3. Detect likely cross-agent impacts:
   - API contract changes
   - Schema/model changes
4. Notify affected agents for synchronization.

### Outputs

- Validation status: `pass` / `needs-fix`
- Detected impacts
- Follow-up tasks

