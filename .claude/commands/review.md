---
description: Review code for correctness, security, and quality issues
argument-hint: [file, directory, or PR branch] (default: git diff HEAD)
---

Read `.claude/skills/review/SKILL.md` first.

Determine the review target:
- If `$ARGUMENTS` is given: read the specified file(s) or diff against the branch
- Otherwise: run `git diff HEAD` to review uncommitted changes

Analyze the code and categorize every finding:

### 🔴 Critical — must fix before merge
Security vulnerabilities, logic errors that cause incorrect behavior, data loss risks, missing auth checks, SQL injection, unhandled panics/crashes.

### 🟡 Warning — should fix
Performance issues (N+1 queries, blocking I/O in hot path), missing error handling, race conditions, deprecated API usage, missing input validation.

### 🟢 Suggestion — nice to have
Readability improvements, naming clarity, test coverage gaps, code duplication that could be extracted.

---

For **every** finding, provide:
1. **Location**: `file.ts:42`
2. **Problem**: why this is an issue (not just what it is)
3. **Fix**: concrete code example showing the corrected version

```
🔴 src/auth/middleware.ts:88
Problem: JWT secret falls back to a hardcoded string when env var is missing.
         An attacker can forge tokens in any environment where APP_SECRET is unset.
Fix:
  // Before
  const secret = process.env.APP_SECRET || 'fallback-secret'

  // After
  const secret = process.env.APP_SECRET
  if (!secret) throw new Error('APP_SECRET env var is required')
```

---

End the review with:
1. Summary count: "X critical, Y warnings, Z suggestions"
2. One sentence of genuine praise for something done well in the diff
