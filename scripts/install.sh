#!/usr/bin/env bash
# Sets up shared-ai configuration on a developer machine.
# Safe to re-run: existing symlinks are skipped.

set -euo pipefail

shopt -s nullglob

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

link_if_missing() {
  local src="$1" target="$2" label="$3"
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "  Skipped $label (already exists)"
  else
    ln -s "$src" "$target"
    echo "  Linked $label"
  fi
}

echo "Setting up shared-ai from $REPO_DIR..."

# CLAUDE.md — only create if no file exists; don't overwrite personal config
if [ ! -e ~/.claude/CLAUDE.md ] && [ ! -L ~/.claude/CLAUDE.md ]; then
  ln -s "$REPO_DIR/CLAUDE.md" ~/.claude/CLAUDE.md
  echo "  Linked CLAUDE.md"
else
  echo "  Skipped CLAUDE.md (already exists — add '@$REPO_DIR/CLAUDE.md' manually if needed)"
fi

# Skills (each skill is a directory containing SKILL.md)
mkdir -p ~/.claude/skills
for d in "$REPO_DIR/skills"/*/; do
  link_if_missing "$d" ~/.claude/skills/"$(basename "$d")" "skill: $(basename "$d")"
done

# Agents (each agent is a .md file; uppercase .md files are docs, not agents)
mkdir -p ~/.claude/agents
for f in "$REPO_DIR/agents"/*.md; do
  name=$(basename "$f")
  [[ "$name" =~ ^[A-Z] ]] && continue
  link_if_missing "$f" ~/.claude/agents/"$name" "agent: $name"
done

echo "Done. Restart Claude Code if it was already running."
