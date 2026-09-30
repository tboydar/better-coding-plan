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
  run_searches.sh             # batch runner (throttled, retries)
  queries.txt                 # persistent query pool:  query|slug
  daily_collect.sh            # daily collection entrypoint (used by launchd)
updates/                      # dated changelog (updates/YYYY-MM-DD.md)
```

## Daily pipeline (what to do when asked to "run the daily collection")

1. Read the latest update log: `updates/` newest file — understand what was last collected.
2. Run `scripts/daily_collect.sh` from the repo root (or use felo manually, see below).
   - It batches a slice of `scripts/queries.txt`, throttles to respect felo's
     **5 requests/min per API key** rate limit, and saves results to `research/raw/`.
3. Summarize: append a new dated section `updates/YYYY-MM-DD.md` (or update README highlights
   if a meaningful finding appears — new plan, big price change, cross-country deal).
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

- Search tool: `npx -y @willh/felo-cli --json "<query>"` — API key from `~/.zshrc`
  (`FELO_API_KEY="..."`; scripts auto-load it).
- Rate limit: **5/min per key, 15/min per user** — always throttle, retry on RATE_LIMITED.
- Git: SSH key for `git@github.com` works for `tboydar`; repo: `tboydar/better-coding-plan`.
- Daily schedule (launchd): `~/Library/LaunchAgents/com.eugene.better-coding-plan.plist`
  calls `scripts/daily_collect.sh` (see references/setup.md for install steps).

## References

- `references/setup.md` — launchd install/uninstall, query pool management, troubleshooting.
