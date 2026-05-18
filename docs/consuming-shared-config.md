# Consuming Shared Configuration

Once you have added `shared-ai` as a submodule (see [submodule-setup.md](submodule-setup.md)), this guide explains how to wire up each piece of shared configuration in your service repo.

---

## 1. CLAUDE.md (global conventions)

Import the shared `CLAUDE.md` at the top of your service's root `CLAUDE.md`:

```markdown
# @import .claude/shared/CLAUDE.md

---

## Service: <service-name>

[Your service-specific additions below]
```

See [claude-md-hierarchy.md](claude-md-hierarchy.md) for the full hierarchy guide.

---

## 2. Slash commands

Shared commands live in `.claude/shared/commands/`. You have three options:

### Option A — symlink the whole directory (all commands, auto-updated)

```bash
ln -s ../shared/commands .claude/commands/shared
```

Invoke as: `/shared/pr-checklist`, `/shared/add-tests`, etc.

### Option B — symlink individual commands (selective)

```bash
ln -s ../shared/commands/pr-checklist.md .claude/commands/pr-checklist.md
```

Invoke as: `/pr-checklist`

### Option C — copy and customise

```bash
cp .claude/shared/commands/add-tests.md .claude/commands/add-tests.md
# Edit the copy to suit your service
```

Use this when the shared command needs significant changes for your service. Note that copies do not receive upstream updates automatically.

---

## 3. Agent definitions

Shared agents live in `.claude/shared/agents/`. The same three options apply as for commands.

To reference an agent in your service `CLAUDE.md`:

```markdown
## Available agents

The following agents are available in this repo:

- `/agent code-reviewer` — reviews a diff for correctness, security, and style
- `/agent incident-triage` — helps triage production alerts
- `/agent api-designer` — assists with API contract design
```

To use an agent as a sub-agent in a multi-agent workflow:

```python
from anthropic import Anthropic

client = Anthropic()

# Example: spawn code-reviewer as a sub-agent
# See the Claude Agent SDK docs for the full pattern
```

---

## 4. MCP server templates

MCP templates live in `.claude/shared/mcp/`. To use one:

```bash
# Copy the template
cp .claude/shared/mcp/postgres.json .claude/mcp/postgres.json

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

Or use the user-level `~/.claude/settings.json` if the server is personal (e.g. connecting to your local dev database).

---

## Keeping shared config in sync

When the `shared-ai` repo is updated, pull the changes into your service:

```bash
git submodule update --remote .claude/shared
git add .claude/shared
git commit -m "chore: update shared-ai config"
```

Subscribe to the `shared-ai` repo's release notes or changelog to know when to update.

---

## Local developer setup checklist

After cloning a service repo that uses this submodule:

```bash
# 1. Initialise the submodule
git submodule update --init --recursive

# 2. Copy and fill in any MCP configs you need
cp .claude/shared/mcp/postgres.json .claude/mcp/postgres.json
# ... edit with your local database URL

# 3. Verify Claude Code picks up the shared config
# Open Claude Code in the service repo and check /help — shared commands should appear
```