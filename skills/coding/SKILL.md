---
name: coding
description: Codes the solution pointed by the user, or pointed by a previously agreed Plan. This Skill should always be selected when the task is to code. Then, according to the programming language it should pick different skills appointed by this Skill.
---

### Model
- Use Sonnet 4.6 while developing code.

### Base Rules
- Avoid long functions.
- Avoid long files.
- Avoid acronyms and abbreviations in names.
- Always try to organise code in Domain Driven Design.
- Avoid names like `utils` for folders or domains.
- Don't do refactoring of unnecessary code (outside the scope of the plan) unless told.
- Never commit code without permission.
- Duplications is not a bad thing. Don't try to DRY every repetition in code.
- Code should be DRYed if the target of repetition becomes a domain of the project.

### Programming Language best practices.
- TypeScript: use ./TYPESCRIPT.md for best practices.
- Elixir: use ./ELIXIR.md for best practices.
- Other programming languages: use Model knowledge and languages best-practices

### Tests
- Avoid long tests. Every test should test one scenarion/use-case.
- Use the Arrange-Act-Assess framework to write tests.
- Don't mock as Arrange as first approach. Only if necessary.
- Don't mock code that we don't control unless really necessary (e.g. dependencies).
- Use tools that mock the network, instead of mocking the libraries that do network calls.
- Use a test pyramid like Medium-Large-Small for Unit-Integration-E2E.

### Recommendations/Permissions
- Read best practices files freely:
    - ELIXIR.md
    - TYPESCRIPT.md
