<div align="center">

🔗 [GitHub 仓库](https://github.com/ganlijie-code/ds2026_G03_ex_Team02) &nbsp;|&nbsp; 📖 [Quarto 电子书](https://ganlijie-code.github.io/ds2026_G03_ex_Team02/docs) &nbsp;|&nbsp; 📧 数据分析课程 · 第 3 组 &nbsp;|&nbsp; 📅 2026

</div>

<h1>📊 ex_Team02：长鑫科技合理估值分析</h1>

**第 3 组** · `ds2026` · 数据分析与经济决策 · 第二次小组作业

---

## 📑 目录

- [✨ 项目说明](#-项目说明)
- [👥 小组成员](#-小组成员)
- [🔑 核心发现](#-核心发现)
- [📖 Quarto 电子书](#-quarto-电子书)
- [🚀 快速开始](#-快速开始)
- [🏢 可比公司与研究对象](#-可比公司与研究对象)
- [🗃️ 数据来源](#️-数据来源)
- [📂 项目结构](#-项目结构)
- [🔧 技术栈](#-技术栈)

---

## ✨ 项目说明

结合招股书财务、A 股/美股同业行情与宏观数据，对长鑫科技拟科创板 IPO 的**估值区间**与**产业链影响**进行实证研究。数据均来自网络下载，完整分析流程见下方 Notebook 与章节导航。

| 阶段 | Notebook / 章节 | 核心内容 |
|:--:|:---|:---|
| 📥 背景与下载 | `01_研究背景与数据下载.ipynb` | 决策主体、政策背景、akshare + 上交所 PDF 数据下载 |
| 🧹 清洗与事实 | `02_数据清洗与统计事实.ipynb` | 缺失处理、指标构造、描述统计与核心图表 |
| 📝 结论与局限 | `03_结论局限与进阶分析.ipynb` | 初步结论、局限性、第 7 节概要 |
| 🔬 回归与预测 | `04_进阶回归与预测分析.ipynb` | CAPM、事件研究、营收 OLS、同业 PS 回归 |

> 💡 分析代码**完整内联**于 Jupyter Notebook；原始数据与脚本见源码仓库 `data/`、`scripts/`（克隆后运行下载脚本可复现）。

---

## 👥 小组成员

> **隐私说明**  
> 本页为公开仓库与 GitHub Pages，不展示学号，以降低个人信息暴露与检索关联风险。课程登记与正式提交以**坚果云**为准。

| 姓名 | 分工 |
| :--- | :--- |
| **甘立杰** | 研究设计、报告统筹 |
| **廖婉琼** | 报告写作与结论提炼 |
| **刘凤里** | 招股书数据与财务事实整理 |
| **高思远** | 数据获取与清洗脚本 |
| **杨艺欣** | 图表可视化与样式规范 |
| **司徒靖** | CAPM、事件研究与市场定价 |
| **莫福群** | 估值回归与情景分析 |
| **刘飞龙** | 幻灯片制作与汇报材料 |

---

## 🔑 核心发现

<blockquote>

📈 **规模与结构**：2024 年营收 **241.78 亿元**（同比约 **+166%**）；LPDDR 收入占比高于 DDR；归母净利润仍为负，累计亏损约 **408 亿元**（2022—2025H1）

💰 **估值锚**：一级市场报道约 **1282—1584 亿元**（约 5.3—6.6× 2024 收入 PS）；收入×PE 情景（8/15/25 倍）约 **1934 / 3627 / 6045 亿元**（示意，需盈利预测修正）

📐 **CAPM**：存储产业链可比公司 Beta 多显著 **> 1**（如兆易创新 **1.38**、澜起科技 **1.31**），系统性风险高于市场

📉 **事件研究**：科创板受理日前后，半导体指数 CAR 约 **+6.5%**，但事件窗 AR 的 p 值 **> 0.05**，异常收益统计上不显著

🔗 **同业 PS 回归**：在可比公司历史 PS—收入对数关系下，2024 收入对应模型隐含市值约 **1636 亿元**（PS ≈ **6.77**），须与一级市场报道区间交叉验证

</blockquote>

---

## 📖 Quarto 电子书

| 项目 | 路径 |
|------|------|
| GitHub 仓库 | [ganlijie-code/ds2026_G03_ex_Team02](https://github.com/ganlijie-code/ds2026_G03_ex_Team02) |
| 在线阅读 | [ganlijie-code.github.io/ds2026_G03_ex_Team02](https://ganlijie-code.github.io/ds2026_G03_ex_Team02/docs) |
---

## 🚀 快速开始

```bash
# 1. 克隆仓库
git clone https://github.com/ganlijie-code/ds2026_G03_ex_Team02.git
cd ds2026_G03_ex_Team02

# 2. 安装 Python 依赖（运行 Notebook / 下载脚本）
pip install -r requirements.txt

# 3. 下载原始数据（需联网，约 5–10 分钟）
python scripts/download_data.py
python scripts/analysis.py
python scripts/advanced_analysis.py

# 4. 本地渲染 Quarto 电子书（需安装 Quarto）
quarto render
# 或在 Windows 下：
# .\render.ps1
```

> ⚠️ 运行 `01_研究背景与数据下载.ipynb` 及下载脚本需联网。`data/` 原始目录默认不提交 Git，克隆后请执行下载脚本重建。

---

## 🏢 可比公司与研究对象

| 类型 | 名称/代码 | 说明 |
|:---:|:---|:---|
| 🎯 研究对象 | 长鑫科技（拟科创板 IPO） | 拟募资约 **295 亿元**；2024 营收 **241.78 亿**；DRAM 出货量中国第一、全球第四 |
| 💾 A 股存储/半导体 | 兆易创新、澜起科技、北京君正、中芯国际、北方华创等 | 行情、ROE、CAPM Beta、PS 回归可比样本 |
| 🌐 美股对照 | 美光（MU）、西部数据（WDC） | 全球存储周期与营收对照 |
| 📊 市场/行业指数 | 沪深 300、科创 50、半导体行业指数 | CAPM 基准与事件研究标的 |

---

## 🗃️ 数据来源

| 数据类型 | 来源 / API | 说明 |
|:---|:---|:---|
| 📋 招股书财务 | 上交所发行上市审核信息披露 PDF | 2026-05-20 上会稿 → `data/ipo/cxkj_financials.csv` |
| 📅 IPO 事件日 | 安徽证监局辅导备案、上交所受理 | `data/ipo/cxkj_ipo_tutor.csv`、`cxkj_register.csv` |
| 📈 A 股可比行情 | `akshare.stock_zh_a_daily` | `data/stock/` |
| 🌐 美股 MU/WDC | `akshare.stock_us_daily` | `data/us/` |
| 📊 指数/宏观/行业 | akshare 指数与宏观接口 | `data/index/`、`macro/`、`industry/` |
| 📋 同业财务 | akshare 同花顺财务摘要 | `data/finance/finance_ths_*.csv` |

清洗产物示例：`clean/stock_clean.csv`、`clean/cxkj_financials_clean.csv`、`clean/peer_roe_clean.csv`；图表与回归表输出至 `output/`。

---

## 📂 项目结构

```
ds2026_G03_ex_Team02/
├── 📘 body/
│   ├── 00_abstract.md
│   ├── 01_研究背景与数据下载.ipynb
│   ├── 02_数据清洗与统计事实.ipynb
│   ├── 03_结论局限与进阶分析.ipynb
│   ├── 04_进阶回归与预测分析.ipynb
│   ├── 05_summary_stats.md … 08_figures.md
│   ├── 09_project_readme.md
│   └── figures/              # 图表 PNG
├── 📖 _quarto.yml / index.qmd
├── 📁 docs/                  # quarto render → GitHub Pages
├── 📄 README.md
├── 🎨 styles.css
├── ⚙️ render.ps1             # 本地一键渲染
├── 📦 requirements.txt       # Python 依赖（源码仓）
├── 📁 data/                  # 原始数据（gitignore）
├── 📁 clean/                 # 清洗后数据
├── 📁 output/                # 图表与回归 CSV
└── 📁 scripts/               # download_data.py, analysis.py 等
```

> ⚠️ `data/` 原始目录已在 `.gitignore` 中忽略。克隆后运行 `scripts/download_data.py` 或 Notebook 01 可重新获取。

---

## 🔧 技术栈

<p align="center">
  <img src="https://img.shields.io/badge/Quarto-Book-75AADB?logo=quarto&logoColor=white" alt="quarto">
  <img src="https://img.shields.io/badge/akshare-1.14%2B-red" alt="akshare">
  <img src="https://img.shields.io/badge/pandas-2.0%2B-150458?logo=pandas&logoColor=white" alt="pandas">
  <img src="https://img.shields.io/badge/numpy-1.24%2B-013243?logo=numpy&logoColor=white" alt="numpy">
  <img src="https://img.shields.io/badge/matplotlib-3.7%2B-11557c?logo=matplotlib&logoColor=white" alt="matplotlib">
  <img src="https://img.shields.io/badge/seaborn-0.13%2B-3d5a80" alt="seaborn">
  <img src="https://img.shields.io/badge/statsmodels-0.14%2B-2d6a4f" alt="statsmodels">
  <img src="https://img.shields.io/badge/scipy-1.11%2B-8CAAE6?logo=scipy&logoColor=white" alt="scipy">
</p>

---

> 本报告仅供课程/研究交流，不构成投资建议。数据截至项目生成日，请以交易所及公司最新披露为准。
