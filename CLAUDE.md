# Global Claude Code Instructions

This file defines organisation-wide conventions for AI-assisted development. It is consumed by every service repo via the CLAUDE.md import mechanism. Service-specific `CLAUDE.md` files may extend but should not contradict these rules without good reason.

---

## Architecture overview

<!-- TODO: Describe the high-level microservices topology here.
     Include:
     - The canonical list of services and their responsibilities
     - How services communicate (sync REST/gRPC, async events, etc.)
     - Shared infrastructure (API gateway, service mesh, message broker)
     - Data ownership boundaries — which service owns which domain data
     - External dependencies (third-party APIs, managed databases, etc.)
-->

This platform consists of multiple independently deployable microservices. Each service owns its own data store and exposes a well-defined API surface. Services communicate through [FILL IN: e.g. REST over HTTP/2 via the internal gateway / gRPC / async events on Kafka].

Key services:
- `service-a` — [describe responsibility]
- `service-b` — [describe responsibility]
- _(add more as needed)_

---

## Coding conventions

<!-- TODO: Fill in language-specific standards. A few recommended subsections: -->

### General

- Prefer explicit over implicit. Clever code is a maintenance cost.
- Keep functions small and focused. If a function needs a comment to explain what it does, consider renaming or splitting it.
- No commented-out code in commits. Use version control to recover old code.
- All public interfaces must have types/signatures (even in dynamically-typed languages).

### Language: [FILL IN e.g. TypeScript / Python / Go]

- [Style guide / linter ruleset reference]
- [Import ordering conventions]
- [Error handling pattern — e.g. Result types, exceptions, error codes]
- [Logging conventions — structured fields, log levels, no PII in logs]

### Naming

- [Naming conventions for files, variables, functions, classes]
- [Convention for environment variables — e.g. UPPER_SNAKE_CASE, prefixed by service name]

### Dependencies

- All new dependencies require a brief justification comment in the PR.
- Prefer well-maintained libraries with active security patching.
- Lock files must be committed and kept up to date.

---

## Git workflow

<!-- TODO: Choose one branching model and document it here (trunk-based, Gitflow, etc.) -->

### Branching

- `main` is always deployable to production.
- Feature branches: `feat/<ticket-id>-short-description`
- Bug fixes: `fix/<ticket-id>-short-description`
- Chores: `chore/<short-description>`

### Commits

- Use [Conventional Commits](https://www.conventionalcommits.org/) format: `type(scope): description`
- Commit messages describe *why*, not *what* — the diff shows what changed.
- Squash fixup commits before merging.

### Pull requests

- All changes go through a PR; no direct commits to `main`.
- PRs require at least [FILL IN: N] approvals before merging.
- PRs must have a passing CI build before merge.
- Keep PRs small: aim for < 400 lines changed. Split large work into stacked PRs.
- Link the relevant issue/ticket in the PR description.

### Code review etiquette

- Reviewers should respond within [FILL IN: e.g. 1 business day].
- Distinguish blocking vs. non-blocking comments (e.g. prefix non-blockers with `nit:`).
- Authors should not merge their own PRs unless explicitly unblocked.

---

## Testing standards

<!-- TODO: Fill in the test pyramid ratios, framework choices, and coverage thresholds. -->

### Levels

- **Unit tests**: test a single function or class in isolation, no I/O. Fast, numerous.
- **Integration tests**: test a single service against real dependencies (DB, cache). Slower, targeted.
- **End-to-end tests**: test a user journey across service boundaries. Minimal set, run in CI against staging.

### Frameworks

- Unit/integration: [FILL IN: e.g. Jest / pytest / Go testing package]
- E2E: [FILL IN: e.g. Playwright / Cypress / k6]

### Coverage

- Minimum coverage threshold: [FILL IN: e.g. 80%] on new code paths.
- Coverage gates are enforced in CI; PRs that drop below threshold are blocked.
- 100% coverage is not the goal — test the behaviour that matters.

### Test conventions

- Test names describe the scenario: `it("returns 404 when user does not exist")`
- Avoid test interdependence. Each test must be runnable in isolation.
- No real API keys, passwords, or PII in test fixtures. Use fakes or environment-injected secrets.
- Seed data should be deterministic and reset between test runs.

---

## How to escalate / ask for help

<!-- TODO: Fill in the real channels and process. -->

### Within Claude Code sessions

If you are unsure about a decision that could affect other teams or services, **stop and ask** before proceeding. Prefer leaving a `TODO:` comment and surfacing it in the PR rather than making an assumption.

### Human escalation paths

| Situation | Who to contact | How |
|-----------|---------------|-----|
| Cross-service API change | Both team leads | [FILL IN: e.g. Slack #platform-leads + tag in PR] |
| Security concern | Security guild | [FILL IN: e.g. Slack #security-alerts] |
| Production incident | On-call engineer | [FILL IN: e.g. PagerDuty runbook link] |
| Blocked on another team | Your team lead | Daily standup or direct Slack message |
| Architecture decision | Both teams | Schedule an Architecture Decision Record (ADR) review |

### Architecture Decision Records (ADRs)

Significant technical decisions must be recorded as ADRs in `docs/decisions/` within the relevant service repo. Use the template at [docs/adr-template.md](docs/adr-template.md).