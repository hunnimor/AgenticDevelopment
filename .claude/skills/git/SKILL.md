# Git Skill

## Conventional Commits

Format: `<type>(<scope>): <subject>`

The subject is imperative, present tense, max 72 characters, no period.

| Type | When to use | Example |
|---|---|---|
| `feat` | New feature visible to users | `feat(auth): add OAuth2 login with Google` |
| `fix` | Bug fix | `fix(cart): prevent negative quantity on item removal` |
| `refactor` | Code change with no behavior change | `refactor(db): extract query builder into separate module` |
| `test` | Adding or fixing tests | `test(payments): add edge cases for zero-amount transactions` |
| `docs` | Documentation only | `docs(api): document pagination parameters for /orders` |
| `chore` | Build, deps, tooling | `chore(deps): upgrade jest to 29.x` |
| `perf` | Performance improvement | `perf(search): replace linear scan with indexed lookup` |
| `ci` | CI/CD pipeline changes | `ci: add integration test job to GitHub Actions` |
| `build` | Build system changes | `build: switch bundler from webpack to vite` |
| `revert` | Reverts a previous commit | `revert: feat(auth): add OAuth2 login — caused session conflicts` |

**Breaking changes:** add `!` after type or `BREAKING CHANGE:` in footer:
```
feat(api)!: rename /user to /users

BREAKING CHANGE: all clients must update endpoint path from /user to /users
```

**Good vs bad commit messages:**
```
# Bad — no context, vague
fix bug
update code
WIP

# Good — specific, imperative, explains what and why
fix(orders): skip tax calculation for zero-amount refunds
feat(notifications): send Slack alert when deployment succeeds
perf(db): add index on orders.created_at, cuts query time by 90%
```

---

## Branch Naming

```
feature/<ticket-or-description>   feature/456-user-export-csv
bugfix/<ticket-or-description>    bugfix/412-cart-quantity-overflow
hotfix/<ticket-or-description>    hotfix/critical-auth-bypass
release/<version>                 release/2.4.0
chore/<description>               chore/upgrade-node-20
```

---

## Atomic Commits

Commit one logical change at a time. Use `git add -p` to stage selectively:

```bash
git add -p src/orders/service.ts
# 's' to split a hunk, 'y' to stage, 'n' to skip, '?' for help
```

This lets you separate "fix the bug" from "add the test" into two clean commits even if you changed both in one editing session.

---

## Rollback Commands

| Situation | Command |
|---|---|
| Undo last commit, keep changes staged | `git reset --soft HEAD~1` |
| Undo last commit, keep changes unstaged | `git reset HEAD~1` |
| Undo a published commit safely | `git revert HEAD` |
| Restore a single file to HEAD | `git checkout HEAD -- path/to/file` |
| Undo all unstaged changes | `git restore .` *(destructive — can't undo)* |

---

## git bisect — Finding Regressions

```bash
# 1. Mark current state as broken
git bisect start
git bisect bad HEAD

# 2. Mark a known-good commit
git bisect good v2.1.0

# 3. Git checks out the midpoint. Test it, then mark it:
git bisect good   # or: git bisect bad

# 4. Repeat until git identifies the first bad commit
# 5. Clean up
git bisect reset

# Automate it:
git bisect run npm test -- --testNamePattern "feature that broke"
```
