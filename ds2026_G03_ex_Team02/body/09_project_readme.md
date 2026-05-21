# 长鑫科技合理估值分析（DS 项目）

基于**网络下载真实数据**的科创板 IPO 前估值研究，数据不可手工编造。

## 目录结构

```
DS/
├── 01_研究背景与数据下载.ipynb   # 第1–2节 + 数据下载
├── 02_数据清洗与统计事实.ipynb   # 第3–4节
├── 03_结论局限与进阶分析.ipynb   # 第5–6节 + 第7节概要
├── 04_进阶回归与预测分析.ipynb   # **第7节详细回归/事件研究/预测**
├── data/          # 原始下载数据
├── clean/         # 清洗后数据
├── output/        # 图表、回归结果、摘要
├── scripts/       # download_data.py, analysis.py 等
└── requirements.txt
```

## 快速开始

```bash
cd DS
pip install -r requirements.txt
python scripts/build_notebooks.py   # 如需重建 ipynb
python scripts/download_data.py     # 下载原始数据（需联网，约5–10分钟）
python scripts/analysis.py          # 清洗 + 基础出图
python scripts/advanced_analysis.py # 第7节：详细回归、事件研究、预测

图表统一由 `scripts/plot_style.py` 控制样式（配色、字体、网格、数据源脚注，200 DPI）。

**中文显示**：若图表中文为方框/乱码，请确保：
1. 在 `DS` 目录下运行脚本或 Notebook（会读取 `matplotlibrc`）；
2. 绘图前调用 `from plot_style import setup_theme; setup_theme()`；
3. 勿在 `setup_theme()` 之后再单独 `plt.style.use(...)`（会重置为 Arial）。
```

或按顺序运行三个 Jupyter Notebook。

## 数据来源

| 数据 | 接口/URL |
|------|----------|
| A股/美股/指数/宏观 | [akshare](https://github.com/akfamily/akshare) |
| 长鑫招股书财务 | 上交所发行上市审核信息披露 PDF（2026-05-20 上会稿，`GP_COMMON_FILE_SEARCH`） |

## 报告结构对应

1. 决策主体与研究目标 → Notebook 01
2. 政策/市场背景 → Notebook 01
3. 数据来源与处理 → Notebook 01–02
4. 统计事实 → Notebook 02
5. 初步结论 → Notebook 03
6. 局限性 → Notebook 03
7. 回归/事件研究/预测 → Notebook 03 + `output/`
