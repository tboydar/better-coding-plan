# 性價比分析與建議（基於 dar-llm-usage 實際訂閱）

> 這份分析對照使用者在 **https://dar-llm-usage.pages.dev/** 監測中的 14+ 服務訂閱，逐項檢視「現在付的錢值不值」，並給出跨國搜索後的最佳化建議。

## 使用者目前訂閱一覽（dashboard 追蹤中）

| 服務 | 目前方案 | 月費(估) | dashboard 現況 |
|------|----------|----------|----------------|
| Claude Max / Team | Max + Team(公司) | $100 + (公司) | 平常 70–100% 額度 |
| GitHub Copilot | Pro+ | $39 | 已用 99%,剩 79 額度(將近滿) |
| ChatGPT / Codex | Pro | $200 | 週額用 67%,剩 33% |
| Z.ai GLM | （訂閱已過期/隱藏） | — | 2026-09-23 隱藏 |
| Kimi | Allegro | (新體系較貴) | 週額 59% |
| Google Antigravity | Gemini AI Pro | $19.99 | 5h 滿 100%、週 81% |
| OpenCode Go | Go | $10 | — |
| Ollama | Pro | $? | — |
| Grok | SuperGrok Heavy | 較貴 | 週額 17% |
| Cursor | Ultra | $200 | 用量低(2%) |
| Devin | Pro | 貴 | 未用 |
| Muse | Everyday/High | $5–15 | — |
| Amp | Amp Smart/訂閱 | 視用量 | — |
| ArliAI | PRO | $30 | — |
| Command Code | GOAT | $10 | 5h 0%、週 0%、credits 48% |

## 重點觀察

1. **Copilot Pro+ 已用 99%**：快撞牆（7,000 credits），但 dashboard 顯示 remaining 79 → 是兌換後的額度。若常滿，**升級 Copilot Max $100（20,000 credits）或改把重度工作分流到其他還沒用滿的方案**。

2. **ChatGPT Pro $200 週額 33%，且有 3 張重置券**：這是最貴的單一訂閱之一。若常常每週用到剩 33%，值得；若常剩很多，可考慮降到 **Pro 5x $100** 或 **ChatGPT Plus $20** 並搭配其他便宜方案填補缺量。

3. **Kimi Allegro** 週額 59%：中等使用。在 2026 漲價後，Kimi 的新會員體系價格較高；可評估是否以 **阿里百煉/火山方舟**（中國更便宜的多模型方案）取代或補位。

4. **Cursor Ultra $200 只用 2%**：明顯浪費。若實際用量真的那麼低，**降到 Cursor Pro $20 或 Pro+ $60** 可省 $140–180/月。dashboard 資料支援此結論。

5. **Devin（未使用）、Muse（低用量）、Amp（按量）**：可考慮暫停/降級以省錢，把預算移到最常撞牆的方案（Copilot/Codex）。

## 跨國搜索後的最佳化建議（依節省金額排序）

### 🥇 立即可做（省錢多、風險低）
1. **Cursor Ultra $200 → Pro $20 或 Pro+ $60**
   - 依據：dashboard 顯示 Cursor 用量 2%，Ultra 的 $400 池根本��不到
   - 月省 **$140–180**

2. **評估 Copilot：Pro+ $39 → Copilot Max $100 或適度分流**
   - 若常滿額（99%），Max 給 20,000 credits（2.9 倍）比 Pro+ 7,000 划算
   - 或把部分重型任務改用 **OpenCode Go $10**（6x 值）承載

3. **ChatGPT Pro：視週額剩餘決定留或降**
   - 每週都用到 33% 以下（快滿）→ 保持 $200 + 用重置券
   - 若時常剩 >50% → 降 Pro 5x $100，結合 Cursor Pro 分流

### 🥈 值得試（CP 高）
4. **新增 OpenCode Go $10**：6x API 值、18+ 模型，接 Claude Code/Cline 當「逃生艙」或日常主力，成本極低
5. **新增 Mistral Le Chat Pro $14.99**：歐洲便宜王，含 $15 API 積分，性價比 Top 3（若工作負載適合）
6. **Muse Everyday $5 / Command GOAT $10**：低價補位，避免主力撞牆時無處可用

### 🥉 中國方案精算（若可接受人民幣支付+合規）
7. **阿里百煉 Pro ¥200（$28）**：90,000 req/月，比很多 $20–50 方案量大，且支援多模型（Qwen/Kimi/GLM），可當 Cline/Claude Code 的 BYOK 後端
8. **火山方舟首月 ¥9.9 / GLM Pro**：入門極便宜；但 **GLM 2026-08 大漲 261%（Pro ¥538）** 後 CP 已輸國際方案，不建議新購 GLM

## 每月總額試算（估計現況）

| 項目 | 方案 | 約月費 |
|------|------|--------|
| Claude Max + Team | $100 + 公司 | $100+ |
| ChatGPT Pro | $200 | $200 |
| Copilot Pro+ | $39 | $39 |
| Cursor Ultra | $200 | $200 |
| Kimi Allegro | ~¥200+ | ~$28+ |
| Google AI Pro | $19.99 | $20 |
| OpenCode Go | $10 | $10 |
| Grok SuperGrok | 較貴 | $30–60? |
| Devin/Muse/Amp/ArliAI/Command | 視方案 | $10–60 |
| **合計（粗略）** | | **$700–900/月** |

> ⚠️ 個人每月花 $700–900 在 AI 訂閱上，屬極重度。透過上述建議（尤其 Cursor 降級、Copilot 分流）保守可省 **$150–250/月**，且不損失可用額度。

## 模型品質 vs 價格（最強模型參考）

- **頂尖編碼**（SWE-bench）：Claude（Max）、GPT-5.x/6.x（Codex Pro）、Gemini 3.1 Pro（Antigravity）、Kimi K3、GLM-5.x
- **性價比優**：深度推理 DeepSeek V4、多模型 OpenCode/Command、日本 Sakana Fugu（聲稱超 GPT-5.5）
- 品質/價格平衡最佳單一選：**ChatGPT Plus $20**（Codex 品質高 + 全套 GPT）
- 純 API 最省：**DeepSeek V4**（$0.15/M in 起）

## 結論

1. 你已經「重度包了很多方案」，多數夠用，但**有明顯浪費**（Cursor Ultra 只 2%、Devin/Muse 閒置）。
2. **立刻降級 Cursor、評估 ChatGPT Pro 檔位**是最大的節省點。
3. **用 $10 級的 OpenCode/Command/Muse 當分流**，避免唯一主力（Copilot/Codex）撞牆時卡住。
4. 中國方案中，**百煉/火山仍是便宜大碗**，但 **GLM 已漲到失去優勢**。
5. 新方案持續追蹤：Sakana Fugu（日本）、Mistral Le Chat Pro（歐洲）、Cursor India Start（跨區）都是值得留意的新蛋。

---

_本檔案隨 research/ 更新；價格隨時變動，購買前請上官網確認_
_更新：2026-09-29_
