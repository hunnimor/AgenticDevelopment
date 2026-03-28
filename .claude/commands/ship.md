---
description: Run the full pre-release pipeline — review, test, version bump, release notes
---

This is a sequential pipeline. **Stop if any step fails.** Do not proceed to the next step until the current one passes.

---

### Step 1 — Code Review
Run `/review` against `git diff main...HEAD`.

**Block on any 🔴 Critical finding.** Fix all critical issues and re-run review before continuing.
Warnings are reported but do not block.

---

### Step 2 — Full Test Suite
```bash
npm test          # or: pytest / go test ./... / cargo test
```
If any test fails: stop, report the failures, do not continue.

---

### Step 3 — Environment Variables
Check that every env var used in the codebase is documented:
```bash
grep -r "process.env\." src/ --include="*.ts" -h | grep -oP '(?<=process\.env\.)\w+' | sort -u
# or: grep -r "os.environ" / grep -r "os.Getenv"
```
Compare the list against `.env.example`. If any vars are missing from `.env.example`, add them with a placeholder value and a comment explaining what they're for.

---

### Step 4 — Changelog
Check that `CHANGELOG.md` exists and has an entry for the changes in this release.
If missing, create or update it using the [Keep a Changelog](https://keepachangelog.com) format:
```markdown
## [Unreleased]
### Added
- ...
### Fixed
- ...
```

---

### Step 5 — Version Bump
Determine bump type based on commits since last tag:
- `feat:` → minor
- `fix:` / `perf:` → patch
- `BREAKING CHANGE:` in footer → major

Apply the bump to whichever file is present:
- `package.json` → `npm version <patch|minor|major> --no-git-tag-version`
- `pyproject.toml` → update `version = "X.Y.Z"` field
- `go.mod` → update module path if major version bump

---

### Step 6 — Release Commit
Run `/commit` with message:
```
chore(release): bump version to X.Y.Z
```

---

### Step 7 — Release Notes
Generate release notes from git log since the last tag:
```bash
git log $(git describe --tags --abbrev=0)..HEAD --oneline --no-merges
```

Format them as:
```markdown
## Release vX.Y.Z — YYYY-MM-DD

### Features
- ...

### Bug Fixes
- ...

### Internal
- ...
```

Print the release notes for the user to copy to GitHub/GitLab releases.
