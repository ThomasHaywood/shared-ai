# Consuming Shared Configuration

After completing [developer-setup.md](developer-setup.md), the shared configuration is already active globally. This guide explains how each piece works and what (if anything) you need to do per service repo.

---

## 1. CLAUDE.md (global conventions)

**No action needed per service repo.** The shared `CLAUDE.md` is loaded via your `~/.claude/CLAUDE.md` import and applies to every session automatically.

Each service repo should have its own `CLAUDE.md` for service-specific additions only:

```markdown
# <service-name>

## Architecture

This service is responsible for [describe responsibility].

## Local development

[Commands to start the service, seed data, etc.]

## Service-specific conventions

[Any deviations from the global coding standards that apply only here, with rationale.]
```

See [claude-md-hierarchy.md](claude-md-hierarchy.md) for how Claude Code merges these layers.

---

## 2. Skills

Shared skills are symlinked globally at `~/.claude/skills/shared/` (set up in [developer-setup.md](developer-setup.md)) and available in every repo.

Invoke them as: `/shared/pr-checklist`, `/shared/add-tests`, etc.

**To add a service-specific skill** that doesn't belong in shared-ai, add it to the service repo's `.claude/skills/`:

```bash
# From service repo root
mkdir -p .claude/skills/my-skill
# Create .claude/skills/my-skill/SKILL.md
```

These are committed to the service repo and only available when working in that repo.

**To customise a shared skill** for a specific service:

```bash
cp -r ~/.claude/skills/shared/add-tests .claude/skills/add-tests
# Edit the copy to suit this service
```

Note: copied skills do not receive upstream updates automatically.

---

## 3. Agent definitions

Shared agents are symlinked globally at `~/.claude/agents/shared/` and available in every repo.

To reference an agent in your service `CLAUDE.md`:

```markdown
## Available agents

- `/agent shared/code-reviewer` — reviews a diff for correctness, security, and style
- `/agent shared/incident-triage` — helps triage production alerts
```

To add a service-specific agent, place it in the service repo's `.claude/agents/` and commit it.

---

## 4. MCP server templates

MCP templates live in `~/git/shared-ai/mcp/`. These are per-project because they contain environment-specific connection details.

To use one in a service repo:

```bash
# Copy the template into the service repo
mkdir -p .claude
cp ~/git/shared-ai/mcp/postgres.json .claude/mcp/postgres.json

# Edit it — fill in <FILL_IN: ...> placeholders
# Use $ENV_VAR references, never hardcoded secrets
```

Register the server in your project's `.claude/settings.json`:

```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres", "$DATABASE_URL"]
    }
  }
}
```

Use the user-level `~/.claude/settings.json` instead if the server is personal (e.g. connecting to your local dev database).

---

## Summary: what lives where

| Config type | Location | Committed? |
|-------------|----------|------------|
| Global conventions | `~/.claude/CLAUDE.md` (imports shared-ai) | No — developer machine only |
| Service-specific rules | `<service-repo>/CLAUDE.md` | Yes |
| Shared skills | `~/.claude/skills/shared/` (symlink) | No — developer machine only |
| Service-specific skills | `<service-repo>/.claude/skills/<name>/SKILL.md` | Yes |
| Shared agents | `~/.claude/agents/shared/` (symlink) | No — developer machine only |
| Service-specific agents | `<service-repo>/.claude/agents/` | Yes |
| MCP templates | `~/git/shared-ai/mcp/` | Source only — copy per project |
| MCP project config | `<service-repo>/.claude/mcp/` | Yes (no secrets) |
