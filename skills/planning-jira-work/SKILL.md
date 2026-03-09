---
name: planning-jira-work
description: Plans the work needed for a specific JIRA ticket provided by the user. Creates a plan to address the ticket and discusses the plan with the user if needed.
---

## Overview

This skill loads the JIRA ticket provided by the user and plans the work needed to carry on with it. It should take into 
consideration the description, the acceptance criteria, links, and any attachments. In case of doubt the agent should
prompt more questions about the task. The plans should split frontend, backend, administrative tasks if necessary.

## Rules

- Use Haiku 4.5 for this skill

## Steps

- Analyse the JIRA ticket.
  - Is there a clear description? (more than 200 characters and goal is identified).
  - Is there a valid acceptance criteria? (criteria matches the description).
- Plan work for the JIRA tickets.
- Split the work in frontend, backend, administrative tasks if necessary.
- Ask the user questions if the scope is not entirely clear.

## Recommendations/Permissions

- The JIRA MCP server should be used freely for read-only operations.
- Try the `Atlassian [getJiraIssue]` tool to start with. It usually produces better results.
