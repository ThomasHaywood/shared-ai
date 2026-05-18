# The CLAUDE.md Hierarchy

Claude Code reads `CLAUDE.md` files at multiple directory levels and merges them into a single set of instructions for a session. Understanding this hierarchy is how you layer shared global conventions with service-specific rules.

## How Claude Code loads CLAUDE.md files

Claude Code reads `CLAUDE.md` from the following locations, in order (innermost wins on conflict):

1. **User-level** — `~/.claude/CLAUDE.md` (applies to all projects for this developer)
2. **Project root** — `<repo-root>/CLAUDE.md` (applies to all sessions in this repo)
3. **Subdirectory** — `<repo-root>/src/some-package/CLAUDE.md` (applies when Claude is working inside that subtree)

All levels are active simultaneously. Claude Code merges the instructions from all files it finds.

## The import mechanism

Use `@<path>` inside a `CLAUDE.md` file to pull in another file's content:

```markdown
@/Users/<your-username>/git/shared-ai/CLAUDE.md
```

The imported file's content is inserted at that position. Use absolute paths — `~` is not expanded by Claude Code's import parser.

## How the shared config fits in

```
~/.claude/CLAUDE.md              ← imports shared-ai/CLAUDE.md (global conventions)
         |
         v
<service-repo>/CLAUDE.md         ← service-specific rules only (no import needed)
         |
         v
<service-repo>/src/pkg/CLAUDE.md ← package-level overrides (optional)
```

The shared conventions flow in via the developer's `~/.claude/CLAUDE.md`. Service repos don't need to import or reference `shared-ai` directly — they only define what's different about that service.

## Recommended service root CLAUDE.md pattern

```markdown
# <service-name>

## Architecture

This service is responsible for [describe responsibility].

It communicates with:
- [ServiceA] via [REST / gRPC / events]
- [ServiceB] via [REST / gRPC / events]

## Local development

[Commands to start the service locally, seed test data, etc.]

## Service-specific conventions

[Any deviations from the global coding standards that apply only here, with rationale.]
```

## What to put where

| Convention type | Where it lives |
|----------------|---------------|
| Platform-wide coding standards | `shared-ai/CLAUDE.md` |
| Cross-cutting Git workflow | `shared-ai/CLAUDE.md` |
| Platform-wide testing standards | `shared-ai/CLAUDE.md` |
| Personal preferences (no PII) | `~/.claude/CLAUDE.md` (after the import) |
| This service's domain model | Service root `CLAUDE.md` |
| This service's local dev setup | Service root `CLAUDE.md` |
| Package-specific invariants | Package-level `CLAUDE.md` |

## Conflict resolution

When two levels contradict each other, the **more specific file wins** (innermost in the directory tree). If you find yourself overriding a global convention in a service, add a comment explaining why so the deviation is intentional and visible in code review.

Example:

```markdown
## Testing standards

<!-- Override: this service uses real DB in unit tests because mocking caused prod divergence.
     See incident post-mortem: <link>. Agreed with both team leads on 2025-03-01. -->

All tests hit a real test-database instance. No mocking of the data layer.
```
