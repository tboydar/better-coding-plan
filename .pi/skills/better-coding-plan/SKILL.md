---
name: better-coding-plan
description: >-
  Maintain the better-coding-plan research repo (tboydar/better-coding-plan). Use when the
  user asks to collect/update coding-plan pricing data, run the daily research collection,
  create/refresh country plan docs, compare AI coding subscriptions across countries, commit
  and push daily updates, or set up recurring collection. Covers felo web-search collection,
  updating docs/by-country, comparison tables, and the daily launchd commit+push pipeline.
---

# Better Coding Plan — daily research skill

This skill runs a recurring **web-search → summarize → commit → push** pipeline for the
[Tboydar/better-coding-plan](https://github.com/tboydar/better-coding-plan) public repo, which
tracks AI coding-plan prices/quota/value across countries (US, CN, JP, KR, IN, EU, TW, SG, AU, BR).

The live usage dashboard this project references: **https://dar-llm-usage.pages.dev/**

## Repo layout

Local checkout: `/Users/eugene/cc/better-coding-plan`

```
README.md                     # overview + highlights
docs/by-country/              # per-country plan details (us/cn/jp/kr/in/eu/tw/others.md)
docs/comparison/global.md     # cross-country value ranking
docs/analysis/recommendations.md  # value analysis + recommendations
research/raw/                 # raw felo JSON results (slug.json + slug.json.txt)
scripts/
  search.sh                   # single felo query -> research/raw/<slug>.json
  fetch_official_prices.sh    # NON-LLM: curl official pricing pages -> research/official-prices/
  run_searches.sh             # batch runner (throttled, retries)
  queries.txt                 # persistent query pool:  query|slug
  daily_collect.sh            # daily entrypoint: fetch_official_prices + optional slice (launchd)
updates/                      # dated changelog (updates/YYYY-MM-DD.md)
research/official-prices/     # NON-LLM official price snapshots (YYYY-MM-DD.json)
```

## Price collection strategy (LLM-free first)

**Official price data should be fetched with plain HTTP — NOT an LLM.** The user's
LLM budget is for the plans being monitored; price collection must not burn tokens.

1. `scripts/fetch_official_prices.sh` curls official pricing pages (GitHub, Cursor,
   Windsurf, Anthropic/Claude; unsupported for OpenAI 403 / Mistral / Google JS) and
   stores a normalized JSON snapshot at `research/official-prices/YYYY-MM-DD.json`.
   It diffs against the previous snapshot (SQLite JSON) and prints additions/removals.
2. Run it via `scripts/daily_collect.sh` (invoked by launchd), or manually:
   `./scripts/fetch_official_prices.sh`.
3. Only use felo where a human-readable comparison / analysis is needed (news, new
   plan discovery, cross-country value notes) — keep that to a handful of queries.

## Daily pipeline (what to do when asked to "run the daily collection")

1. Read the latest update log: `updates/` newest file — understand what was last collected.
2. Run `scripts/fetch_official_prices.sh` first (NON-LLM price snapshots + diff).
3. Optionally run `scripts/daily_collect.sh` for the felo news slice (throttled).
4. Summarize: append a new dated section `updates/YYYY-MM-DD.md` (or update README
   highlights if a meaningful finding appears — new plan, big price change, deal).
4. Update docs when a recurring plan changed materially:
   - price/quota changes → `docs/by-country/<country>.md`
   - new top-value plan → `docs/analysis/recommendations.md` + `README.md` highlights
   - cross-country comparison shifts → `docs/comparison/global.md`
5. Commit and push to `origin/main` (repo is public; keep diffs tidy, one logical commit):
   ```bash
   cd /Users/eugene/cc/better-coding-plan
   git add -A
   git commit -m "chore(updates): daily research YYYY-MM-DD"
   git push
   ```

## Weekly / ad-hoc research loop

For deeper research (new country, verify a price, compare a vendor):

1. Add queries to `scripts/queries.txt` (one per line, format `natural-language-query|slug`).
2. Run `./scripts/run_searches.sh scripts/queries.txt` (throttled, retriable).
3. Read raw answers from `research/raw/<slug>.json.txt` (ASCII extraction) or the JSON.
4. Synthesize into `docs/by-country/*.md` following the existing per-country template
   (summary table at top: price / quota / value notes; detailed sections; sources footer).
5. Flag high-value changes in README highlights and `updates/`.
6. Commit + push.

## Environment / credentials

- NON-LLM price fetch: plain `curl` against official pricing pages, no API key needed,
  no token cost. Supported: GitHub docs, GitHub, Cursor, Windsurf, Anthropic/Claude.
- Search tool (analysis only): `npx -y @willh/felo-cli --json "<query>"` — API key from
  `~/.zshrc` (`FELO_API_KEY="..."`; scripts auto-load it). Felo consumes the user's own
  plan (OK per user preference), but keep it minimal — price data lives in the curl path.
- Rate limit: felo **5/min per key, 15/min per user** — always throttle, retry on RATE_LIMITED.
- Git: SSH key for `git@github.com` works for `tboydar`; repo: `tboydar/better-coding-plan`.
- Daily schedule (launchd): `~/Library/LaunchAgents/com.eugene.better-coding-plan.plist`
  calls `scripts/daily_collect.sh` (see references/setup.md for install steps).

## References

- `references/setup.md` — launchd install/uninstall, query pool management,
  official-price fetch details, troubleshooting.
