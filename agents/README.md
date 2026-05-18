# Shared Agent Definitions

This directory contains reusable Claude Code agent definitions. Agents are pre-configured AI assistants specialised for recurring tasks — code review, incident triage, API design, etc. — that any service team can invoke without re-prompting from scratch.

## What is an agent?

In Claude Code, an agent is a named prompt bundle that scopes Claude's role, persona, and instructions for a specific job. Agents can be invoked by name inside a session or wired up as sub-agents in multi-agent workflows using the Claude Agent SDK.

## How to use these agents

### Option A — reference from your service CLAUDE.md

Import the relevant agent file in your service's `CLAUDE.md` so Claude knows the agent exists:

```markdown
# @import .claude/shared/agents/code-reviewer.md
```

Then invoke it in session with:

```
/agent code-reviewer
```

### Option B — invoke directly in a multi-agent workflow

Point the SDK at the agent definition file when spawning a sub-agent:

```python
# Example using the Claude Agent SDK
agent = Agent.from_file(".claude/shared/agents/code-reviewer.md")
result = await agent.run(task="Review the diff for security issues")
```

### Option C — copy and customise

Copy any agent file into your service's `.claude/agents/` directory and modify it to suit your needs. Prefix the filename with your service name to avoid collisions: `payments-code-reviewer.md`.

## Directory contents

| File | Purpose |
|------|---------|
| `code-reviewer.md` | Reviews a diff or PR for correctness, style, and security |
| `incident-triage.md` | Helps an on-call engineer triage a production alert |
| `api-designer.md` | Assists with designing or reviewing a REST/gRPC API contract |

## Adding a new agent

1. Create a new `.md` file in this directory named after the agent's job (kebab-case).
2. Follow the structure in any existing agent file: role, context, instructions, constraints, output format.
3. Add a row to the table above.
4. Open a PR against this repo for team review before merging.