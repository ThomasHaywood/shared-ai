<!--
Command: /pr-checklist
Purpose: Run a pre-merge checklist on the current branch before opening or merging a PR.
Usage: Run with no arguments from inside any service repo.
-->

Review the current branch diff against `main` and work through the following pre-merge checklist. For each item, report the status (PASS / FAIL / SKIP with reason) and any specific issues found.

## Pre-Merge Checklist

### Code quality
- [ ] No `console.log`, `print`, `fmt.Println`, or equivalent debug statements left in production code paths
- [ ] No hardcoded secrets, API keys, passwords, or tokens
- [ ] No commented-out code blocks
- [ ] All new public functions/methods have types and docstrings (where applicable by language)

### Tests
- [ ] New functionality has corresponding unit tests
- [ ] Edge cases and failure paths are tested
- [ ] No existing tests were deleted or weakened without explanation

### API and data contracts
- [ ] No unintentional breaking changes to public API surfaces
- [ ] Database migrations are backward-compatible (no destructive column drops in the same migration as schema changes)
- [ ] Event schemas are additive only (no removed or renamed fields)

### Git hygiene
- [ ] Commit messages follow the Conventional Commits format
- [ ] No merge commits from `main` (rebase instead)
- [ ] Branch name follows the naming convention

### Documentation
- [ ] README or relevant docs updated if behaviour changed
- [ ] Any new environment variables documented in `.env.example`

---

After the checklist, provide a brief summary paragraph: overall readiness and the top 1-3 things to fix before merging (if any).