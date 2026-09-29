#!/bin/bash
# Run several search queries with limited concurrency + retry
# Usage: ./scripts/run_searches.sh < queryfile (one query|slug per tab)
set -euo pipefail
cd "$(dirname "$0")/.."
export FELO_API_KEY="${FELO_API_KEY:-}"
if [ -z "$FELO_API_KEY" ]; then
  FELO_API_KEY="$(grep -o 'FELO_API_KEY="[^"]*"' ~/.zshrc | cut -d'"' -f2)"
  export FELO_API_KEY
fi
QUERY_FILE="${1:-}"
CONCURRENCY=2
if [ -n "$QUERY_FILE" ]; then
  COUNTER=0
  while IFS='|' read -r q slug rest; do
    [ -z "$q" ] && continue
    [ -n "$slug" ] || slug="$(echo "$q" | tr -cd 'a-zA-Z0-9' | head -c 40)"
    ./scripts/search.sh "$q" "$slug" &
    COUNTER=$((COUNTER+1))
    if [ $((COUNTER % CONCURRENCY)) -eq 0 ]; then wait; fi
  done < "$QUERY_FILE"
  wait
else
  # interactive mode: read queries from stdin
  while read -r line; do
    [ -z "$line" ] && continue
    echo "▶ $line"
    ./scripts/search.sh "$line"
  done
fi
echo "=== all done ==="
