#!/bin/bash
# Search one query via felo-cli and save raw JSON to research/<slug>.json
# Usage: ./scripts/search.sh "<query>" <slug>
set -euo pipefail
cd "$(dirname "$0")/.."
export FELO_API_KEY="${FELO_API_KEY:-}"
if [ -z "$FELO_API_KEY" ]; then
  FELO_API_KEY="$(grep -o 'FELO_API_KEY="[^"]*"' ~/.zshrc | cut -d'"' -f2)"
  export FELO_API_KEY
fi
QUERY="$1"
SLUG="${2:-$(echo "$QUERY" | tr -cd 'a-zA-Z0-9' | head -c 40)}"
OUT="research/raw/${SLUG}.json"
mkdir -p research/raw
echo "▶ Searching: $QUERY"
timeout 150 npx -y @willh/felo-cli --json "$QUERY" > "$OUT" 2>/tmp/felo_err_$$.txt
RC=$?
if [ $RC -ne 0 ]; then
  echo "  ✗ FAILED (rc=$RC): $(tail -1 /tmp/felo_err_$$.txt)"
  rm -f "$OUT"
  exit $RC
fi
CH=$(( $(wc -c < "$OUT") ))
echo "  ✓ saved $OUT ($CH bytes)"
