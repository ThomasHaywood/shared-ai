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

## Step 3: Link shared skills and agents

Run the install script — it creates all the symlinks in one go and is safe to re-run:

```bash
~/git/shared-ai/scripts/install.sh
```

Or do it manually if you prefer:

```bash
mkdir -p ~/.claude/skills
for d in ~/git/shared-ai/skills/*/; do
  ln -s "$d" ~/.claude/skills/$(basename "$d")
done

mkdir -p ~/.claude/agents
for d in ~/git/shared-ai/agents/*/; do
  ln -s "$d" ~/.claude/agents/$(basename "$d")
done
```

Skills are invoked directly by name: `/add-tests`, `/pr-checklist`, etc.

---

## Step 4: Verify the setup

Open Claude Code in any repo and try `/add-tests` — it should autocomplete and run.

---

## Keeping up to date

```bash
cd ~/git/shared-ai && git pull
~/git/shared-ai/scripts/install.sh  # links any newly added skills or agents
```

Subscribe to this repo's releases or the team changelog to know when to pull.

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Skill doesn't appear | Check the symlink exists: `ls -la ~/.claude/skills/<skill-name>` |
| Global CLAUDE.md not loading | Confirm the file exists at `~/.claude/CLAUDE.md` and the import path is correct |
| Import path not resolving | Use an absolute path: `@/Users/<you>/git/shared-ai/CLAUDE.md` instead of `~` |
| Personal preferences conflict with shared rules | Place your additions after the `@` import line — the later content takes precedence |
