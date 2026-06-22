---
name: research--tell-me-all-you-know
description: Researches about a specific topic. May be related to work context (--work-context or --wc) or general things found in the web. Skill is used whenever the use starts the prompt with "Tell me all you know".
---

### Model
- Use Sonnet 4.x while researching for the topic.

### Workflow
1. Check if I used the --work-context or --wc flags on the prompt: this means it is work related and you should research on my provided knowledge base.
1. Check if I used the --no-code or --nc flags on the prompt: this means you're not meant to look up in the codebase.
1. If its not work context, than you should research online.
1. Use subagents for the research.
1. Return a summarized version of the research, but prompt me to know if want more details: in that case show me a richer version of the research.

### Base rules
- When using Slack as Knowledge base never research on threads or messages older than 1 month old.
- When using Notion as Knowledge base never research on documents marked as old/deprecated.
- When using JIRA as Knowledge base never research on tickets marked as Won't Do.
- When using Linear as Knowledge base never research on tickets marked as Won't Do.
- When using Confluence as Knowledge base never research on documents marked as old/deprecated.
- When using Obsidian as Knowledge base it takes less precedence if some other sources are found.

### User provided knowledge base
- Use ./KNOWLEDGEBASE.md to know my knowledge base.
