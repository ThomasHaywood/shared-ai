# shared-ai

Shared Claude Code configuration library for the microservices platform. This repo is cloned once per developer machine and wired up at the global Claude Code level — no changes to individual service repos required.

## What lives here

| Path | Purpose |
|------|---------|
| `CLAUDE.md` | Global conventions, coding standards, and instructions that apply to every service |
| `agents/` | Reusable agent definitions available in all repos |
| `commands/` | Shared slash commands available inside Claude Code sessions |
| `mcp/` | MCP server configuration templates for common integrations |
| `docs/` | How to consume this repo: developer setup, CLAUDE.md hierarchy, onboarding |

## How to consume this repo

### 1. Clone once on your machine

```bash
git clone https://github.com/<org>/shared-ai ~/git/shared-ai
```

### 2. Wire up the global Claude Code config

Claude Code loads `~/.claude/CLAUDE.md` automatically in every repo.

**Simplest — symlink it:**

```bash
ln -s ~/git/shared-ai/CLAUDE.md ~/.claude/CLAUDE.md
```

**Or import it** if you want personal additions (note: use an absolute path, `~` is not expanded by Claude Code's import parser):

```markdown
@/Users/<your-username>/git/shared-ai/CLAUDE.md
```

### 3. Link shared commands and agents globally

```bash
# Make shared commands available in all repos
ln -s ~/git/shared-ai/commands ~/.claude/commands/shared

# Make shared agents available in all repos
ln -s ~/git/shared-ai/agents ~/.claude/agents/shared
```

See [docs/consuming-shared-config.md](docs/consuming-shared-config.md) for details on MCP templates and per-service setup.

### 4. Add service-specific rules to each repo

Each service repo should have its own `CLAUDE.md` with only service-specific additions. The global conventions are already loaded — no import needed:

```markdown
# <service-name>

## Architecture

This service is responsible for [describe responsibility].

## Local development

[Commands to start the service, seed data, etc.]

## Service-specific conventions

[Deviations from global standards, with rationale.]
```

See [docs/claude-md-hierarchy.md](docs/claude-md-hierarchy.md) for the full hierarchy.

## Keeping your local copy up to date

```bash
cd ~/git/shared-ai && git pull
```

Subscribe to this repo's releases or changelog to know when to pull.

## Who maintains this

This repo is owned jointly by both platform teams. Changes to global conventions require sign-off from both team leads. See [docs/contributing.md](docs/contributing.md) for the process.

## Repository layout

```
shared-ai/
├── CLAUDE.md                      # Global AI instructions
├── README.md                      # This file
├── agents/
│   ├── README.md
│   └── *.md                       # Agent definitions
├── commands/
│   ├── README.md
│   └── *.md                       # Slash command definitions
├── mcp/
│   ├── README.md
│   └── *.json / *.yaml            # MCP server config templates
└── docs/
    ├── developer-setup.md
    ├── consuming-shared-config.md
    ├── claude-md-hierarchy.md
    └── contributing.md
```
