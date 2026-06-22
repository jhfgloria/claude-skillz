---
name: productivity--planning-learning
description: Plans a routine of learning based on fixed topics or my input desired learning
---

### Rules
- Use Haiku 4.5 to generate the learning plan.

### Fixed topics
- Elixir
- TypeScript
- NodeJS
- Distributed Systems
- Postgres

### Base Rules
- For NodeJS and TypeScript content use the latest issue on: https://nodeweekly.com/
- For Elixir content use the latest issue on: https://elixirweekly.net/
- For databases and Postgres content use: https://sqlfordevs.com
- If skill is part of worday scheduling relate the learnings with my work.
- Use Goodlinks API to check for unread articles to include in the learning plan.
- For extra content use:
  - https://www.ben-evans.com/
  - https://blog.pragmaticengineer.com/ 
  - https://www.lennysnewsletter.com/archive
  - https://distributedsystems.substack.com/archive
- Always output files in pt-pt.

### Workflow
- Pick the input (as priority) OR one or two fixed topics to generate content.
- Generate a plan with articles or videos based on your picks.
- Output a list with links as a learning plan:
  - Include the reading time for books/articles or screen time for videos.

### Recommendations/Permissions
- For Goodlinks API use the endpoint: `http://localhost:9428/api/v1/lists/unread`.
