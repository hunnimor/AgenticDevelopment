## Skill: Quality Gate

### Goal

Prevent regressions and ensure release readiness for each milestone.

### Checklist

- Requirements traceability:
  - Each implemented change maps to a PRD item.
- Code quality:
  - Clear naming and modular structure.
  - No obvious duplication in touched areas.
- Testing:
  - Unit tests for core logic.
  - Integration tests for critical paths.
  - E2E/smoke tests for user-critical workflows (if applicable).
- Operations:
  - Logs and metrics for new components.
  - Deployment config updated if runtime behavior changed.
- Documentation:
  - README/API docs/changelog updated for externally visible changes.

### Result Format

- Gate status: `pass` / `fail`
- Blocking issues:
- Non-blocking issues:
- Recommended next action:

