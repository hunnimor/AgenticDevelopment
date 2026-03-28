# Testing Skill

## Test Pyramid

```
        /\
       /  \
      / E2E \          Few — slow, expensive, test full flows
     /________\
    /          \
   / Integration \     Some — test service boundaries, real DB
  /______________\
 /                \
/   Unit Tests     \   Many — fast, isolated, test one function
/____________________\
```

**When to break the rules:**
- Skip unit tests for pure data transformation: the integration test covers it
- Add extra E2E tests when the integration point is the riskiest part (e.g., payment processing)
- Prefer integration over unit when mocking would obscure the real behavior

---

## Naming Pattern

```
should_<expected behavior>_when_<condition>
```

```python
# Good names — readable as documentation
def test_should_return_404_when_user_not_found(): ...
def test_should_send_welcome_email_when_user_registers(): ...
def test_should_not_charge_when_inventory_is_empty(): ...

# Bad names — tell you nothing
def test_user(): ...
def test_error_case(): ...
def test_2(): ...
```

---

## Arrange → Act → Assert

Every test follows this structure. One blank line between sections.

```typescript
// Jest / TypeScript
it('should_apply_free_shipping_when_order_exceeds_threshold', () => {
  // Arrange
  const cart = new Cart({ items: [{ sku: 'A1', price: 60, qty: 2 }] })
  const threshold = 100

  // Act
  const result = applyShippingRules(cart, threshold)

  // Assert
  expect(result.shippingCost).toBe(0)
  expect(result.appliedPromotion).toBe('FREE_SHIPPING_100')
})
```

```python
# pytest
def test_should_raise_when_stock_is_insufficient():
    # Arrange
    product = Product(sku="B2", stock=3)
    order_line = OrderLine(sku="B2", quantity=5)

    # Act & Assert
    with pytest.raises(InsufficientStockError, match="B2"):
        reserve_stock(product, order_line)
```

---

## What to Test vs What Not to Test

| Test this | Don't test this |
|---|---|
| Your domain logic | Framework routing and middleware |
| Error paths through your code | Third-party library internals |
| Boundary conditions | Private methods (test via public interface) |
| Behavior under concurrent access | Simple getters with no logic |
| Integration between your services | ORM internals |

---

## Mock Patterns

**Rule: mock external dependencies, never your own domain logic.**

```typescript
// Good — mock the HTTP client, not your service
jest.mock('../clients/stripe', () => ({
  createPaymentIntent: jest.fn().mockResolvedValue({ id: 'pi_test_123', status: 'created' })
}))

// Then verify it was called correctly
expect(stripeClient.createPaymentIntent).toHaveBeenCalledWith({
  amount: 5000,
  currency: 'usd',
  metadata: { orderId: 'ord_123' }
})
```

**Clock mocking** — don't test with real time:
```python
# pytest with freezegun
from freezegun import freeze_time

@freeze_time("2024-06-15 12:00:00")
def test_should_expire_session_after_one_hour():
    session = create_session(user_id="u1")
    travel_time(hours=1, seconds=1)
    assert session.is_expired() is True
```

---

## Parametrized Tests for Edge Cases

```python
# pytest.mark.parametrize — test many inputs without duplicating structure
@pytest.mark.parametrize("amount,expected_fee", [
    (0,       0.0),
    (0.01,    0.01),   # minimum fee
    (100,     2.9),    # standard rate
    (10_000,  290.0),  # large transaction
    (-1,      None),   # invalid — should raise
])
def test_should_calculate_processing_fee(amount, expected_fee):
    if expected_fee is None:
        with pytest.raises(ValueError):
            calculate_fee(amount)
    else:
        assert calculate_fee(amount) == expected_fee
```

```typescript
// Jest test.each
test.each([
  ['',        false, 'empty string'],
  ['a@b',     false, 'missing TLD'],
  ['a@b.c',   true,  'minimal valid'],
  ['a+b@c.io',true,  'plus addressing'],
])('should_return_%s_for_email_validity_when_input_is_%s', (input, expected) => {
  expect(isValidEmail(input)).toBe(expected)
})
```
