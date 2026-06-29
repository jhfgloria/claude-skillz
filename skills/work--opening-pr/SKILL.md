---
name: work--opening-pr
description: Opens a PR for the changes in the local branch or pdates the PR with new changes if it already exists.
---

### Rules

- Use Sonnet 4.x while opening the PR.

### Base Rules

- Use titles like `[chore/fix/feat/<Linear-ticket-id-if-any>] brief description of work`.
- Don't describe changes technically.
- Describe changes as added value to a customer.
- Don't over extend the PR message. Sections (under markdown (sub-)titles) should not contain more than 200 words.
- Describe technical changes if the change was a chore (no customer value).
- Use pull request templates in the project if exist (look for it in `.github` or `pull_request_template.md`).

### Workflow

- Open a PR with the current changes in it
- Use a title with format `[chore/fix/feat/<JIRA-ticket-id-if-any>] brief description`
- If the current session was labour of a JIRA ticket use its ID in the title, instead of chore/fix/feat
- Look for PR templates in the project
- Generate the content of the PR based on the changes, but adapt to the template if any
- In the end of the PR description sign with: `- [x] This PR was code assisted`

### Recommendations/Permissions

- The Github MCP server and tools should be used
- Only new PRs or PRs previously opened with this skill should be affected
