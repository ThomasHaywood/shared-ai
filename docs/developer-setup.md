# Developer Machine Setup

This guide walks through the one-time setup to consume shared Claude Code configuration on your machine. No changes to individual service repos are required.

## Prerequisites

- Git 2.13 or later
- Claude Code installed
- Read access to this repository (`shared-ai`)

---

## Step 1: Clone the repo

```bash
git clone https://github.com/<org>/shared-ai ~/git/shared-ai
```

The location (`~/git/shared-ai`) is a convention — you can use any stable path, just keep it consistent.

---

## Step 2: Wire up the global CLAUDE.md

Claude Code loads `~/.claude/CLAUDE.md` automatically in every repo on your machine.

**Option A — symlink (simplest):**

```bash
ln -s ~/git/shared-ai/CLAUDE.md ~/.claude/CLAUDE.md
```

**Option B — import, if you want personal additions alongside the shared config:**

Create `~/.claude/CLAUDE.md` using an absolute path (`~` is not expanded by Claude Code's import parser):

```markdown
@/Users/<your-username>/git/shared-ai/CLAUDE.md

---

## Personal preferences

[Your own additions below — these apply to all your sessions.]
```

---

## Step 3: Link shared commands and agents

Symlink the shared commands and agents into your global Claude Code directory so they're available in every repo:

```bash
# Shared commands — invoke as /shared/pr-checklist, /shared/add-tests, etc.
ln -s ~/git/shared-ai/commands ~/.claude/commands/shared

# Shared agents
ln -s ~/git/shared-ai/agents ~/.claude/agents/shared
```

---

## Step 4: Verify the setup

Open Claude Code in any service repo and check `/help` — shared commands should appear under the `shared/` namespace.

---

## Keeping up to date

```bash
cd ~/git/shared-ai && git pull
```

Subscribe to this repo's releases or the team changelog to know when a pull is warranted.

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Shared commands don't appear in `/help` | Check that the symlink target exists: `ls -la ~/.claude/commands/shared` |
| Global CLAUDE.md not loading | Confirm the file exists at `~/.claude/CLAUDE.md` and the import path is correct |
| Import path not resolving | Use an absolute path: `@/Users/<you>/git/shared-ai/CLAUDE.md` instead of `~` |
| Personal preferences conflict with shared rules | Place your additions after the `@` import line — the later content takes precedence |
