# better-coding-plan

> 持續研究全球各地 **AI coding plan（編程訂閱方案）** 的性價比、額度、限制與跨國差異，找出「更划算」的訂閱組合。

**Repo**: `tboydar/better-coding-plan`（public）
**用量監控 dashboard**: https://dar-llm-usage.pages.dev/

## 這專案在幹嘛

使用者目前每個月在 AI 訂閱上花費粗估 **$700–900**，dashboard 追蹤了 14+ 個服務。本專案透過持續的網路搜尋，把各國（美國/中國/日本/韓國/印度/歐洲/台灣/東南亞/澳洲/巴西）的 coding plan 價格、額度、模型品質整理出來，找出「同樣的錢能買到更多」的方案，並對照實際用量給出最佳化建議。

## 推薦重點（2026-09）

| 類型 | 首選 | 理由 |
|------|------|------|
| 🏆 全球高 CP 入門 | **OpenCode Go $10** | 6x API 值、18+ 模型 |
| 🏆 綜合最划算 | **Mistral Le Chat Pro $14.99** | 6x 額度 + $15 API 積分 |
| 🏆 印度特價 | **Cursor Start ₹649** | 全球唯一印度特價 |
| 🏆 重度最划算 | **Cursor Ultra $200 / Copilot Max $100** | 2x 值 + 無限補全 |
| 🏆 DIY 最省 | **DeepSeek + Cline/Aider** | 按量極低單價 |
| ⚠️ 已失去優勢 | **GLM Coding Plan** | 2026-08 大漲 261% |

詳細建議見 [docs/analysis/recommendations.md](docs/analysis/recommendations.md)

## 📁 結構

```
better-coding-plan/
├── README.md                 # 總覽（本檔）
├── docs/
│   ├── by-country/           # 各國方案詳情（us/cn/jp/kr/in/eu/tw/others）
│   ├── comparison/           # 跨國比較總表
│   └── analysis/             # 性價比分析與實際建議
├── research/
│   └── raw/                  # 原始搜尋結果（felo JSON + txt）
├── scripts/
│   ├── search.sh             # 單筆 felo 搜尋
│   └── run_searches.sh       # 批次搜尋（節流 + retry 已內建）
└── updates/                  # 更新紀錄（log）
```

## 🔄 如何持續更新

1. **批次重搜**：編輯 `scripts/queries.txt`（`查詢|slug` 每行一筆），執行
   ```
   ./scripts/run_searches.sh scripts/queries.txt
   ```
   內建節流（felo 限 5/min per key）與 retry。
2. **單筆查詢**：`./scripts/search.sh "要搜的話" output-slug`
3. **整理成文件**：把新結果整理進對應 `docs/by-country/*.md` 與 `docs/comparison/global.md`
4. **記錄**：在 `updates/` 新增當日 log，更新 README 重點表
5. **commit & push** → GitHub public repo 自動曝光

> felo-cli 透過 `~/.zshrc` 的 `FELO_API_KEY` 驗證；本環境已設定。

## 附註

- 所有價格隨時變動，購買前請上官網確認。
- 中國方案需人民幣支付 + 個人合規考量；跨國訂閱可能加稅/手續費。
- 本文件內容由 felo 網路搜尋彙整，部分來源為二手報導，價格以官方為準。
