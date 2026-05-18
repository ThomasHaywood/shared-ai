#!/usr/bin/env bash
# Sets up shared-ai configuration on a developer machine.
# Safe to re-run: existing symlinks are skipped.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Setting up shared-ai from $REPO_DIR..."

# CLAUDE.md — only create if no file exists; don't overwrite personal config
if [ ! -e ~/.claude/CLAUDE.md ]; then
  ln -s "$REPO_DIR/CLAUDE.md" ~/.claude/CLAUDE.md
  echo "  Linked CLAUDE.md"
else
  echo "  Skipped CLAUDE.md (already exists — add '@$REPO_DIR/CLAUDE.md' manually if needed)"
fi

# Skills
mkdir -p ~/.claude/skills
for d in "$REPO_DIR/skills"/*/; do
  name=$(basename "$d")
  target=~/.claude/skills/"$name"
  if [ -e "$target" ]; then
    echo "  Skipped skill: $name (already exists)"
  else
    ln -s "$d" "$target"
    echo "  Linked skill: $name"
  fi
done

# Agents
mkdir -p ~/.claude/agents
for d in "$REPO_DIR/agents"/*/; do
  name=$(basename "$d")
  target=~/.claude/agents/"$name"
  if [ -e "$target" ]; then
    echo "  Skipped agent: $name (already exists)"
  else
    ln -s "$d" "$target"
    echo "  Linked agent: $name"
  fi
done

echo "Done. Restart Claude Code if it was already running."
