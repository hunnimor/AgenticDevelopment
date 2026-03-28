---
description: Generate a full Product Requirements Document and save it to a file
argument-hint: [filename] (default: PRD.md)
---

Read `.claude/skills/architecture/SKILL.md` first to ground the PRD in sound architectural thinking.

Then analyze the full conversation context to understand what is being built. If context is ambiguous, list your assumptions explicitly at the end.

Generate a complete PRD with the following sections:

## 1. Executive Summary
One paragraph: what it is, who it's for, why it matters now.

## 2. Mission
Single sentence: the problem this product solves.

## 3. Target Users
2–4 user personas. For each: role, pain point, success metric.

## 4. MVP Scope
Table of features with ✅ In / ❌ Out, and one-line rationale for each cut.

## 5. User Stories
5–8 stories in the format:
> As a [persona], I want [capability] so that [benefit].
Include acceptance criteria (2–3 bullet points) for each story.

## 6. Architecture & Patterns
Key architectural decisions. Reference ADR format from the architecture SKILL. Include a Mermaid diagram for the main data flow.

## 7. Tech Stack
Table: Layer | Choice | Rationale. Cover: frontend, backend, database, infra, testing, CI/CD.

## 8. Security & Configuration
- Auth approach
- Secrets management (never hardcode — use env vars)
- Input validation strategy
- OWASP top concerns for this domain

## 9. API Specification
For each endpoint:
```
METHOD /path
Request:  { field: type }
Response: { field: type }
Errors:   4xx codes and meaning
```

## 10. Success Criteria
3–5 measurable outcomes with specific numbers (e.g., "p95 latency < 200ms", "test coverage > 80%").

## 11. Implementation Phases
3–4 phases. Each has: goal, deliverables, exit criteria (what "done" means).

## 12. Risks & Mitigations
Table: Risk | Likelihood | Impact | Mitigation

---

Save the document to `$ARGUMENTS` (default: `PRD.md`).

After saving, confirm the path and print a bulleted list of every assumption made during generation.
