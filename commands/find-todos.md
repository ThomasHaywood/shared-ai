<!--
Command: /find-todos
Purpose: List all TODO, FIXME, HACK, and XXX comments in the codebase with context.
Usage: Run with no arguments. Optionally filter: /find-todos security
-->

Search the entire codebase for comments tagged `TODO`, `FIXME`, `HACK`, `XXX`, or `DEBT`. Group and present them in a structured report.

## Instructions

1. Find all occurrences of the above tags in source files. Exclude vendor, node_modules, and generated code directories.
2. For each occurrence, capture:
   - File path and line number
   - The full comment text
   - 2-3 lines of surrounding code for context
3. Group results by category:
   - **Security** — anything mentioning auth, tokens, secrets, validation, injection
   - **Correctness** — known bugs or incorrect behaviour left for later
   - **Performance** — known slow paths or inefficient code
   - **Cleanup** — dead code, unused imports, temporary workarounds
   - **Documentation** — missing docs or explanations
   - **Other** — anything that doesn't fit above
4. Within each group, sort by file path for easy navigation.

## Output format

```
## TODO Report — <repo name> — <date>

Total: N items across M files

### Security (N)
- [file:line] comment text
  Context: ...

### Correctness (N)
...

### Summary
Top 3 highest-priority items to address, with a one-sentence rationale for each.
```

If a filter argument was provided, only show items whose comment text contains that keyword.