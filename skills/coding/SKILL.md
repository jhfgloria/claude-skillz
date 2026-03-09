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
- Code should be DRYed if the repitition becomes a domain of the project.

### Programming Language selection
- JavaScript: use `javascript-code` skill
- TypeScript: use `coding-typescript` skill
- Other programming languages: use Model knowledge and languages best-practices
