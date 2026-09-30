# Daily pipeline setup & troubleshooting

> 2026-09-30：**價格抓取改為非 LLM**。官方定價頁用 curl 直接抓（零 token），
> felo 僅保留給新聞/新方案分析（用使用者自己的 plan，可接受）。

Target repo: `/Users/eugene/cc/better-coding-plan` → `https://github.com/tboydar/better-coding-plan` (public)

## Components

| Piece | Path | Purpose |
|-------|------|---------|
| Skill | `~/.pi/agent/skills/better-coding-plan/SKILL.md` | Agent instructions for manual runs |
| Query pool | `scripts/queries.txt` | `query|slug` one per line, edited to add/remove topics |
| Collector | `scripts/daily_collect.sh` | daily run: official-price fetch + summary + commit + push |
| Non-LLM price | `scripts/fetch_official_prices.sh` | curl official pricing pages -> research/official-prices/ |
| Scheduler | `~/Library/LaunchAgents/com.eugene.better-coding-plan.plist` | runs collector every day 08:30 |
| Logs | `~/Library/Logs/better-coding-plan*.log` | stdout / stderr |

## Install / enable scheduler

```bash
launchctl unload ~/Library/LaunchAgents/com.eugene.better-coding-plan.plist 2>/dev/null
launchctl load   ~/Library/LaunchAgents/com.eugene.better-coding-plan.plist
launchctl list | grep better-coding      # should show the label
```

## Manual run

```bash
cd /Users/eugene/cc/better-coding-plan
./scripts/daily_collect.sh --dry-run              # preview today's query slice
./scripts/daily_collect.sh --no-push              # collect + summarize, no git push
./scripts/daily_collect.sh --date 2026-10-05      # any date (UTC)
./scripts/daily_collect.sh                        # full: collect + commit + push
```

The script is self-contained (launchd has no shell env): it resets `HOME`, prepends common
`node/npm` bin dirs, sources `nvm.sh`, and reads `FELO_API_KEY` from `~/.zshrc`.

## Query pool management

- Format: `natural language query|ascii-slug` (slug: `[a-zA-Z0-9_-]` only).
- Each day the script picks a 6-query contiguous slice starting at
  `epoch-days % pool_size`, so the pool is cycled through over time without repeats on the
  same topics, and stays within felo's **5 requests/min per API key** limit (sleeps 15s/call).
- Re-run safe: a `<slug>-daily-<date>.json` already present is skipped (idempotent per day).

## felo rate limiting

- **5/min per key**, **15/min per user**, **60/hour per user** → keep slices small (≤6).
- On `RATE_LIMITED` or empty-result answers, the collector marks them ⚠️ in the summary.
- `RATE_LIMITED` short strings (`Search results empty / 無法找到 ...`) mean the query wording
  should be improved — update `scripts/queries.txt` and re-run.

## Troubleshooting

- **Nothing pushed**: check `~/Library/Logs/better-coding-plan-error.log`; verify
  `git remote -v` (origin = `git@github.com:tboydar/better-coding-plan.git`) and that the
  SSH key works (`ssh -T git@github.com` prints `Hi tboydar!`).
- **Empty Pool**: `scripts/queries.txt` missing or all commented → add lines.
- **Wrong date slice**: dates are UTC; `--date` forces a specific day.
- **Commit identity**: repo-local `user.name`/`user.email` are set (`Dar`/`tboydar@gmail.com`).
