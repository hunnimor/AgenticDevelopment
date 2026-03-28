---
description: Write, run, and fix tests for a target file or feature
argument-hint: [file or module to test]
---

Read `.claude/skills/testing/SKILL.md` first.

**Detect the project's language and test framework:**
- Check for `package.json` → look for jest, vitest, mocha
- Check for `pyproject.toml` / `pytest.ini` → pytest
- Check for `go.mod` → `go test`
- Check for `*.test.*` or `*.spec.*` files to confirm conventions

**For the target `$ARGUMENTS` (or the most recently modified file if not given), write tests covering:**

1. **Happy path** — the expected flow with valid input
2. **Edge cases** — empty input, null/undefined, boundary values (0, -1, max int), special characters
3. **Error cases** — invalid input, missing required fields, external service failures
4. **Side effects** — verify that the right things were called (mocks), state was updated correctly

Follow the naming pattern: `should_<expected>_when_<condition>`

```typescript
// Example — Jest / TypeScript
describe('calculateDiscount', () => {
  it('should_return_10_percent_when_order_exceeds_100', () => {
    // Arrange
    const order = { total: 150, customerId: 'c1' }
    // Act
    const result = calculateDiscount(order)
    // Assert
    expect(result).toBe(15)
  })

  it('should_return_0_when_order_is_below_threshold', () => {
    expect(calculateDiscount({ total: 50, customerId: 'c1' })).toBe(0)
  })

  it('should_throw_when_order_total_is_negative', () => {
    expect(() => calculateDiscount({ total: -1, customerId: 'c1' }))
      .toThrow('Order total cannot be negative')
  })
})
```

**Run the tests.** If any fail:
1. Read the error message carefully
2. Fix the implementation or the test (prefer fixing the implementation unless the test expectation is wrong)
3. Re-run until green

**Check coverage** for the new/modified file:
- If coverage is below 80%, identify the uncovered branches and add tests
- Print final coverage percentage

Report: "X tests written, Y passing, Z failing. Coverage: N%"
