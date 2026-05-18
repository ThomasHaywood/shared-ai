<!--
Command: /explain-service
Purpose: Produce a plain-English summary of this service for onboarding or documentation.
Usage: Run from inside a service repo with no arguments.
-->

Read the codebase in the current working directory and produce a structured, plain-English explanation of what this service does. Target audience: a developer who is joining the team and has not seen this code before.

## What to cover

1. **Purpose** — what business problem does this service solve? What would break if it stopped running?
2. **Public API surface** — list the endpoints or event topics this service exposes. For each: what does it accept, what does it return, who calls it?
3. **Dependencies** — what external services, databases, queues, or APIs does this service depend on? What happens if each goes down?
4. **Key data models** — what are the core entities this service manages? Describe their fields and relationships in plain language, not schema syntax.
5. **Deployment** — how is this service deployed? What environment variables must be set? What does a healthy startup look like?
6. **Known sharp edges** — TODOs, known limitations, areas of the code that are fragile or poorly understood.

## Format

Write in flowing prose with short headings. Aim for a length a new engineer could read in under 10 minutes. Do not copy-paste code — paraphrase and explain.