# Coding Skill

## Reading a Codebase Before Changing It

Never modify code you haven't read. Run these commands to orient yourself:

```bash
# 1. See the top-level structure
find . -maxdepth 2 -type d | grep -v node_modules | grep -v .git

# 2. Find the entry point
cat package.json | jq '.main, .scripts'   # JS/TS
grep -r "def main\|if __name__" src/ --include="*.py" -l  # Python
grep -r "func main()" . --include="*.go"  # Go

# 3. Understand what exists before adding something new
grep -r "UserService\|userService" src/ --include="*.ts" -l
grep -r "class.*Repository" src/ --include="*.py" -l

# 4. Read the neighbors of the file you'll change
ls -la src/services/
cat src/services/auth.service.ts  # read the file you'll change
cat src/services/user.service.ts  # read a similar file for pattern reference
```

---

## Function Structure Rules

**Single Responsibility.** A function does one thing. If you need "and" to describe it, split it.

**Max 30 lines.** If it's longer, it has multiple responsibilities or needs a helper.

**Max 4 parameters.** Use an options object for more:
```typescript
// Bad
function createUser(name: string, email: string, role: string, orgId: string, plan: string) {}

// Good
function createUser(params: {
  name: string
  email: string
  role: UserRole
  orgId: string
  plan: BillingPlan
}) {}
```

**Return early to avoid nesting:**
```typescript
// Bad — three levels of nesting
function processPayment(order) {
  if (order) {
    if (order.items.length > 0) {
      if (order.paymentMethod) {
        // ... actual logic buried here
      }
    }
  }
}

// Good — guard clauses
function processPayment(order) {
  if (!order) throw new Error('Order is required')
  if (order.items.length === 0) throw new Error('Order has no items')
  if (!order.paymentMethod) throw new Error('No payment method')

  // actual logic at zero indentation
}
```

---

## Error Handling Patterns

**Never swallow errors silently:**
```typescript
// Bad — error is lost
try {
  await db.save(record)
} catch (e) {}

// Good — log context, rethrow or wrap
try {
  await db.save(record)
} catch (err) {
  logger.error('db.save failed', { recordId: record.id, error: err.message })
  throw new DatabaseError('Failed to save record', { cause: err })
}
```

**Always include context in error messages:**
```python
# Bad
raise ValueError("Invalid input")

# Good
raise ValueError(f"Invalid date format for field 'start_date': got '{value}', expected ISO 8601 (e.g., 2024-01-15)")
```

**Fail fast at the boundary, not deep in the call chain:**
```go
// Validate at the HTTP handler level, not inside the service
func (h *Handler) CreateOrder(w http.ResponseWriter, r *http.Request) {
    var req CreateOrderRequest
    if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
        http.Error(w, "invalid request body", http.StatusBadRequest)
        return
    }
    if req.UserID == "" {
        http.Error(w, "user_id is required", http.StatusBadRequest)
        return
    }
    // now call the service with a valid request
}
```

---

## Comment Style

**Comment WHY, not WHAT.** The code shows what. Comments explain constraints, non-obvious decisions, and business rules.

```typescript
// Bad: increment retry count
retryCount++

// Good: max 3 retries to match Stripe's idempotency window (10 minutes)
// beyond that, the payment intent expires and must be recreated
if (retryCount >= 3) throw new PaymentExpiredError(paymentIntentId)
retryCount++
```

---

## Pre-Commit Checklist

Before running `/commit`:
- [ ] Linter passes with zero errors
- [ ] All new/modified functions have tests
- [ ] No `console.log`, `print(debug`, `debugger` statements
- [ ] No hardcoded secrets, API keys, or passwords
- [ ] No TODO without a ticket number (e.g., `// TODO(#234)`)
- [ ] Functions are ≤ 30 lines, ≤ 4 parameters
- [ ] Error cases are handled explicitly (no empty catch blocks)
