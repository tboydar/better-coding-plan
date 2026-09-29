# 美國 / 國際主流方案（US $）

> 所有價格以美元計，未含稅。2026 年市場基準：個人 coding plan 主流落在 **$10–$20/月**，重度落在 **$100–$200/月**。

## 摘要排行榜（個人方案，性價比由高至低）

| 方案 | 月費 | 核心內容 | 性價比心得 |
|------|------|----------|-----------|
| **OpenCode Go** | $10（首月$5） | 5h $12 / 週 $30 / 月 $60 API 值（約 6 倍報酬率），18+ 模型 | 目前夜價格王 |
| **Command Code GOAT** | $10 | 70 credits（約 7 倍價值），30+ 模型 | 次便宜王 |
| **GitHub Copilot Pro** | $10 | 1,500 credits（$15 值）+ 無限 inline 補全 | 入門首選 |
| **GitHub Copilot Pro+** | $39 | 7,000 credits（$70 值） | 中度用戶升級 |
| **Cursor Pro** | $20（年$16） | $20 credits + 無限 Tab 補全 | 日常 IDE 主力 |
| **ChatGPT Plus** | $20 | Codex 有限 + 全套 GPT | 綁 ChatGPT 生態 |
| **Claude Pro** | $20（年$17） | 5h 約 40–45 msgs | 聊天+GDBG |
| **Mistral Le Chat Pro** | $14.99 | 6x 額度 + $15 API 積分 | 歐洲最便宜，被低估 |
| **Windsurf Pro** | $20 | 日/週配額制 + 無限 Tab | 2026-03 改版 |
| **Muse Code Everyday** | $5 | 5h 約 10–50 reqs | Meta 新血，超低價入門 |
| **Google AI Pro** | $19.99 | 5TB + 4x Gemini + Antigravity | 加值最多 |
| **Claude Max 5x** | $100 | 5h 約 225 msgs | 重度首選 |
| **ChatGPT Pro 20x** | $200 | Codex 週額 20x | 重度首選 |
| **Cursor Ultra** | $200 | 約 $400 API 值 | 算力最高 |
| **Claude Max 20x** | $200 | 5h 約 900 msgs | 極重度 |

## 詳細方案

### GitHub Copilot（2026-06 起改用量計費）
- 計費單位：**GitHub AI Credits**（1 credit ≈ $0.01）
- **Pro $10/mo**：基礎 1,000 + flex 500 = **1,500 credits（$15 值）**
- **Pro+ $39/mo**：基礎 3,900 + flex 3,100 = **7,000 credits（$70 值）**
- **Max $100/mo**：基礎 10,000 + flex 10,000 = **20,000 credits（$200 值）**
- **Business $19/user**、**Enterprise $39/user**
- 超額：$0.01/credit 按需加購
- 內聯 code completion / next-edit 建議：**所有付費版無限且免費**（最棒的部分）
- 消耗 credits 的：chat、agent mode、code review、Copilot CLI
- 2026-06-16 起重新開放 Student/Pro/Pro+/Max 註冊

### ChatGPT / Codex（OpenAI）
- **Plus $20/mo**：Codex 有限（5h 約 10–100 條 Sora Sol 消息，週額未公開，實際偏緊）
- **Pro 5x $100/mo**
- **Pro 20x $200/mo**：Codex 週額 20x；每週約 200 條 GPT-6 Pro 聊天消息；GPT-5.6 Sol Pro 每天 170 條
- **重置券**：Pro 每月會發 2–3 張 full reset credits（用盡可全額恢復）
- 實際經驗：即使 20x，密集開發仍可能在月底耗盡週額，OpenAI 不回退

### Claude（Anthropic）
- **Pro $20/mo**（年付 $200 = $17/mo）：5h 約 40–45 msgs
- **Max 5x $100/mo**：5h 約 225 msgs（5 倍）
- **Max 20x $200/mo**：5h 約 900 msgs（20 倍）
- **Team $30/seat/mo**（年付 $25），最低 5 seats = $125/mo
- 5h 滾動視窗 + 週限額（固定時間重置）；Claude Code 與 chat 共用同一池
- France/歐元區為在地定價（Pro €18、Max5x €85、Max20x €170）

### Cursor
- **Hobby $0**：有限 Tab + 有限 agent requests（2025-05 時約 500 req/月）
- **Pro $20/mo**（年付 $16）：$20 credits 池 + 無限 Tab
- **Pro+ $60/mo**：約 3 倍 Pro 額度
- **Ultra $200/mo**：約 $400 credits（20 倍 Pro）
- **Teams Standard $40/user（年$32）**、Premium $120/user
- **印度限定 Start 版：₹649/mo（含稅）** ← 跨區划算點
- 計費模式：credits 池分「Cursor 自家模型」與「第三方模型（Claude/GPT/Gemini）」；用完按標準 API 費率 on-demand
- 重度用戶注意：實際月費可能 >> 標價（有使用者每月 $200–$1,400）

