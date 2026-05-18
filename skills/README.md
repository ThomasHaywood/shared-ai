# Shared Slash Commands

This directory contains shared Claude Code slash commands that are useful across all service teams. Slash commands let you trigger a pre-defined prompt or workflow with a short `/command-name` invocation inside a Claude Code session.

## How slash commands work in Claude Code

Claude Code looks for command definitions in `.claude/commands/` within your project (and in the user-level `~/.claude/commands/` directory). Each `.md` file in those directories becomes an available `/filename` command.

## How to use these commands

### Option A — symlink the shared commands directory

```bash
# From your service repo root
ln -s .claude/shared/commands .claude/commands/shared
```

Then invoke with `/shared/pr-checklist`, `/shared/add-tests`, etc.

### Option B — copy commands you need

Copy individual command files into your service's `.claude/commands/` directory. Rename them if you want shorter invocation paths.

### Option C — import into your CLAUDE.md

Reference the commands in your service `CLAUDE.md` so Claude knows they exist:

```markdown
# @import .claude/shared/commands/pr-checklist.md
```

## Available commands

| Command file | Invocation | Purpose |
|-------------|-----------|---------|
| `pr-checklist.md` | `/pr-checklist` | Run a pre-merge checklist on the current branch |
| `add-tests.md` | `/add-tests` | Generate test cases for a selected function or file |
| `explain-service.md` | `/explain-service` | Produce a plain-English summary of what this service does |
| `find-todos.md` | `/find-todos` | List all TODO/FIXME/HACK comments in the codebase |

## Adding a new command

1. Create a new `.md` file in this directory. The filename becomes the slash command name (kebab-case, no spaces).
2. Start the file with a brief description comment (`<!-- ... -->`) and then the prompt body.
3. Add a row to the table above.
4. Open a PR against this repo. Commands affecting both teams require sign-off from both leads.