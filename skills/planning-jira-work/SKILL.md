---
name: planning-jira-work
description: Plans the work needed for a specific JIRA ticket provided by me. Creates a plan to address the ticket and discusses the plan with me if needed.
---

### Model
- Use Haiku 4.x while reading the ticket.
- Use Opus 4.x and planning the work.

### Worflow
1. Analyse the JIRA ticket (description, acceptance criteria, links, attachments).
    1. Is there a clear description? (more than 200 characters and goal is identified).
    1. Is there a valid acceptance criteria? (criteria matches the description).
1. Plan work for the JIRA tickets.
1. Split the work in frontend, backend, administrative tasks if necessary.
1. Ask me questions if the scope is not entirely clear.

### Base Rules
- This is a plan only skill. No code should be generated at this point.

### Recommendations/Permissions
- The JIRA MCP server should be used freely for read-only operations.
- Try the `Atlassian [getJiraIssue]` tool to start with. It usually produces better results.
