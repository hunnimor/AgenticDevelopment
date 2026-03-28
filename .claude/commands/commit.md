---
description: Stage, review, and create a Conventional Commit with safety checks
---

Run `git diff --staged` to see what is staged.

If nothing is staged:
1. Run `git status` to show all changed and untracked files.
2. Show the list to the user and ask which files to add.
3. Stage the selected files with `git add`.

Before generating the message, check the staged diff for:
- **Debug code**: `console.log`, `print(`, `debugger`, `pdb.set_trace`, `fmt.Println` — flag if found
- **Hardcoded secrets**: strings that look like API keys, passwords, tokens — flag and block if found
- **TODOs without ticket**: `TODO` or `FIXME` not followed by a ticket reference (e.g., `TODO(#123)`) — warn

Generate a **Conventional Commit** message:
```
<type>(<scope>): <short imperative description>

- <what changed and why, bullet 1>
- <what changed and why, bullet 2>
```

Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `ci`, `build`, `revert`

Rules for the subject line:
- Max 72 characters
- Imperative mood ("add feature" not "added feature")
- No period at the end

Show the full commit message to the user and ask for confirmation.

If confirmed, run:
```bash
git commit -m "<generated message>"
```

Print the commit hash and subject on success.
