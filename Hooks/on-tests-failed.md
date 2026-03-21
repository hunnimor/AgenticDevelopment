## Hook: on-tests-failed

### Trigger

Runs when `run-tests` returns one or more failing tests.

### Inputs

- Test run summary
- Failed test cases
- Error logs/traces
- Recent changed files

### Actions

1. Classify failures:
   - Regression
   - Flaky/infra
   - Incorrect expectation
2. Map failures to likely owning agent(s).
3. Create fix tasks with priority:
   - Critical path failures first.
4. Re-run targeted tests after fixes.
5. Escalate to orchestrator if unresolved after retry limit.

### Outputs

- Failure classification report
- Assigned remediation tasks
- Retest result

