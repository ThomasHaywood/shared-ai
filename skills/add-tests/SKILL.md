<!--
Command: /add-tests
Purpose: Generate test cases for the selected function, class, or file.
Usage: Select the code you want tests for in the editor, then run /add-tests.
       Optionally append a hint: /add-tests focus on error paths
-->

Look at the selected code (or the most recently discussed function/file if nothing is selected) and generate a comprehensive set of test cases.

## Instructions

1. Identify the unit under test: its inputs, outputs, side effects, and dependencies.
2. List the scenarios to cover before writing any code:
   - Happy path (expected inputs → expected outputs)
   - Boundary values (empty, zero, max, min)
   - Invalid inputs (wrong type, missing required field, out-of-range value)
   - Error/failure paths (dependency throws, network timeout, auth failure)
   - Any concurrency or ordering concerns if the function involves async behaviour
3. Write the tests using the project's existing test framework and conventions. Match the style of nearby test files exactly.
4. Do not mock dependencies that the project hits with real instances in integration tests — check the test directory conventions first.
5. If a scenario can't be tested without a significant new test fixture, note it as a `TODO` comment rather than skipping it silently.

## Output

- The generated test file (or additions to the existing test file), ready to paste or write directly.
- A brief note on any scenarios you deliberately omitted and why.