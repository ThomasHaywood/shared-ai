# shared-ai

Shared Claude Code configuration library for the microservices platform. This repo is consumed by all service teams as a **git submodule** and provides a common baseline for AI-assisted development across the organisation.

## What lives here

| Path | Purpose |
|------|---------|
| `CLAUDE.md` | Global conventions, coding standards, and instructions that apply to every service |
| `agents/` | Reusable agent definitions that teams can reference or extend |
| `commands/` | Shared slash commands available inside Claude Code sessions |
| `mcp/` | MCP server configuration templates for common integrations |
| `docs/` | How to consume this repo: submodule setup, CLAUDE.md hierarchy, onboarding |

## How to consume this repo

### 1. Add as a git submodule

```bash
# From the root of your service repo
git submodule add https://github.com/<org>/shared-ai .claude/shared
git submodule update --init --recursive
```

### 2. Wire up the CLAUDE.md hierarchy

Claude Code automatically reads `CLAUDE.md` files at every directory level. Point your service's root `CLAUDE.md` at the shared one by importing it:

```markdown
# @import .claude/shared/CLAUDE.md
```

Then add your service-specific overrides below the import. See [docs/claude-md-hierarchy.md](docs/claude-md-hierarchy.md) for the full pattern.

### 3. Register shared commands and agents

Symlink or copy the `commands/` and `agents/` directories into your service's `.claude/` folder, or reference them directly. See [docs/consuming-shared-config.md](docs/consuming-shared-config.md) for options.

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
    ├── consuming-shared-config.md
    ├── claude-md-hierarchy.md
    ├── submodule-setup.md
    └── contributing.md
```