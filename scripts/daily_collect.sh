#!/bin/bash
# Daily coding-plan data collection.
# - Rotates through scripts/queries.txt by day-seed to avoid re-asking the same set and
#   to stay under felo's 5 req/min rate limit.
# - Writes a summary into updates/YYYY-MM-DD.md and research/raw/<slug>-daily-<date>.json.
# - Commits and pushes to origin/main unless --no-push.
#
# Usage:
#   scripts/daily_collect.sh                # collect for today + push
#   scripts/daily_collect.sh --date 2026-09-30
#   scripts/daily_collect.sh --no-push
#   scripts/daily_collect.sh --dry-run

set -uo pipefail
cd "$(dirname "$0")/.."

# --- self-contained environment (launchd has no shell env/PATH/HOME) ---
export HOME="${HOME:-/Users/$(whoami 2>/dev/null || echo eugene)}"
# common node/npm locations (for npx)
for _p in "$HOME/.nvm/versions/node/"*/bin /opt/homebrew/bin /usr/local/bin /usr/bin /bin; do
  case ":$PATH:" in *":$_p:"*) : ;; *) PATH="$_p:$PATH" ;; esac
done
export PATH
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" >/dev/null 2>&1 || true

export NONINTERACTIVE=1
# persist caches under $HOME so npx works under launchd even without a shell env
export npm_config_cache="${npm_config_cache:-$HOME/.npm}"

TODAY="${BCP_DATE:-$(date -u +%Y-%m-%d)}"
PUSH="yes"
DRY="no"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --date) TODAY="$2"; shift 2;;
    --no-push) PUSH="no"; shift;;
    --dry-run) DRY="yes"; shift;;
    *) echo "unknown arg: $1" >&2; exit 2;;
  esac
done

export FELO_API_KEY="${FELO_API_KEY:-$(awk -F'"' '/^export FELO_API_KEY=/{print $2; exit}' "$HOME/.zshrc" 2>/dev/null)}"
if [ -z "$FELO_API_KEY" ]; then
  echo "FELO_API_KEY not found" >&2
  exit 3
fi

QUERY_FILE="scripts/queries.txt"
[ -f "$QUERY_FILE" ] || { echo "no $QUERY_FILE" >&2; exit 4; }

# --- parse query pool + dedupe by slug (no associative arrays: bash 3.2 on macOS) ---
SLUGS=()
QUERIES=()
SEEN=""
while IFS='|' read -r q slug rest; do
  [ -z "$q" ] && continue
  [ -n "$slug" ] || slug="$(echo "$q" | tr -cd 'a-zA-Z0-9' | head -c 40)"
  if [[ " $SEEN " != *" $slug "* ]]; then
    SEEN="$SEEN $slug"
    SLUGS+=("$slug")
    QUERIES+=("$q")
  fi
done < "$QUERY_FILE"
TOTAL=${#SLUGS[@]}
echo "query pool: $TOTAL entries"

# --- day-seeded rotation: pick a contiguous slice of up to 6/day ---
DAYNUM=$(( $(date -u -j -f "%Y-%m-%d" "$TODAY" +%s 2>/dev/null || echo 0) / 86400 ))
DAYNUM=$(( DAYNUM < 0 ? -DAYNUM : DAYNUM ))
SLICE=6
START=$(( DAYNUM % TOTAL ))
picks=()
for (( i=0; i<SLICE; i++ )); do
  idx=$(( (START + i) % TOTAL ))
  picks+=("$idx")
done

echo "=== $TODAY daily collection (day seed $DAYNUM, slice start #$START) ==="
if [ "$DRY" = "yes" ]; then
  for idx in "${picks[@]}"; do
    echo "  [dry] ${SLUGS[$idx]}: ${QUERIES[$idx]}"
  done
  exit 0
fi

# --- collect ---
TODAY_RAW="research/raw"
mkdir -p "$TODAY_RAW"
found_any=0

for idx in "${picks[@]}"; do
  slug="${SLUGS[$idx]}"
  q="${QUERIES[$idx]}"
  out="${TODAY_RAW}/${slug}-daily-${TODAY}.json"
  if [ -s "$out" ]; then
    echo "  ✓ already have $out (skip)"
    found_any=1
    continue
  fi
  echo "  ✎ $q"
  if timeout 150 npx -y @willh/felo-cli --json "$q" > "$out" 2>/tmp/daily_err_$$.txt; then
    echo "    saved $out ($(wc -c < "$out" | tr -d ' ') bytes)"
    found_any=1
  else
    echo "    ✗ failed: $(tail -1 /tmp/daily_err_$$.txt)"
    rm -f "$out"
  fi
  sleep 15   # felo 5/min limit (6 calls per run = ~90s, stays safe)
done

# --- [非LLM] official price snapshot (zero token cost) ---
if [ -x "scripts/fetch_official_prices.sh" ]; then
  echo ""
  echo "=== [非LLM] 官方定價快照 ==="
  scripts/fetch_official_prices.sh >/tmp/fetch_op_$$.txt 2>&1 || true
  cat /tmp/fetch_op_$$.txt
else
  echo "(no scripts/fetch_official_prices.sh — skip non-LLM price fetch)"
fi

# --- summary md ---
SUMMARY="updates/${TODAY}.md"
mkdir -p "$(dirname "$SUMMARY")"
{
  echo "## $TODAY 每日收集"
  echo ""
  echo "- 查詢池筆數：${TOTAL}；本次輪換 slice 起始 #${START}（最多 ${SLICE} 筆）"
  echo "- 收集日期（UTC）：$TODAY"
  echo ""
  echo "| slug | 狀態 | 大小 |"
  echo "|------|------|------|"
  for idx in "${picks[@]}"; do
    slug="${SLUGS[$idx]}"
    out="${TODAY_RAW}/${slug}-daily-${TODAY}.json"
    if [ -s "$out" ]; then
      # detect empty/no-result answers so bad queries get noticed
      ans="$(python3 -c "import json,sys
try:
  d=json.load(open('$out'))
  s=(d.get('data',d).get('answer') or d.get('answer') or '').strip()
  print('EMPTY' if (not s or len(s)<10 or '搜索结果为空' in s or '无法找到' in s) else 'OK')
except Exception: print('BAD')" 2>/dev/null)"
      if [ "$ans" = "OK" ]; then
        echo "| $slug | ✅ | $(wc -c < "$out" | tr -d ' ')B |"
      else
        echo "| $slug | ⚠️ 弱結果/$ans | $(wc -c < "$out" | tr -d ' ')B |"
      fi
    else
      echo "| $slug | ⚠️ 失敗/無內容 | — |"
    fi
  done
  echo ""
  echo "---"
  echo ""
} > "$SUMMARY"

if [ "$found_any" = "0" ]; then
  echo "No new data collected (all already present or failed)."
fi

echo "=== summary written: $SUMMARY ==="
cat "$SUMMARY"

# --- commit + push ---
if [ "$PUSH" = "yes" ]; then
  git add -A
  if git diff --cached --quiet; then
    echo "nothing to commit"
  else
    git commit -m "chore(updates): daily research $TODAY" || true
  fi
  git push origin main
else
  echo "(--no-push: not committing/pushing)"
fi
echo "=== done $TODAY ==="
