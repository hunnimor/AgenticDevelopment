---
description: Find the root cause of a bug and fix it with a regression test
argument-hint: [description of the problem or error message]
---

**Objective: fix the root cause, not the symptom.**

**Step 1 — Reproduce the issue.**
Before anything else, create a minimal reproduction:
- Write the smallest possible script/test that triggers the bug
- Confirm you can make it fail reliably
- Document the exact error message or wrong output

If you can't reproduce it, ask the user for: environment, inputs, exact steps, and any logs.

**Step 2 — Form 3+ hypotheses.**
List candidate root causes ranked by likelihood. Example:
```
Problem: /api/orders returns 500 for orders created before 2024-01-01

Hypotheses (most to least likely):
1. [HIGH] Date parsing assumes ISO format but legacy records use Unix timestamp
2. [MED] Decimal rounding error in price calculation for old currency format
3. [LOW] Database connection pool exhausted under load (timing-based flakiness)
4. [LOW] Missing null check for deprecated `shippingAddress` field removed in v2
```

**Step 3 — Test hypotheses with binary search.**
For each hypothesis, starting with the most likely:
- Add temporary logging to isolate where the failure occurs
- Use `git bisect` for regressions: `git bisect start; git bisect bad HEAD; git bisect good <last-working-tag>`
- Read relevant source files to confirm or eliminate the hypothesis
- State clearly: "Hypothesis N confirmed/eliminated because [evidence]"

**Step 4 — Fix the root cause.**
Once confirmed:
- Apply the **minimal** fix (don't refactor while debugging)
- Remove all temporary logging before committing

**Step 5 — Add a regression test.**
Write a test that:
- Specifically reproduces the original bug (would have caught it)
- Uses the naming convention: `should_not_crash_when_<condition>`

**Step 6 — Verify.**
- Run full test suite
- Confirm the regression test passes
- Run `/commit` with `fix(<scope>): <what was wrong and how it was fixed>`
