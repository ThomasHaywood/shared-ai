# Setting Up the Shared Config as a Git Submodule

This guide walks you through adding `shared-ai` to your service repository as a git submodule so you can consume the shared Claude Code configuration.

## Prerequisites

- Git 2.13 or later
- Write access to your service repository
- Read access to this repository (`shared-ai`)

---

## Step 1: Add the submodule

Run this from the **root of your service repository**:

```bash
git submodule add https://github.com/<org>/shared-ai .claude/shared
```

This creates a `.claude/shared/` directory containing the contents of this repo, and adds a `.gitmodules` entry.

Commit both:

```bash
git add .gitmodules .claude/shared
git commit -m "chore: add shared-ai as Claude Code config submodule"
```

---

## Step 2: Configure `.gitmodules` for shallow cloning (optional but recommended)

Shallow clones reduce clone time in CI. Edit `.gitmodules`:

```ini
[submodule ".claude/shared"]
    path = .claude/shared
    url = https://github.com/<org>/shared-ai
    shallow = true
```

---

## Step 3: Update your CI pipeline

Add submodule initialisation to your CI setup step:

```yaml
# GitHub Actions example
- uses: actions/checkout@v4
  with:
    submodules: 'true'   # or 'recursive' if shared-ai itself has submodules
```

For other CI systems:

```bash
# Generic shell
git submodule update --init --recursive
```

---

## Step 4: Keeping the submodule up to date

The submodule is pinned to a specific commit. To pull in the latest shared config changes:

```bash
git submodule update --remote .claude/shared
git add .claude/shared
git commit -m "chore: update shared-ai to latest"
```

We recommend doing this on a regular cadence (e.g. monthly, or when a breaking change is announced in the shared repo's changelog).

---

## Removing the submodule

If you ever need to remove it:

```bash
git submodule deinit -f .claude/shared
git rm -f .claude/shared
rm -rf .git/modules/.claude/shared
git commit -m "chore: remove shared-ai submodule"
```

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Submodule directory is empty after clone | Run `git submodule update --init` |
| `fatal: repository not found` | Check the URL in `.gitmodules` and your SSH/HTTPS credentials |
| Detached HEAD in submodule | Normal — the submodule is pinned to a commit. Use `git submodule update --remote` to advance |
| CI fails to find shared files | Ensure your checkout step enables submodule fetch (see Step 3) |