### Windsurf
- **Pro $20/mo**（2026-03 從 $15 漲價）：日/週配額制（取代月 credits）
- **Max $200/mo**、Teams $40/user
- Tab 補全免費無限
- 自家 SWE 模型（SWE-1 Lite）按 prompt 定額或 0 credit；第三方模型（Claude/GPT/Gemini）按 token 計費 + 20% 加成（Claude Sonnet 約 in $3.60/M、out $18/M）

### Sourcegraph Amp（→ Amp Frontier Corp，2025-12 拆分）
- 免費層**已暫停**（2026 中）
- **Amp Smart**：按量計費、無訂閱費，模型列表價無加價
- 2026-07 測試訂閱：
  - **$20/mo**：750h 小型 Orb + $20 agent 額度（僅 low/medium 模式）
  - **Gigawatt $200/mo**：1000h 大型 Orb + $200（全模式）
- Orb = 遠端 VM（可跑代理、分享 preview）；有四種執行模式 + 本機/Orb/命名 runner 放置
- 自排程 agent 無喚醒頻率上限 → 要設預算監控
- 使用者目前以 ChatGPT Pro 訂閱作為 model routing 支付來源

### OpenCode Go ⭐ 高 CP
- **$10/mo（首月 $5）**：月含 5h $12 / 週 $30 / 月 $60 的 API 值（約 6 倍價值）
- 18+ 模型：GPT 5.6 Luna、Grok 4.5、Kimi K3、GLM-5.2、Qwen3.8 Max、DeepSeek V4、MiniMax M3
- 單一 API key 全模型；OpenAI-compatible 工具都可用（Claude Code、Cline…）
- 限制：5h $12 可能幾天用完；模型以中國開源為主；beta
- 注意：GPT 5.6 Luna、Grok 4.5 log 保留 30 天

### Devin（Cognition）
- 官方定價未在搜尋中揭露；使用者目前為 **Pro 方案**（有 Daily / Weekly 兩視窗）
- 建議直接上官網查最新價（agent 型，貴）

### Command Code
- **Go $1/mo** → $10 credits
- **GOAT $10/mo** → **70 credits（約 7 倍價值）**，30+ open/closed models ⭐
- **Pro $20/mo** → $80 credits
- **Max 10x $100/mo** → $150、**Max 20x $200/mo** → $300
- credits 每月重置；新模型先 2 倍價值再談判
- 注意：宣稱價值 vs 實際（某些模型僅 2 倍價值）

### ArliAI
- Core $15、Plus $20、Pro $30/mo（無限 tokens）、Max $160/mo
- 統一模型閘道、月費計價（官方搜尋資訊有出入，以官網為準）

### Muse Code（Meta）
- **Everyday $5/mo**：5h 約 10–50 reqs、Muse Spark 1.2
- **High Usage $15/mo**：3 倍 Everyday
- **Power $50/mo**：10 倍 Everyday、早期功能
- API 按量：in $1.25/M、out $4.25/M；**Contributor 層 in $0.10/M、out $0.20/M**（用資料換價，激便��但會訓練你的 code）
- 與 Meta Muse（消費級）是不同產品

### Mistral Le Chat Pro（歐洲，但國際可用）
- **$14.99/mo**：免費版 6 倍額度、5 倍搜尋、15GB 庫、Vibe coding agent（CLI/IDE/web）
- **含每月 $15 API 積分**（可測 Studio 模型）→ 實際價值最高
- Team $24.99/user（年 $19.99）；學生 $5.99
- 法國 Free Mobile 用戶曾送 12 個月免費

### Google AI / Gemini
- **Plus $4.99/mo**：400GB、2x 額度
- **Pro $19.99/mo**：5TB、4x、Pro 模型、1M context、**每月 $10 GCP credits**、YouTube Premium Lite
- **Ultra 5x $99.99/mo**：20TB、5x、$40 GCP credits
- **Ultra 20x $199.99/mo**（2026 I/O 從 $250 降）：30TB、20x、$100 GCP credits
- **Gemini Code Assist Standard $22.80/user（年 $19）**
- 對 coding：Pro 以上含 **Antigravity / Jules / AI Studio 使用量上限**

### Qodo / Phind / 開源免費
- **Phind Pro $20/mo**：每日 500+ 查詢（Phind-70B + GPT-4）
- **Qodo**：見 research/raw/us-qodo.json
- **Aider**：開源免費（terminal AI pair programmer，BYOK）
- **Continue.dev**：開源免費 IDE 擴充（BYOK）
- **Roo Code / Cline**：開源免費 VS Code 擴充（BYOK）
- **Tabby / Cody**：開源自架 coding assistant（BYOK）

---

_資料來源：GitHub官方文件、Tech Insider、Cursor/其他官網、Felo search raw（見 research/raw/us-*.json）_
_更新：2026-09-29_
