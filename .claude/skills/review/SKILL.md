# Review Skill

## Priority Order

Always review and report in this order. Don't block on a lower-priority class if higher-priority issues remain.

1. **Correctness** — does it do what it should?
2. **Security** — could it be exploited?
3. **Performance** — will it degrade at scale?
4. **Reliability** — what happens when things fail?
5. **Readability** — can someone else maintain this?
6. **Style** — only if no linter handles it

---

## Security Checklist (OWASP Top 10 — Condensed)

**Injection (SQL, NoSQL, OS command):**
```typescript
// 🔴 Vulnerable
db.query(`SELECT * FROM users WHERE email = '${email}'`)

// ✅ Safe
db.query('SELECT * FROM users WHERE email = $1', [email])
```

**Broken Authentication:**
- Session tokens transmitted over HTTP (not HTTPS)?
- Password stored as plain text or weak hash (MD5, SHA1)?
- JWT secret hardcoded or from a weak source?

**Sensitive Data Exposure:**
- PII logged to console or files?
- API keys in source code or committed `.env`?
- Credit card / SSN stored unencrypted?

**Security Misconfiguration:**
- Debug mode enabled in production config?
- Default credentials unchanged?
- CORS set to `*` for non-public APIs?

**Broken Access Control:**
- Resource fetched by ID without checking ownership?
```python
# 🔴 Missing authorization check
def get_order(order_id):
    return Order.get(order_id)  # anyone can read any order

# ✅ Verified ownership
def get_order(order_id, current_user):
    order = Order.get(order_id)
    if order.user_id != current_user.id:
        raise PermissionDenied()
    return order
```

---

## Performance Red Flags

**N+1 queries:**
```python
# 🔴 N+1 — 1 query for orders, N queries for users
orders = Order.objects.all()
for order in orders:
    print(order.user.name)  # new query per order

# ✅ Eager load
orders = Order.objects.select_related('user').all()
```

**Synchronous I/O in a hot path:**
```typescript
// 🔴 Blocks the event loop on every request
app.get('/products', (req, res) => {
  const data = fs.readFileSync('products.json')  // sync read
  res.json(JSON.parse(data))
})

// ✅ Non-blocking
app.get('/products', async (req, res) => {
  const data = await fs.promises.readFile('products.json')
  res.json(JSON.parse(data))
})
```

**Missing index on filtered/sorted column** — flag any query on an unindexed foreign key or `ORDER BY` field in a large table.

---

## How to Write Constructive Feedback

The goal is to improve the code and help the author grow. Tone matters.

```
# Bad — vague, judgmental, no path forward
"This code is messy. You should fix it."
"This won't scale."

# Good — specific, explains why, shows the fix
"src/users/repository.ts:67 🟡
The query runs inside a loop — this will execute N+1 database queries as the
user count grows. Consider using a single query with an IN clause instead:

  // Before
  for (const id of userIds) {
    users.push(await db.query('SELECT * FROM users WHERE id = $1', [id]))
  }

  // After
  const users = await db.query(
    'SELECT * FROM users WHERE id = ANY($1)', [userIds]
  )
"
```

---

## PR Review Checklist

Before submitting your review:

- [ ] Read the PR description — is the purpose clear?
- [ ] Check every file in the diff (don't skim)
- [ ] Test the happy path mentally — does it work?
- [ ] Check error paths — what happens when each external call fails?
- [ ] Verify no secrets or debug code in the diff
- [ ] Check for missing tests on new code paths
- [ ] Look for auth/ownership checks on every data access
- [ ] Confirm public API changes are backwards-compatible or versioned
- [ ] Find something done well and call it out
