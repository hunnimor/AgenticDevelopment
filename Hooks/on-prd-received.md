## Hook: on-prd-received

### Trigger

Runs when a new PRD is created or updated.

### Inputs

- PRD document path/content
- Request metadata (priority, deadline, constraints)

### Actions

1. Validate PRD completeness:
   - Description, features, tech stack, architecture, milestones.
2. Detect missing requirements and open questions.
3. Request architecture draft from `architect-agent`.
4. Generate initial work breakdown for orchestrator review.

### Outputs

- PRD validation status: `complete` / `needs-clarification`
- Clarification questions list
- Initial task decomposition draft

