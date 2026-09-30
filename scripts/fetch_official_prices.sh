#!/bin/bash
# fetch_official_prices.sh — 非 LLM 官方定價快照（零 token 成本）
# 直接抓取各家官方定價頁，抽取價格快照存 JSON，並與前一天 diff。
# felo 完全不參與此步驟。
#
# 支援的官方頁：
#   GitHub Copilot docs, GitHub pricing, Cursor, Windsurf, Anthropic, Claude
#   (OpenAI/Codex/Mistral 被 Cloudflare/JS 擋，標記為 unsupported)
#
# Output: research/official-prices/YYYY-MM-DD.json
#   {"date":..., "sites":{<site>:{url,http_code,fetched_at,ok,prices:[{value,ctx}]}}}

set -uo pipefail
cd "$(dirname "$0")/.." || exit 1

DATE="${BCP_DATE:-$(date -u +%Y-%m-%d)}"
OUTDIR="research/official-prices"
mkdir -p "$OUTDIR"
OUT="$OUTDIR/$DATE.json"
UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36"
TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

# site|url
SITES=$(cat <<'EOF'
github-copilot|https://docs.github.com/en/copilot/get-started/plans
github-pricing|https://github.com/pricing
cursor|https://cursor.com/pricing
windsurf|https://windsurf.com/pricing
anthropic|https://www.anthropic.com/pricing
claude|https://claude.com/pricing
EOF
)

python3 - "$OUT" "$UA" <<'PYEOF' &
import json, re, html, subprocess, sys, os
out, ua = sys.argv[1], sys.argv[2]

SITES = """github-copilot|https://docs.github.com/en/copilot/get-started/plans
github-pricing|https://github.com/pricing
cursor|https://cursor.com/pricing
windsurf|https://windsurf.com/pricing
anthropic|https://www.anthropic.com/pricing
claude|https://claude.com/pricing""".strip().splitlines()

def extract_prices(text, min_v=1):
    """抽 '$N' / '$N.M' / 'N USD' 及前後 ~40 字上下文；去重保留前 25 筆。"""
    prices = []
    pat = re.compile(r'(\$\s?\d+(?:\.\d+)?|\b\d+\.?\d*\s?USD\b)')
    for m in pat.finditer(text):
        s = max(0, m.start()-40); e = min(len(text), m.end()+40)
        val = m.group(1).replace(' ', '')
        num = float(re.sub(r'[^0-9.]', '', val))
        if num < min_v: continue
        ctx = re.sub(r'\s+', ' ', text[s:e]).strip()
        prices.append({"value": val, "ctx": ctx})
    # dedupe by value+ctx head
    seen, dd = set(), []
    for p in prices:
        k = (p["value"], p["ctx"][:60])
        if k in seen: continue
        seen.add(k); dd.append(p)
        if len(dd) >= 25: break
    return dd

result = {"date": os.path.basename(out)[:-5], "sites": {}}
for line in SITES:
    site, url = line.split("|", 1)
    try:
        r = subprocess.run(
            ["curl", "-s", "-L", "-A", ua, "--max-time", "18", url],
            capture_output=True, text=True, timeout=25)
        body = r.stdout
        code = "ok"
        if not body or len(body) < 300:
            code = "empty"
        text = re.sub(r'<script.*?</script>', '', body, flags=re.S)
        text = re.sub(r'<style.*?</style>', '', text, flags=re.S)
        text = re.sub(r'<[^>]+>', ' ', text)
        text = html.unescape(text)
        text = re.sub(r'\s+', ' ', text)
        prices = extract_prices(text)
        result["sites"][site] = {
            "url": url, "http_code": "ok", "ok": code == "ok" and len(prices) > 0,
            "prices": prices, "text_len": len(text)}
    except Exception as e:
        result["sites"][site] = {"url": url, "http_code": "err", "ok": False,
                                 "prices": [], "error": str(e)}

json.dump(result, open(out, "w"), ensure_ascii=False, indent=1)
PYEOF
python_pid=$!

# 等 python 完成（最多 60s）
for _ in $(seq 1 60); do
  kill -0 $python_pid 2>/dev/null || break
  sleep 1
done
wait $python_pid 2>/dev/null

if [ ! -s "$OUT" ]; then
  echo "✗ 抓取輸出失敗" >&2; exit 1
fi

echo "=== $DATE 官方定價快照 ==="
python3 - "$OUT" <<'PYEOF'
import json,sys
d=json.load(open(sys.argv[1]))
for site,info in d["sites"].items():
    n=len(info["prices"])
    vals=", ".join(p["value"] for p in info["prices"][:8])
    print(f"  {site:16} {'OK' if info['ok'] else '--'}  ({n} prices)  {vals}")
PYEOF

# --- diff vs previous snapshot ---
PREV=""
for f in $(ls "$OUTDIR/"*.json 2>/dev/null | sort); do
  [ "$f" = "$OUT" ] && break
  PREV="$f"
done
DIFF_LINES=""
if [ -n "$PREV" ]; then
  DIFF_LINES=$(python3 - "$PREV" "$OUT" <<'PYEOF'
import json,sys,os
prev,out=sys.argv[1],sys.argv[2]
a=json.load(open(prev)); b=json.load(open(out))
changed=[]
for site, info in b["sites"].items():
    av={p["value"] for p in a["sites"].get(site,{}).get("prices",[])}
    bv={p["value"] for p in info["prices"]}
    added= sorted(bv-av); removed=sorted(av-bv)
    if added or removed:
        changed.append(f"{site}: +{added or '-'} / -{removed or '-'}")
print(" | ".join(changed) if changed else "no change")
PYEOF
)
  if [ "$DIFF_LINES" != "no change" ] && [ -n "$DIFF_LINES" ]; then
    echo "⚠️ 價格變動偵測: $DIFF_LINES"
    echo ""
    echo "  > 相較前一天 $PREV"
  else
    echo "（與前一天相比無價格變動）"
  fi
  DIFF_LINES=$(echo "$DIFF_LINES" | sed -n '1p')
fi

echo ""
echo "saved: $OUT"
exit 0
