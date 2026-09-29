# 中國（CN¥）方案

> 中國市場特色：人民幣計價、微信/支付寶付款、免代理直連、多模型 gateway 訂閱制。2026 年普遍經歷一波漲價潮，CP 值已不如 2025。

## 摘要排行榜

| 方案 | 月費 | 核心內容 | 性價比心得 |
|------|------|----------|-----------|
| **火山方舟 Coding Plan（豆包）** | ¥9.9 首月（之後 ~¥40） | 多模型（GLM-5.3/DeepSeek-V4/豆包/Kimi-K3） | 中國最便宜入門 |
| **阿里百煉 Coding Plan Pro** | ¥200（首月 ¥39.9） | 90,000 req/月、5h 6,000、週 45,000 | 老牌量大 |
| **DeepSeek API（按量）** | 幾乎免費起 | in ¥1/M、out ¥4/M（閒時） | 想花最少錢的首選 |
| **Kimi Coding Plan** | 舊¥49/99、新體系較貴 | 週額 7 天刷新、5h 頻率窗 | 模型品質好，價格漲 |
| **MiniMax Token Plan（中國）** | Plus ¥49、Max ¥119、Ultra ¥490 | 5h/週雙窗 + 多模態共用 | 中價位 |
| **GLM Coding Plan** | Lite ¥118、Pro ¥538、Max ¥1078 | 積分制 5h+週雙窗 | ⚠️ 2026-08 大漲 141–261%，CP 大降 |
| **硅基流動 SiliconFlow** | 按量 / 免費額度 | 200+ 模型，免費 16 模型 | DIY 靈活極省 |
| **騰訊混元** | 按量 Hy4 | in ¥6/M、out ¥18/M | 中規中矩 |

## 詳細方案

### GLM Coding Plan（智譜）⚠️ 2026-08 大漲
- 2026-02 調漲一次、**2026-07-31 再大漲**：
  - **Lite ¥118/mo**（原 ¥49，+141%）
  - **Pro ¥538/mo**（原 ¥149，+261%）
  - **Max ¥1078/mo**（原 ¥469，+130%）
- 計費改**積分制**（不再以 token 數）：5h + 週雙上限
  - Lite：5h 2,000 分 / 週 1 萬分
  - Pro：5h 1.2 萬 / 週 6 萬
  - Max：5h 2.8 萬 / 週 14 萬
- 抵扣係數：GLM-5.2 輸入 6.9、緩存輸入 1.7、輸出 24
- 高峰規則：平日 14–18 高峰時段全額扣；其餘時段僅 50% 扣（高峰實際可用約 1/3）
- 舊版曾極划算（Lite ¥20≈Claude Pro 的 3 倍 prompts），現在漲到「為何不直接買 GPT/Claude」的質疑
- 優勢仍在：人民幣支付、國內直連、採購/合規方便

### Kimi（月之暗面）Coding Plan
- 舊體系：**¥49/mo、¥99/mo**；年付 Andante ¥468
- 2026 新會員體系（檔位名：Andante / Moderato / Allegretto / **Allegro** / Vivace）價格↑
  - Allegro：20 倍 Kimi Code、約 150 agents/月、50 次 agent 集群
  - Vivace：60 倍 Kimi Code、約 360 agents/月、120 次集群
  - 最低組合（Go+Starter）年付 ¥1536（門檻大漲）
- 額度機制：**訂閱日起每 7 天刷新**、5h 滾動頻率窗；所有裝置/API key 共用；與 Kimi 會員共用池（網站部署、深度研究、PPT 都吃同一池）
- 額度 ≈ Claude Pro 的 2 倍用量（舊版基準）
- 模型：Kimi K2.5（多模態）→ K2.7Code → **K3（1M context，2026 上線）**
- 使用者目前方案：Allegro

### MiniMax（Token Plan）
- 2026 從 Coding Plan 升級為 **Token Plan**（含多模態：文字/圖像/語音/音樂，全共用池）
- 中國區：**Plus ¥49** / **Max ¥119** / **Ultra ¥490**（年付更便宜）
- 國際區：Plus $22（年 $18.3）/ Max $55（年 $45.8）/ Ultra $132（年 $110）
- 額度：5h 滾動 + 週窗；Plus 5h 約 4,500 prompts、Max 15,000、Ultra 45,000
- ⚠️ 多模態與編碼共用配額 = 消耗很快（有人稱「$20 17億 token」是陷阱）
- 首月優惠：國際首購 80% off（$2）；中國 Starter ¥29/首月 ¥9.9

### 阿里雲百煉（Qwen / 通義千問）
- **Coding Plan Pro ¥200/mo**（首月 ¥39.9；Lite ¥40 已停售）：90,000 req/月、5h 6,000、週 45,000
- 支援多模型：Qwen、Kimi、GLM、MiniMax；可接 Cursor/Qwen Code/Cline/Claude Code
- 2026 升級 **百煉 Token Plan**（個人版）：Lite ¥39（11,500 credits）/ Standard ¥139（45,000）/ Pro ¥499（180,000），超量 88 折 + 12 項 Harness 權益
- 僅限互動式編碼，禁後端自動化調用

### 火山引擎豆包（Doubao / 方舟）
- **Coding Plan：首月 ¥9.9**（促銷），之後標準 ~$5.5（≈¥40）
- 多模型：GLM-5.3、DeepSeek-V4、Doubao-Seed-2.1-turbo、Kimi-K3
- 按量：Doubao-Seed-2.1-pro **¥0.8/M**（公開價）；每日 **500 萬 tokens 免費額度**（常態、不限老新）
- 官方宣稱綜合成本比業界平均低 62.7%
- C 端專業版 ¥399/年（無限用 Seed-2.1-pro，僅限 C 端 app/web）

### DeepSeek（API 按量）⭐ 最省
- **V4-Flash**（閒時）：in ¥1/M、out ¥4/M（$0.15/$0.6）；高峰期 ×2
- **V4-Pro**（閒時）：in ¥4.5/M、out ¥13.5/M（$0.66/$1.98）；高峰期 ×2
- 高峰時段：平日 9–12、14–18（其他含週末/假日算閒時）
- 緩存命中：Flash in ¥0.02/M（閒時）；Pro in ¥0.15/M
- 預設支援思考模式（推理）；推理成本遠低於 OpenAI（R1 比 o1 便宜 25x+）
- 無訂閱，純按量 → 適合當 backup / BYOK 工具後端

### 硅基流動 SiliconFlow
- 200+ 模型統一 API；**免費額度 16 個模型**（Qwen3-8B、DeepSeek-R1-Distill-Qwen-7B 等）
- 按量極低；支援分 model routing（Plan 用便宜模型、Act 用強模型）省成本
- 適合與 Cline/Continue 等 BYOK 工具搭配

### 騰訊混元 / 其他
- **Hunyuan Hy4-preview**：in ¥6/M、out ¥18/M，1024K context
- **Yi / 百川/01.AI**：見 research/raw/cn-yi-baichuan.json
- 通常無專屬 coding plan，以 API 按量為主

---

_資料來源：Felo search raw（research/raw/cn-*.json）、智譜官方 docs、知乎/CSDN/什麼值得買整理_
_更新：2026-09-29_
