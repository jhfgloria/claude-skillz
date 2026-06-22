#### General
- Use semicolons.
- Use functional approaches as much as possible.
- Use for-loops instead of the functionall approach for cost-intensive iterations.

#### Functions
- Avoid anonymous fucntions, except when used as function arguments.

**Bad:**
```typescript
const getName = (person: Person) => person.name;
```

**Bad:**
```typescript
[1,2,3,4].forEach(function log(x) {
  console.log(x);
});
```

**Good:**
```typescript
function getName(person: Person) {
  return person.name;
}
```

**Bad:**
```typescript
[1,2,3,4].forEach((x) => (console.log(x)));
```

#### Conditionals
- When a if-else execution are one-liners, use a ternary condition instead:

**Bad:**
```typescript
if (isOdd(number)) {
  return number + 1;
} else {
  return number;
}
```

**Good:**
```typescript
return (isOdd(number)) ? number + 1 : number;
```

#### Type Safety
- Use TypeScript's type system to descrive functions, variables, and data structures.
- Never use `any`.
- When possible use type inference to no pollute the code.
- Use optional chaining (`?.`) and nullish coalescing (`??`) to traverse possibly `null`/`undefined` objects.

**Bad:**
```typescript
function doublePairs(n: number, m: number) {
  return [n * 2, m * 2];
}
```

**Bad:**
```typescript
function findName(person: Person): string | undefined {
  return person.profile && person.profile.name;
}
```

**Bad:**
```typescript
function getDatabaseConfiguration(config: Config): string {
  return (config && config.production && config.production.database) || "default";
}
```

**Good:**
```typescript
function doublePairs(n: number, m: number): [number, number] {
  return [n * 2, m * 2];
}
```

**Good:**
```typescript
function findName(person: Person): string | undefined {
  return person.profile?.name;
}
```

**Good:**
```typescript
function getDatabaseConfiguration(config: Config): string {
  return config?.production?.database ?? "default";
}
```

### Tests
- Avoid mocking as first approach to tests.
- Don't mock code that is not controlled by the project (e.g. dependencies).
- When testing external calls rely on tools like `msw` instead of mocking boundaries.
