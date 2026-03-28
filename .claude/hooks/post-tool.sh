#!/usr/bin/env bash
# post-tool.sh — runs after every Write/Edit/MultiEdit tool call
# Receives tool input via $CLAUDE_TOOL_INPUT (JSON)

LOG_DIR="$CLAUDE_PROJECT_DIR/.claude/logs"
mkdir -p "$LOG_DIR"

# Parse file path from tool input
FILE=$(echo "${CLAUDE_TOOL_INPUT:-{}}" | jq -r '.file_path // empty' 2>/dev/null || true)

if [ -z "$FILE" ]; then
  exit 0
fi

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
EXT="${FILE##*.}"

# ── AUTO-FORMAT based on extension ─────────────────────────────────────────────
format_file() {
  local file="$1"
  local ext="$2"

  case "$ext" in
    js|ts|jsx|tsx|json|css)
      if command -v prettier &>/dev/null; then
        prettier --write "$file" --log-level silent 2>/dev/null && \
          echo "✨ Formatted with prettier: $file"
      fi
      ;;
    py)
      if command -v black &>/dev/null; then
        black "$file" -q 2>/dev/null && \
          echo "✨ Formatted with black: $file"
      fi
      ;;
    go)
      if command -v gofmt &>/dev/null; then
        gofmt -w "$file" 2>/dev/null && \
          echo "✨ Formatted with gofmt: $file"
      fi
      ;;
  esac
}

format_file "$FILE" "$EXT"

# ── HINT: test file modified ───────────────────────────────────────────────────
BASENAME=$(basename "$FILE")
if echo "$BASENAME" | grep -qE '\.test\.|\.spec\.|^test_'; then
  echo "💡 Test file modified. Run your test suite."
fi

# ── LOG: append entry to tool-results.jsonl ───────────────────────────────────
printf '{"timestamp":"%s","event":"post-tool","file":%s}\n' \
  "$TIMESTAMP" \
  "$(echo "$FILE" | jq -Rs '.')" \
  >> "$LOG_DIR/tool-results.jsonl"

exit 0
