# dev-agents

A system of AI developer agents for Claude Code. Specialized personas, slash commands, reusable skills, and safety hooks for the full software development lifecycle.

## Quickstart

```bash
# Clone and enter the repo
git clone <repo-url> && cd AgenticDevelopment

# Open Claude Code in this directory
claude

# Start with a PRD
/create-prd

# Or invoke a specialist agent
claude --system-prompt .claude/agents/architect.md
```

---

## Agents

Each agent is a system prompt that makes Claude adopt a specific engineering role.

```bash
claude --system-prompt .claude/agents/<name>.md
```

| Agent | Role | Best for |
|---|---|---|
| **architect** | Senior software architect | System design, technology selection, ADRs, Mermaid diagrams |
| **developer** | Full-stack developer | Feature implementation, production-ready code, disciplined workflow |
| **reviewer** | Staff engineer | Code review with 🔴/🟡/🟢 severity labels and concrete fix examples |
| **tester** | QA automation engineer | Test strategy, coverage analysis, edge case discovery |
| **debugger** | Root cause detective | Hypothesis-driven debugging, regression tests, `git bisect` |

**Example use cases:**

```bash
# Design a new feature before implementing it
claude --system-prompt .claude/agents/architect.md
> "We need to add real-time notifications to our SaaS app. Current stack: Node + PostgreSQL + 3k concurrent users."

# Review a PR before merging
claude --system-prompt .claude/agents/reviewer.md
> "Review the diff in feature/payment-refunds"

# Track down a production bug
claude --system-prompt .claude/agents/debugger.md
> "Orders created before 2024-01-01 return 500. Started after deploy v2.3.1."
```

---

## Commands

Slash commands available in any Claude Code session in this project.

| Command | Usage | Description |
|---|---|---|
| `/create-prd` | `/create-prd [filename]` | Full PRD with user stories, architecture, API spec, phases |
| `/implement` | `/implement "add user export to CSV"` | Decompose → implement → test → commit |
| `/review` | `/review src/payments/` | Code review with severity labels and fix examples |
| `/test` | `/test src/orders/service.ts` | Write tests, run them, fix failures, check coverage |
| `/refactor` | `/refactor src/utils/formatter.ts` | Safe refactoring with test checkpoint after each change |
| `/debug` | `/debug "checkout returns 500 for gift cards"` | Root cause analysis with regression test |
| `/commit` | `/commit` | Safety checks → Conventional Commit → confirm → push |
| `/ship` | `/ship` | review → test → env check → changelog → version bump → release notes |

---

## Skills

Skills are reference files with real code examples. Agents and commands read the relevant skill before starting work — they act as a shared style guide and checklist.

```
.claude/skills/
├── coding/SKILL.md       Codebase navigation, function rules, error handling, pre-commit checklist
├── git/SKILL.md          Conventional Commits, branch naming, atomic commits, git bisect
├── testing/SKILL.md      Test pyramid, AAA pattern, mock rules, parametrized tests (Jest + pytest)
├── review/SKILL.md       Priority order, OWASP checklist, performance red flags, feedback style
└── architecture/SKILL.md Monolith vs microservices, ADR template, C4 model, API design, 12-factor
```

To use a skill directly:
```bash
claude
> Read .claude/skills/architecture/SKILL.md and help me design the data model for a multi-tenant SaaS
```

---

## Hooks

Hooks run automatically based on events. Configured in `.claude/settings.json`.

### pre-tool.sh — Before every Bash command
- **Blocks** (exit 2): `rm -rf /`, `rm -rf ~`, `DROP TABLE` without `WHERE`
- **Warns** (exit 1): `git push --force` (suggests `--force-with-lease`), direct push to `main`/`master`
- **Logs** all commands to `.claude/logs/tool-calls.jsonl`

### post-tool.sh — After every Write/Edit/MultiEdit
- **Auto-formats**: `.ts/.js/.json/.css` → prettier | `.py` → black | `.go` → gofmt
- **Reminds** to run tests when a `*.test.*` or `*.spec.*` file is modified
- **Logs** all modified files to `.claude/logs/tool-results.jsonl`

### stop.sh — When the agent session ends
- Reports any uncommitted changes with a reminder to `/commit`
- Prints a summary: "✅ Session complete. X files modified."

---

## Recommended Workflow

```
/create-prd
    ↓
architect agent  →  design + ADRs
    ↓
/implement [feature]  →  code + tests + commit
    ↓
/review  →  catch issues (fix 🔴 blockers)
    ↓
/test [module]  →  coverage ≥ 80%
    ↓
/ship  →  version bump + release notes
```

---

## Project Structure

```
.claude/
├── settings.json          Hook configuration
├── commands/              Slash commands (/create-prd, /commit, /ship, ...)
├── agents/                Sub-agent system prompts (architect, developer, ...)
├── skills/                Reference skill files read by agents
│   ├── coding/SKILL.md
│   ├── git/SKILL.md
│   ├── testing/SKILL.md
│   ├── review/SKILL.md
│   └── architecture/SKILL.md
└── hooks/                 Bash scripts for PreToolUse / PostToolUse / Stop
    ├── pre-tool.sh
    ├── post-tool.sh
    └── stop.sh
CLAUDE.md                  Agent rules and workflow reference
README.md                  This file
```
