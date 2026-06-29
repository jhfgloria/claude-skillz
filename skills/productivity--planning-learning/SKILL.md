---
name: productivity--planning-learning
description: Plans a routine of learning based on fixed topics or my input desired learning (--topic <desired-topic>)
---

### Rules

- Use Haiku 4.x to generate the learning plan.

### Fixed topics

Check the topics I want to learn on TOPICS.md

### Base Rules

- Input topics take precedence over fixed topics.
- If Goodlinks API is available use it to check for unread articles to include in the learning plan.

### Workflow

- Pick the input (--topic <desired-topic>) OR one or two random fixed topics to generate content.
- Generate a plan with articles or videos based on your picks.
- Output a list with links as a learning plan:
  - Include the reading time for books/articles or screen time for videos.

### Recommendations/Permissions

- For Goodlinks API use the endpoint: `http://localhost:9428/api/v1/lists/unread`.
