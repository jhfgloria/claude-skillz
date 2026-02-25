---
name: coding-typescript
description: Writes best practices for writing clean, maintainable TypeScript code in this codebase.
---

## Rules

- Use Sonnet 4.6 for this skill

## Key Principles

### Write Self-Explaining Code
- **Never add explanatory comments** unless absolutely necessary
- Code should be clear enough to understand without comments
- Use descriptive variable and function names instead
- Use short composable functions instead of long functions 

**Bad:**
```typescript
// This function gets the default headers including auth token and client info
async function getDefaultHeaders(account?: string): Promise<Record<string, string>> {
  // Get the subdomain for this account
  const subdomain = getSubdomain(account);
  // Build the client header with subdomain
  const clientHeader = subdomain
    ? `"MyApp" <https://${subdomain}.example.com>`
    : '"MyApp"';

  return {
    Authorization: await getAuthToken(account),
    Accept: 'application/json',
    'Content-Type': 'application/json',
    'X-Client-Id': clientHeader,
  };
}
```

**Good:**
```typescript
async function getDefaultHeaders(account?: string): Promise<Record<string, string>> {
  const subdomain = getSubdomain(account);
  const clientHeader = subdomain
    ? `"MyApp" <https://${subdomain}.example.com>`
    : '"MyApp"';

  return {
    Authorization: await getAuthToken(account),
    Accept: 'application/json',
    'Content-Type': 'application/json',
    'X-Client-Id': clientHeader,
  };
}
```

### Fallback Patterns
- Check all possible configuration paths
- Use nullish coalescing (`??`) for clean fallbacks

**Example:**
```typescript
const accounts =
  config.getOptional<PagerDutyAccountConfig[]>('pagerDuty.accounts')
  ?? config.getOptional<PagerDutyAccountConfig[]>('pagerDuty');
```

### Helper Function Pattern
- Extract repeated logic into helper functions
- Reduces duplication and makes updates easier
- Name helpers clearly based on what they return/do
- Don't make these helpers global and most time apply them locally

**Example:**
```typescript
async function getDefaultHeaders(account?: string): Promise<Record<string, string>> {
  const subdomain = getSubdomain(account);
  const clientHeader = subdomain
    ? `"MyApp" <https://${subdomain}.example.com>`
    : '"MyApp"';

  return {
    Authorization: await getAuthToken(account),
    Accept: 'application/json',
    'Content-Type': 'application/json',
    'X-Client-Id': clientHeader,
  };
}
```

### Type Safety
- Use TypeScript's type system fully
- Prefer `string | undefined` over `string | undefined | null`
- Use optional chaining (`?.`) and nullish coalescing (`??`) appropriately

### Test Coverage
- Update tests to match new implementations
- Use descriptive test names that explain what's being tested

## Common Patterns in This Codebase

### Configuration Loading
```typescript
const accounts =
  config.getOptional<AccountConfig[]>('service.accounts')
  ?? config.getOptional<AccountConfig[]>('service');
```

### Fallback Logic
```typescript
function getValue(key?: string): string | undefined {
  if (isLegacyMode) {
    return ValueConfig.default;
  }

  if (key && key !== 'default') {
    return ValueConfig[key] ?? fallbackValue ?? ValueConfig.default;
  }

  return fallbackValue ?? ValueConfig.default;
}
```
