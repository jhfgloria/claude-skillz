---
name: opening-pr
description: Opens a PR for the changes in the local branch. Updates the PR with new changes if it already exists.
---

## Overview

This skill opens a PR in Github for the changes in the local branch. If the PR already exists, updates it with the new 
changes. The PR title should be `[chore/fix/feat/<JIRA-ticket-id-if-any>] brief description`. The content should be
generated according to the changes, but the skill should check if there any PR templates in the project: look for it in
`.github` or `pull_request_template.md`. If there is a template adjust to it.

## Steps

- Open a PR with the current changes in it
- Use a title with format `[chore/fix/feat/<JIRA-ticket-id-if-any>] brief description`
- If the current session was labour of a JIRA ticket use its ID in the title, instead of chore/fix/feat
- Look for PR templates in the project
- Generate the content of the PR based on the changes, but adapt to the template if any
- In the end of the PR description sign with: `- [x] This PR was code assisted`

## Rules

- Use Haiku 4.5 for this skill

## Recommendations/Permissions

- The Github MCP server and tools should be used
- Only new PRs or PRs previously opened with this skill should be affected
