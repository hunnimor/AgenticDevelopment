## Create‑PRD – From Idea to Structured Requirements

This document defines how an agent should convert a **raw user idea** into a **structured Product Requirements Document (PRD)** that can be consumed by the AI Developer Agents framework.

The goal is to:

- Capture enough detail for architecture and implementation.
- Stay understandable for non‑technical stakeholders.
- Remain flexible across different project types:
  - Web applications
  - Backend services
  - Mobile apps
  - AI/ML systems
  - CLI tools
  - Automation scripts

---

## High‑Level Process

1. **Clarify the idea**
   - Understand the user’s vision, target users, and main problems to solve.
2. **Identify project type(s)**
   - Determine which platforms and domains are involved.
3. **Draft PRD sections**
   - Fill in a standardized structure (see template below).
4. **Iterate with the user**
   - Ask targeted questions where information is missing or ambiguous.
5. **Finalize PRD**
   - Ensure the document is coherent, testable, and ready for the orchestrator and specialist agents.

---

## Required PRD Structure

An agent generating a PRD must, at minimum, produce sections that cover:

1. **Project description**
2. **Features**
3. **Tech stack**
4. **Architecture (conceptual)**
5. **Milestones / phases**

Additional sections (e.g., non‑functional requirements, metrics, constraints) are encouraged when appropriate.

---

## 1. Project Description

**Objective**: Capture the essence of the project in clear, concise language.

The agent should describe:

- **Project name** (provisional if none is provided).
- **Short summary** of what the system does.
- **Primary problem(s)** it solves.
- **Target users** and their context.
- **Project type(s)**:
  - Web app, backend service, mobile app, AI/ML system, CLI tool, automation script, or a combination.

**Guidelines:**

- Use non‑technical language first, then optionally add a short technical summary.
- Avoid implementation details at this stage; focus on value and outcomes.

---

## 2. Features

**Objective**: Enumerate the main capabilities of the system in user‑centric terms.

The agent should:

- Identify **primary user personas** (e.g., admin, end user, operator, external system).
- For each persona, list features as **user stories** or **high‑level requirements**, for example:
  - “As a \<user type\>, I can \<do something\> so that \<benefit\>.”
- Distinguish between:
  - **Core features** (must‑have for initial release).
  - **Nice‑to‑have features** (can be postponed).

**Special cases by project type:**

- **Backend services**
  - CRUD operations, APIs, event handlers, background jobs.
- **Web/mobile apps**
  - Screens, flows, navigation, offline behavior.
- **AI/ML systems**
  - Data ingestion, training, evaluation, inference, monitoring.
- **CLI tools / scripts**
  - Commands, flags, input/output formats, error handling.

The agent should avoid overspecifying behavior prematurely but ensure that **each feature is testable**.

---

## 3. Tech Stack

**Objective**: Propose or capture technology choices that match the user’s constraints and preferences.

The agent should:

- Ask whether the user has **preferred technologies** or **constraints**, such as:
  - Programming languages or frameworks.
  - Cloud providers or hosting environments.
  - Databases or messaging systems.
  - Existing systems that must be integrated.
- If the user has **no preference**, propose a sensible, modern stack considering:
  - Project type (web, backend, mobile, AI/ML, CLI, automation).
  - Team familiarity assumptions (e.g., widely used languages).
  - Simplicity vs. scalability trade‑offs.

The resulting PRD should include:

- Frontend stack (if applicable).
- Backend stack (if applicable).
- Data storage and messaging.
- AI/ML stack (if applicable).
- DevOps tooling (CI/CD, containerization, infrastructure).

Where appropriate, mark choices as **suggested** rather than mandatory.

---

## 4. Architecture (Conceptual)

**Objective**: Outline how the system is organized technically, without locking in low‑level implementation details.

The agent should:

- Describe the system in terms of:
  - **High‑level components** (e.g., web client, API server, worker, model server, CLI entrypoint).
  - **Data flows** between components.
  - **External dependencies** (databases, third‑party APIs, queues).
- Specify:
  - How different platforms interact (e.g., mobile app calling backend APIs).
  - Where AI/ML logic resides (e.g., separate service vs. embedded in backend).
  - Key cross‑cutting concerns (e.g., authentication, logging, error handling).

For multi‑agent execution, the architecture section should:

- Provide enough detail for the `architect-agent` to refine into a full design.
- Be understandable to `backend-agent`, `frontend-agent`, `ai-engineer-agent`, `devops-agent`, and `qa-agent`.

---

## 5. Milestones and Phasing

**Objective**: Break down delivery into manageable phases that the orchestrator can schedule and track.

The agent should:

- Define **2–5 milestones** that incrementally deliver value.
- For each milestone, list:
  - **Scope** (what features/parts of the system are included).
  - **Dependencies** (what must be ready before starting).
  - **Success criteria** (what it means for the milestone to be “done”).

Examples:

- **Milestone 1 – Foundations**
  - Basic project scaffolding.
  - Minimal end‑to‑end flow (e.g., one happy‑path feature working).
- **Milestone 2 – Core Features**
  - Implement the main feature set for the first users.
- **Milestone 3 – Advanced Capabilities / AI**
  - Add AI/ML, automation, or complex integrations.
- **Milestone 4 – Hardening and Deployment**
  - Improve UX, robustness, tests, and CI/CD.

The milestones should be **adapted** to the project type and complexity.

---

## Optional but Recommended Sections

Agents may also add:

- **Non‑functional requirements**
  - Performance, scalability, security, reliability, compliance.
- **Constraints and assumptions**
  - Budget or time constraints, legacy systems, regulatory requirements.
- **Metrics and success criteria**
  - How success will be measured (e.g., latency targets, adoption, conversion).
- **Risks and open questions**
  - Areas where information is missing or decisions are pending.

These help `architect-agent` and the orchestrator make better decisions.

---

## Example: Minimal PRD Outline Generated from an Idea

> User idea: “I want a mobile app that helps freelancers track time and generate invoices automatically.”

The agent should transform this into a PRD with sections like:

1. **Project description**
   - Name: “FreelanceTime”
   - Problem: Freelancers struggle to track work hours and generate professional invoices.
   - Users: Independent freelancers, consultants, small agencies.
   - Project type: Mobile app (iOS/Android) + backend service + optional web portal.

2. **Features**
   - Track time by project and client.
   - Generate invoices from tracked time.
   - Export or email invoices as PDFs.
   - Optional: basic reporting.

3. **Tech stack**
   - Mobile: Cross‑platform framework (e.g., React Native or Flutter).
   - Backend: REST API with relational database.
   - Auth: Email/password, later SSO.

4. **Architecture**
   - Mobile client calling backend API.
   - Backend managing users, projects, time entries, invoices.
   - PDF generation service or library.

5. **Milestones**
   - M1: Minimal app with manual time entry and local storage.
   - M2: Sync with backend and user accounts.
   - M3: Invoice generation and export.
   - M4: Polish, performance, and deployment.

---

## Interaction with Other Agents

The **Create‑PRD** agent (or mode) interacts as follows:

- **User / Product Owner**
  - Gathers clarifications and preferences.
  - Presents the drafted PRD for review.

- **Orchestrator Agent**
  - Once the PRD is finalized, passes it to the orchestrator for:
    - Architecture refinement by `architect-agent`.
    - Work breakdown and task assignment.

- **Specialist Agents**
  - May be consulted during PRD creation for feasibility checks (e.g., `ai-engineer-agent` for ML complexity, `devops-agent` for deployment constraints), but usually operate after the PRD is baselined.

The outcome of this process is a **clear, structured, and actionable PRD** that can drive the entire multi‑agent software development workflow.

