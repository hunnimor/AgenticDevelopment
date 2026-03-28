---
description: Implement a feature from PRD or description with tests and a commit
argument-hint: [feature name or description]
---

Read `PRD.md` if it exists to get full context on requirements and architecture.
Then read `.claude/skills/coding/SKILL.md`.

**Step 1 — Understand the codebase first.**
Before writing a single line, run:
```bash
# Map the relevant module
find . -type f -name "*.ts" | grep -v node_modules | head -40
grep -r "export" src/ --include="*.ts" -l
```
Read the files most relevant to the feature. Understand the existing patterns.

**Step 2 — Decompose into atomic tasks.**
Break `$ARGUMENTS` into a numbered task list. Example:
```
1. Add `UserRole` enum to types/user.ts
2. Add `role` column migration in db/migrations/
3. Add `role` field to User model
4. Update createUser service to accept role
5. Add role-based guard middleware
6. Wire guard to protected routes
7. Write unit tests for guard
8. Write integration test for protected route
```
Show the plan and **wait for user confirmation** before proceeding.

**Step 3 — Implement each task in order.**
For each task:
- Read the files you'll touch
- Make the change
- Run the linter: `npm run lint` / `ruff check` / `go vet`
- If lint fails, fix it before moving on
- Write or update tests for the changed code
- Run tests: confirm green before moving to the next task

**Step 4 — Verify the full picture.**
After all tasks are complete:
- Run the full test suite
- Confirm no regressions

**Step 5 — Commit.**
Run `/commit` with a descriptive message referencing the feature.

Never: guess how an existing function works without reading it. Leave TODO without a ticket number. Proceed to the next task if the current one has failing tests.
