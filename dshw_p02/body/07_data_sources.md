# 图表与数据溯源

## 原始数据来源

| 数据类型 | API / 来源 | 本地路径 |
|:---|:---|:---|
| A 股日行情 | `akshare.stock_zh_a_hist()`（后复权） | `data/stock/stock_{code}.csv` |
| 沪深 300 / 创业板指 | `akshare.stock_zh_index_daily_em()` | `data/index/index_{code}.csv` |
| CPI | `akshare.macro_china_cpi_monthly()` | `data/macro/` |
| M2 | `akshare.macro_china_money_supply()` | `data/macro/` |
| 财务指标 | `akshare.stock_financial_analysis_indicator()` | `data/finance/` |

> `data/stock/`、`data/index/`、`data/macro/`、`data/finance/` 未纳入 Git，克隆后请运行 `01_download.ipynb` 重新下载。

## 清洗与合并产物

| 文件 | 说明 |
|------|------|
| `data/clean/stock_clean.csv` | 清洗后长表（CSV） |
| `data/clean/stock_clean.parquet` | 清洗后长表（Parquet） |
| `data/combined/combined_data.csv` | 行情 + 指数 + 宏观合并 |
| `data/combined/fin_data.db` | SQLite 演示（gitignore，运行 `02_clean.ipynb` 生成） |

## 分析输出图表

| 输出文件 | 生成 Notebook | 含义 |
|----------|---------------|------|
| `fig1_normalized_price.png` | `03_analysis.ipynb` | 10 股归一化收盘价 vs 沪深 300 |
| `fig2_return_dist.png` | `03_analysis.ipynb` | 日收益率分布（分面直方图） |
| `fig3_corr_heatmap.png` | `03_analysis.ipynb` | Pearson 相关系数热力图 |
| `fig4_macro_scatter.png` | `03_analysis.ipynb` | CPI 同比 vs 沪深 300 月度收益 |
| `fig5_roe.png` | `03_analysis.ipynb` | 近 5 年 ROE 对比 |
| `fig_capm_beta.png` | `03_analysis.ipynb` | CAPM Beta 及 95% CI |

## Notebook 与章节对应

| 电子书章节 | 源文件 |
|------------|--------|
| 数据下载 | `01_download.ipynb` |
| 数据清洗 | `02_clean.ipynb` |
| 分析建模 | `03_analysis.ipynb` |
