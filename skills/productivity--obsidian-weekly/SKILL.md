---
name: productivity--obsidian-weekly
description: Creates a weekly report of what I did this week
---

### Rules
- Use Haiku 4.5 to generate a weekly report.

### Base Rules
- Enumerate the things I've done this week.
- Accept some details of what I did week to enrich the report.
- Relate data from multiple sources to enrich the report, focusing on what was done this week.
- Be succint in the every paragraph.
- Use bullet points or todo lists when possible.
- When using Github, always use the `gh` tool - username is `jhfgloria`.
- Things to do can be found in the file `kanban.md`.
- Output in Portugal Portugues (pt-pt) and HTML.
- Use style present in `dailies/2026-05-11.html`.
- The week should be every weekday between last Monday and the day of the report.
- Reports should not contain information from the week before.

### Workflow
- Look a the todos list (`kanban.md`) for things that were done this week or not complete.
- With subagents (in parallel) look for information in:
  - Gmail (relevant or important emails).
  - Calendar meetings.
  - Pagerduty week's incidents for my team (Dev Ecosystem and Public APIs Team).
  - Confluence reviewed or written by me.
  - JIRA for tickets assigned to me.
  - Github for my open PRs and required review.
  - Week's learnings (folder `til`).
- Relate the todos with this information and my input (if given).
- Generate a report in pt-pt.
  - Include what was done.
  - Include was not done.
- Write HTML report to folder `weeklies`.

### Recommendations/Permissions
- Use `gh` to access Github - username is `jhfgloria`.
- Use MCP servers for the other platforms requested, when possible.
- Always output files in pt-pt.
