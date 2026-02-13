---
name: pagerduty-api-call
description: Make API calls to PageDuty given a context of what to run and a [-s subdomain] and [-p environment].
---

# Context
The agent receives a user prompt to make an API call to PageDuty. The prompt includes the subdomain and environment as flags, e.g., `-s mysubdomain -p environment`. The agent should not explore any webpage documentation for the API, with the exception of the known endpoints listed in this document. The agent should only use the API keys provided in this document for authentication when making API calls. When possible give me a response with on a table format like this one:
┌─────────┬──────────────────────┬──────────┬──────────────────────────────────────────────────────────────────┬───────────────┐
│   ID    │       Name           │  Status  │                           Description                            │ Last Incident │
├─────────┼──────────────────────┼──────────┼──────────────────────────────────────────────────────────────────┼───────────────┤
│ P6V1UFE │ Backstage Integra... │ active   │ Testing Backstage Integration service.                           │ 2025-12-05    │
├─────────┼──────────────────────┼──────────┼──────────────────────────────────────────────────────────────────┼───────────────┤
│ PBNPEFA │ Default Service      │ critical │ Your first service - describe what this service is monitoring... │ 2026-01-29    │
├─────────┼──────────────────────┼──────────┼──────────────────────────────────────────────────────────────────┼───────────────┤
│ P1XVV95 │ New Service          │ active   │ A description for the new service                                │ None          │
├─────────┼──────────────────────┼──────────┼──────────────────────────────────────────────────────────────────┼───────────────┤
│ PJJ78YQ │ pd-service-9         │ active   │ This is a new service                                            │ None          │
├─────────┼──────────────────────┼──────────┼──────────────────────────────────────────────────────────────────┼───────────────┤
│ PE0YWNE │ service-2            │ active   │ service-2                                                        │ None          │
├─────────┼──────────────────────┼──────────┼──────────────────────────────────────────────────────────────────┼───────────────┤
│ P9F9IXP │ Testing Service      │ active   │ (no description)                                                 │ None          │
└─────────┴──────────────────────┴──────────┴──────────────────────────────────────────────────────────────────┴───────────────┘

# What the agent should do
1. Check if there are API keys available in the skill. If not, stop and ask the user to update the SKILL.md file.
1. Look for the documentation for the known endpoint that matches the user prompt, and use the information in the documentation to make the API call.
2. Use curl to make the API call, and include the necessary headers for authentication and content type.
3. Format the response in a table format like the one shown above, and include the relevant information from the API response in the table (pagination data, for example).
4. Print the curl command used to make the API call.

# Environments

- Staging: https://api.pd-staging.com
- Production: https://api.pagerduty.com

# Known Endpoints
This is the list of endpoints and their respective documentation URL page, that the agent should use to get informed
about the API call to make. The agent should only use these endpoints and not refer to the documentation for other endpoints, unless the user prompt explicitly asks for an endpoint that is not in this list.

## Services endpoints
### List services
`GET /services`: https://developer.pagerduty.com/api-reference/e960cca205c0f-list-services

# Known headers
- `Accept: application/vnd.pagerduty+json;version=2`
- `Authorization: Token token=<API_KEY>`
- `Content-Type: application/json`

# API Keys
- <environment>:<subdomain> -> <MISSING_API_KEY>