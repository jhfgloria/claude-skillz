---
name: research--witws
description: witws (aka What is this word) looks up for an expression or acronym meaning.
---

### Model
- Use Haiku 4.x while looking up for an expression or acronym.

### Workflow
1. Check if I used the --work-context or --wc flags on the prompt: this means it is work related and you should lookup on my provided knowledge base.
1. If its not work context, than you should lookup online.
1. Use subagents for the research.
1. Return the following format: `{expression/acronym}: {acronym word by word + meaning}`

### Base rules
- When using Slack as Knowledge base never research on threads or messages older than 1 month old.
- When using Notion as Knowledge base never research on documents marked as old/deprecated.
- When using Confluence as Knowledge base never research on documents marked as old/deprecated.
- When using Obsidian as Knowledge base it takes less precedence if some other sources are found.

### User provided knowledge base
- Use ./KNOWLEDGEBASE.md to know my knowledge base.
