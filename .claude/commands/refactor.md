---
description: Refactor code safely — tests must stay green throughout
argument-hint: [file or module to refactor]
---

Read `.claude/skills/coding/SKILL.md` first.

**Step 1 — Run tests before touching anything.**
```bash
npm test -- --coverage   # or: pytest / go test ./...
```
If no tests exist, stop and say:
> "No tests found for this module. Refactoring without tests is risky. Run `/test $ARGUMENTS` first to add a safety net."

**Step 2 — Identify code smells.**
Read the target file(s) carefully. Flag:

| Smell | Example | Threshold |
|---|---|---|
| Long function | does more than one thing | > 30 lines |
| Deep nesting | if inside if inside for | > 3 levels |
| Magic values | `if (status === 4)` | any unexplained literal |
| Duplication | same logic in 2+ places | 3+ lines |
| Large class | > 200 lines, multiple responsibilities | — |
| Long parameter list | `fn(a, b, c, d, e)` | > 4 params |

**Step 3 — Show refactoring plan.**
List each change with: what, why, and expected outcome. Wait for user confirmation.

Example plan:
```
1. Extract `validateOrderItems()` from `processOrder()` — lines 45–78 do validation only
2. Replace magic number 86400 with constant SECONDS_PER_DAY
3. Deduplicate error formatting in lines 90 and 134 → shared `formatError()` helper
```

**Step 4 — Apply changes one at a time.**
After each change:
- Run tests immediately
- If tests break: revert that specific change (`git checkout -- <file>`) and report what broke
- Do not stack multiple changes without a passing test checkpoint

**Step 5 — Final check.**
- Run full test suite
- Run linter
- Confirm coverage did not drop
- If all green, run `/commit`
