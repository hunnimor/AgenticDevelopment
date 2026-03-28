#!/usr/bin/env bash
# stop.sh — runs when the agent session finishes

LOG_DIR="$CLAUDE_PROJECT_DIR/.claude/logs"

# ── CHECK for unstaged changes ─────────────────────────────────────────────────
UNSTAGED=$(git -C "$CLAUDE_PROJECT_DIR" diff --name-only 2>/dev/null || true)
UNTRACKED=$(git -C "$CLAUDE_PROJECT_DIR" ls-files --others --exclude-standard 2>/dev/null || true)

if [ -n "$UNSTAGED" ] || [ -n "$UNTRACKED" ]; then
  echo ""
  echo "📝 You have uncommitted changes:"
  [ -n "$UNSTAGED" ] && echo "$UNSTAGED" | sed 's/^/  modified: /'
  [ -n "$UNTRACKED" ] && echo "$UNTRACKED" | sed 's/^/  untracked: /'
  echo "  → Run /commit to save your work."
fi

# ── COUNT modified files from log ─────────────────────────────────────────────
FILE_COUNT=0
if [ -f "$LOG_DIR/tool-results.jsonl" ]; then
  FILE_COUNT=$(jq -r '.file' "$LOG_DIR/tool-results.jsonl" 2>/dev/null | sort -u | wc -l | tr -d ' ')
fi

echo ""
echo "✅ Session complete. $FILE_COUNT files modified."

exit 0
