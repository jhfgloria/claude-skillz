---
name: planning-jira-work
description: Plans the work needed for a specific JIRA ticket provided by the user. Creates a plan to address the ticket and discusses the plan with the user if needed.
---

### Model
- Use Haiku 4.5 while reading the ticket and planning the work.

### Base Rules
- This is a plan only skill. No code should be generated at this point.

### Worflow
1. Analyse the JIRA ticket (description, acceptance criteria, links, attachments).
    1. Is there a clear description? (more than 200 characters and goal is identified).
    2. Is there a valid acceptance criteria? (criteria matches the description).
2. Plan work for the JIRA tickets.
3. Split the work in frontend, backend, administrative tasks if necessary.
4. Ask the user questions if the scope is not entirely clear.

### Recommendations/Permissions
- The JIRA MCP server should be used freely for read-only operations.
- Try the `Atlassian [getJiraIssue]` tool to start with. It usually produces better results.
