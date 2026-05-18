# MCP Server Configuration Templates

This directory contains configuration templates for [Model Context Protocol (MCP)](https://modelcontextprotocol.io) servers used across the platform. MCP servers extend Claude Code with access to external tools and data sources — databases, internal APIs, observability platforms, CI systems, etc.

## What is MCP?

MCP is an open standard that lets AI assistants connect to external systems through a consistent interface. Each MCP server exposes a set of tools (callable functions) and/or resources (readable data) that Claude can use during a session.

## How to use these templates

### 1. Copy the template for the server you need

```bash
cp .claude/shared/mcp/postgres.json .claude/mcp/postgres.json
```

### 2. Fill in the environment-specific values

Each template contains `<FILL_IN: ...>` placeholders. Replace them with real values for your environment. **Never commit real credentials** — use environment variable references (`$ENV_VAR_NAME`) instead of hardcoded secrets.

### 3. Register the server in your Claude Code settings

Add the server to your project's `.claude/settings.json` or the user-level `~/.claude/settings.json`:

```json
{
  "mcpServers": {
    "postgres": {
      "configFile": ".claude/mcp/postgres.json"
    }
  }
}
```

Or inline the config directly in `settings.json` — see [docs/consuming-shared-config.md](../docs/consuming-shared-config.md) for the full pattern.

## Available templates

| File | MCP server | Purpose |
|------|-----------|---------|
| `postgres.json` | PostgreSQL | Read-only query access to a Postgres database |
| `github.json` | GitHub | Access to PRs, issues, and code search via the GitHub API |
| `observability.json` | [FILL IN] | Query logs, metrics, and traces from the observability platform |
| `internal-api.json` | Internal API gateway | Call internal service APIs with service-account auth |

## Security guidelines

- MCP servers with write access (mutations, deployments) must be explicitly marked as such in the template filename: `postgres-readwrite.json`.
- All servers must use environment variable references for credentials — never hardcode.
- Read-only servers should be preferred for day-to-day development use.
- Review the tool list exposed by each server before enabling it. Claude can only call tools that appear in the server's manifest.

## Adding a new MCP server template

1. Create a new JSON file in this directory. Name it after the system it connects to.
2. Use `<FILL_IN: description>` for every value that is environment-specific.
3. Add a row to the table above and document any required environment variables.
4. Open a PR for review — new MCP servers with write access require both team leads to approve.