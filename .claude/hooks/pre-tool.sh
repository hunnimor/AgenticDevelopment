#!/usr/bin/env bash
# pre-tool.sh — runs before every Bash tool call
# Receives tool input via $CLAUDE_TOOL_INPUT (JSON)

set -euo pipefail

LOG_DIR="$CLAUDE_PROJECT_DIR/.claude/logs"
mkdir -p "$LOG_DIR"

# Parse command from tool input
COMMAND=$(echo "${CLAUDE_TOOL_INPUT:-{}}" | jq -r '.command // empty' 2>/dev/null || true)

if [ -z "$COMMAND" ]; then
  exit 0
fi

# ── BLOCK: destructive commands ────────────────────────────────────────────────
if echo "$COMMAND" | grep -qE 'rm\s+-rf\s+/\s*$|rm\s+-rf\s+~\s*$'; then
  echo "🚫 BLOCKED: Refusing to run '$COMMAND' — deletes root or home directory." >&2
  exit 2
fi

if echo "$COMMAND" | grep -qP 'DROP\s+TABLE(?!\s+\S.*WHERE)' 2>/dev/null || \
   echo "$COMMAND" | grep -qi 'DROP TABLE' && ! echo "$COMMAND" | grep -qi 'WHERE'; then
  echo "🚫 BLOCKED: DROP TABLE without WHERE clause detected." >&2
  exit 2
fi

# ── WARN: risky git operations ─────────────────────────────────────────────────
if echo "$COMMAND" | grep -qE 'git push --force($| )' && ! echo "$COMMAND" | grep -q 'force-with-lease'; then
  echo "⚠️  WARNING: 'git push --force' detected. Consider '--force-with-lease' to avoid overwriting remote changes." >&2
  exit 1
fi

if echo "$COMMAND" | grep -qE 'git push (origin )?(main|master)(\s|$)'; then
  echo "⚠️  WARNING: Pushing directly to main/master. Consider using a feature branch and opening a PR." >&2
  exit 1
fi

# ── LOG: append entry to tool-calls.jsonl ─────────────────────────────────────
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
printf '{"timestamp":"%s","event":"pre-tool","command":%s}\n' \
  "$TIMESTAMP" \
  "$(echo "$COMMAND" | jq -Rs '.')" \
  >> "$LOG_DIR/tool-calls.jsonl"

exit 0
