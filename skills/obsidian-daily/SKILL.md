---
name: obsidian-daily
description: Creates a daily report of what I did today
---

### Rules
- Use Haiku 4.5 to generate a daily report.

### Base Rules
- Enumerate the things I've done today.
- Accept some details of what I did today to enrich the report.
- Relate data from multiple sources to enrich the report, focusing on what was done today.
- Be succint in the every paragraph.
- Use bullet points or todo lists when possible.
- When using Github, always use the `gh` tool - username is `jhfgloria`.
- Things to do can be found in the Obsidian vault folder `kanban.md`.
- Output in Portugal Portugues (pt-pt) and HTML.
- Use style present in `dailies/2026-05-11.html`.

### Workflow
- Look a the todos list (`kanban.md`) for things that were done today or not complete.
- With subagents (in parallel) look for information in:
  - Gmail (relevant or important emails).
  - Calendar meetings.
  - Pagerduty today's incidents for my team.
  - Confluence reviewed or written by me.
  - JIRA for tickets assigned to me.
  - Github for my open PRs and required review.
  - Day's learnings (folder `til`)
- Relate the todos with this information and my input (if given).
- Generate a report in pt-pt.
  - Include what was done.
  - Include was not done.
- Write HTML report to folder `dailies`.

### Recommendations/Permissions
- Use `gh` to access Github - username is `jhfgloria`.
- Use MCP servers for the other platforms requested, when possible.
- Always output files in pt-pt.
