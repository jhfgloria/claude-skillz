---
name: scheduling-work
description: Schedules my workday with learning, business as usual and meetings preparation
---

### Rules
- Use Haiku 4.5 to generate the workday schedule.

### Base Rules
- Meetings created on the calendar are always private.
- Meetings should not overlap existing meetings.
- Schedule only for the rest of the day. Don't create meetings for a time before I run the skill.
- Do NOT book anything between 12:00 and 14:00 WEST.
- My day starts at 9:30 and ends at 17:30 WEST.
- Always start the day with email/chat catchup, so I can update the todos if anything is urgent, followed by a learning session.
- When generating learning sessions, try to relate to the work that I'm doing or work that is in todo state.
- Reserve 30 minutes per day to review PRs.
- Give priority based on:
  - Tasks in Doing (`kanban.md`).
  - Tasks in Backlog top-bottom (`kanban.md`).
- Output in pt-pt.

### Workflow
- Look a the todos list (`kanban.md`) for things that were done today or not complete.
- With subagents (in parallel) look for information in:
  - Gmail (relevant or important emails).
  - Calendar meetings.
  - Pagerduty today's incidents for my team.
  - Confluence reviewed or written by me.
  - JIRA for tickets assigned to me.
  - Github for my open PRs and required review.
  - Unread articles from Goodlinks.
- Create a schedule for the day:
  - Meeting preparation if necessary.
  - One hour a day of learning: use `planning-learning` skill to find a list of articles.
  - Slots for the things I have todo (`kanban.md`).
- Present me the schedule and prompt me if I accept or not.
- If accepted create the slots in Google calendar.
  - If the MCP does not have permissions to do it, write the plan on schedule.html.

### Recommendations/Permissions
- Use `gh` to access Github - username is `jhfgloria`.
- Use MCP servers for the other platforms requested, when possible.
- Use the `planning-learning` skill to generate the one hour of learning.