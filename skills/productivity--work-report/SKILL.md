---
name: productivity--work-report
description: Creates a report of what I did. Accepts --day, --week, --month, and --quarter as flags.
---

### Rules

- Use Haiku 4.x to generate reports.

### Base Rules

- Looks at the periodicity flag (--day, --week, --month, --quarter) to check the report period.
  - If no flag was passed, ask me what period of these four should I pick, CLI style.
- Enumerate the things I've done for that period.
- Accept some details of what I did to enrich the report.
- Relate data from multiple sources to enrich the report, focusing on what was done.
- Be succint in the every paragraph.
- Output in descriptive paragraphs what was done. Should not be longer than 200-300 words except for month or quarter reports.

### Workflow

- With subagents (in parallel) look for information in provided sources (CONTEXT.md) related to MY work.
- Relate the todos with this information and my input (if given).
- Generate a descriptive paragraphs what was done:
  - Should not be longer than 200-300 words except for month or quarter reports.

### Recommendations/Permissions

- Use `gh` to access Github - username is CONTEXT.md.
- Use MCP servers for the other platforms requested, when possible.
