# Dev-Agents — Claude Code Configuration

This repository is a system of AI developer agents for Claude Code. It provides specialized agents, slash commands, reusable skills, and safety hooks to support the full software development lifecycle.

---

## Available Agents

Agents are sub-agent system prompts invoked with:
```bash
claude --system-prompt .claude/agents/<agent>.md
```

| Agent | File | Purpose |
|---|---|---|
| Architect | `.claude/agents/architect.md` | System design, ADRs, trade-off analysis |
| Developer | `.claude/agents/developer.md` | Feature implementation, production-ready code |
| Reviewer | `.claude/agents/reviewer.md` | Code review with severity labels |
| Tester | `.claude/agents/tester.md` | Test writing and coverage analysis |
| Debugger | `.claude/agents/debugger.md` | Root cause analysis and regression tests |

---

## Available Commands

| Command | Description |
|---|---|
| `/create-prd [file]` | Generate a full PRD with user stories, architecture, and implementation phases |
| `/implement [feature]` | Decompose and implement a feature with tests and a commit |
| `/review [target]` | Review code with 🔴/🟡/🟢 severity labels |
| `/test [target]` | Write, run, and fix tests with coverage check |
| `/refactor [target]` | Safe refactoring with test checkpoint after each change |
| `/debug [problem]` | Root cause analysis via hypothesis-driven debugging |
| `/commit` | Stage, safety-check, and create a Conventional Commit |
| `/ship` | Full pre-release pipeline: review → test → version bump → release notes |

---

## Recommended Workflow

```
1. /create-prd                    → define what to build
2. architect agent                → design the system, write ADRs
3. /implement [feature]           → build it with tests
4. reviewer agent or /review      → catch issues before merge
5. /test [module]                 → ensure coverage ≥ 80%
6. /ship                          → version bump, release notes, final gate
```

---

## Skills System

Skills are practical reference files read by agents and commands before starting work. They contain real code examples, checklists, and patterns — not abstract advice.

| Skill | Path | Contents |
|---|---|---|
| Coding | `.claude/skills/coding/SKILL.md` | Codebase navigation, function rules, error handling, pre-commit checklist |
| Git | `.claude/skills/git/SKILL.md` | Conventional Commits, branch naming, atomic commits, bisect workflow |
| Testing | `.claude/skills/testing/SKILL.md` | Test pyramid, AAA pattern, mock rules, parametrized tests |
| Review | `.claude/skills/review/SKILL.md` | Priority order, OWASP checklist, performance red flags, feedback style |
| Architecture | `.claude/skills/architecture/SKILL.md` | Monolith vs microservices, ADR template, C4 model, API design, 12-factor |

---

## Hooks

Hooks run automatically on tool events (configured in `.claude/settings.json`):

- **pre-tool.sh** — before every Bash call: blocks `rm -rf /`, `DROP TABLE` without WHERE; warns on direct-to-main pushes; logs all commands
- **post-tool.sh** — after every Write/Edit: auto-formats with prettier/black/gofmt; reminds to run tests when test files are modified
- **stop.sh** — at session end: reports uncommitted changes, prints files-modified count

---

## Rules for All Agents

1. **Read the relevant SKILL.md before starting any task**
2. **Read existing code before writing new code** — never assume what exists
3. **Make small changes** — one logical unit per step
4. **Commit often** — use `/commit` after each meaningful unit of work
5. **Ask when unsure** — a 30-second question beats a wrong implementation
6. **No secrets in code** — all configuration via environment variables
7. **No TODO without a ticket number** — `// TODO(#123): description`
