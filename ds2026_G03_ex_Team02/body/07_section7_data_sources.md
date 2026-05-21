# 第7节图表—数据溯源表

| 输出文件 | 图表/表格含义 | 原始官方数据路径 |
|----------|---------------|------------------|
| fig7_capm_beta_dual_benchmark.png | 双基准 Beta | data/stock/, data/index/sh000300.csv, sh000688.csv |
| fig7_capm_scatter_603986.png | CAPM 散点 OLS | stock_603986.csv, index_sh000300.csv |
| fig7_event_study_car_detailed.png | 事件研究 CAR | industry/semiconductor_index_ths.csv, stock/, ipo/*.csv |
| fig7_event_car_end.png | 事件窗末端 CAR | event_study_ar_car.csv |
| fig7_revenue_ols_forecast.png | 营收 OLS+CI | 上交所 2026-05-20 上会稿 → ipo/cxkj_financials.csv（年报+2026Q1 实际；2026–2027 为 OLS 外推） |
| fig7_profit_revenue_regression.png | 净利~营收 | 上交所 2026-05-20 上会稿 → ipo/cxkj_financials.csv（年报 2023–2025） |
| fig7_cxmt_mu_revenue_regression.png | 长鑫 vs 美光 | ipo/cxkj_financials.csv, finance/mu_annual_us.csv |
| fig1_cxkj_revenue_profit.png | 营收与归母净利 | ipo/cxkj_financials.csv（截至 2026-05-21） |
| fig7_peer_ps_regression.png | PS 对数回归 | finance/finance_ths_*.csv, data/stock/ |
| regression_capm_full.csv | CAPM 完整系数表 | 同上 |
| event_study_significance.csv | 事件研究 t 检验 | 同上 |

事件日字段：
- `cxkj_ipo_tutor.csv` → 备案日期 2025-07-07
- `cxkj_register.csv` → 受理日期 2025-12-30
