# Contributing to shared-ai

This repo is shared infrastructure for both development teams. Changes here affect everyone, so we use a deliberate review process.

## Who can contribute

Any engineer on either team can open a PR. Merging is gated on:

| Change type | Required approvals |
|------------|-------------------|
| Bug fix or typo in existing content | 1 team member from any team |
| New slash command or agent | 1 team member from each team (2 total) |
| Changes to `CLAUDE.md` conventions | Both team leads |
| New MCP server with write access | Both team leads + security review |
| Changes to this contributing guide | Both team leads |

## Process

1. **Open a PR** against `main` with a clear description of what you are adding and why it belongs in the shared repo (not in a single service).
2. **Tag reviewers** — use the CODEOWNERS file (or manually tag both team leads for convention changes).
3. **Wait for the required approvals** per the table above.
4. **Merge** using squash-merge to keep history clean.

## What belongs here vs. in a service repo

**Put it here if:**
- It applies to all services and both teams without modification
- It codifies a decision both teams have already agreed on
- It is a template that services fill in locally (e.g. MCP configs)

**Keep it in the service repo if:**
- It is specific to one service's domain, stack, or team conventions
- It contradicts or narrows a global convention (document the override in the service `CLAUDE.md`)
- It contains environment-specific secrets or endpoints

## Changelog

Maintain a brief changelog entry in `CHANGELOG.md` for every merged PR. Format:

```markdown
## [YYYY-MM-DD]
- Added: ...
- Changed: ...
- Fixed: ...
```

## Questions

Raise questions in [FILL IN: e.g. Slack #platform-ai-config] before opening a PR if you are unsure whether a change belongs here.