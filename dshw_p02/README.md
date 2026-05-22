<div align="center">

🔗 [GitHub 仓库](https://github.com/ganlijie-code/dshw-p02.git) &nbsp;|&nbsp; 📖 [Quarto 电子书](./docs/index.html) &nbsp;|&nbsp; 📄 [HTML 报告](./report.html) &nbsp;|&nbsp; 📧 课程作业 &nbsp;|&nbsp; 📅 2026

</div>


<h1>📊 P02：金融数据获取、管理与初步分析</h1>

---

## 📑 目录

- [✨ 项目说明](#-项目说明)
- [📖 Quarto 电子书](#-quarto-电子书)
- [🚀 快速开始](#-快速开始)
- [🏢 股票列表](#-股票列表)
- [🗃️ 数据来源与存储](#️-数据来源与存储)
- [📂 项目结构](#-项目结构)
- [🔧 技术栈](#-技术栈)

---

## ✨ 项目说明

本项目选取覆盖 **7 大行业**（银行、汽车、房地产、白酒、能源、通讯、物流）的 10 家 A 股代表性上市公司，通过 [akshare](https://github.com/akfamily/akshare) 获取 2020 年至今的日度行情、财务指标与宏观数据，完成以下工作：

| 阶段 | Notebook | 核心内容 |
|:--:|:---|:---|
| 📥 数据采集 | `01_download.ipynb` | 股票行情、沪深300/创业板指、CPI/M2、财务指标批量下载 |
| 🧹 数据清洗 | `02_clean.ipynb` | 缺失值处理、格式转换、长宽表变换、CSV / Parquet / SQLite 多格式导出 |
| 🔬 分析建模 | `03_analysis.ipynb` | 描述统计、5 张可视化图、CAPM 回归、宏观回归、完整中文解读 |

> 💡 所有分析代码**完整内联**于 Jupyter Notebook，不依赖外部 `src` 模块，可直接复现。

### 🔑 核心发现

<blockquote>

📈 **价格走势**：2020–2025 年极致分化，比亚迪归一化价格超基准 **8 倍**，万科 A 跌去 **70%+**，印证经济新旧动能切换

📉 **收益率分布**：全员呈现**尖峰厚尾**，日收益率非正态，极端风险被系统性低估

🔗 **板块相关性**：白酒内部"克隆效应"最强（茅五相关系数 **0.83**），能源/通讯与成长股几乎独立（< **0.15**）

📊 **CPI 与股市**：月度 CPI 同比与沪深 300 收益几乎无关（Pearson r = **-0.128**），单指标择时无效

💰 **ROE 对比**：茅台稳态 **30%+** 遥遥领先，比亚迪随新能源渗透率爆发，万科 A 2025 年 ROE 跌至 **-55.4%**

📐 **CAPM 回归**：汽车股 Beta 显著 > 1（周期敏感），银行/运营商 Beta < 1（防御属性）

</blockquote>

## 📖 Quarto 电子书

| 项目       | 路径 |
|----------|------|
| gitHub仓库 | [https://github.com/ganlijie-code/dshw-p02.git](https://github.com/ganlijie-code/dshw-p02.git) |
| 在线阅读     | [https://ganlijie-code.github.io/dshw_p02](https://ganlijie-code.github.io/dshw_p02/docs) |

章节包括：摘要导读 → 三个 Notebook → 统计摘要 / 结论 / 数据溯源 / 图表索引。

---

## 🚀 快速开始

```bash
# 1. 克隆仓库
git clone https://github.com/ganlijie-code/dshw-p02.git
cd dshw-p02

# 2. 安装依赖
pip install -r requirements.txt

```

> ⚠️ 运行 `01_download.ipynb` 需联网，约 **3–5 分钟**。

---

## 🏢 股票列表

覆盖 **7 大行业**：

| 代码 | 名称 | 行业 | 选股理由 |
|:---:|:---|:---:|:---|
| 601398 | 工商银行 | 🏦 银行 | 国有大行龙头，低 β、高分红防御特征 |
| 600036 | 招商银行 | 🏦 银行 | 零售银行标杆，与工行形成对照 |
| 002594 | 比亚迪 | 🚗 汽车 | 新能源全球龙头，高成长高波动 |
| 601633 | 长城汽车 | 🚗 汽车 | 传统车企转型代表，与比亚迪形成产业链对照 |
| 000002 | 万科A | 🏠 房地产 | 地产行业标杆，便于分析政策周期与系统性风险 |
| 600519 | 贵州茅台 | 🍶 白酒 | A 股"股王"，消费龙头，长期超额收益典型 |
| 000858 | 五粮液 | 🍶 白酒 | 高端白酒第二梯队，与茅台构成行业内对比 |
| 601857 | 中国石油 | ⛽ 能源 | 能源央企代表，油价与通胀敏感，周期性显著 |
| 600941 | 中国移动 | 📡 通讯 | 运营商龙头，现金流稳定、防御属性强 |
| 002352 | 顺丰控股 | 📦 物流 | 快递物流龙头，反映消费与电商景气度 |

---

## 🗃️ 数据来源与存储

### 数据来源

| 数据类型 | 来源 / API | 说明 |
|:---|:---|:---|
| 📈 股票行情 | `akshare.stock_zh_a_hist()` | **后复权**日度行情，2020-01-01 至今 |
| 📊 市场指数 | `akshare.stock_zh_index_daily_em()` | 沪深 300（000300）+ 创业板指（399006） |
| 🏷️ CPI | `akshare.macro_china_cpi_monthly()` | 月度同比增速 |
| 💵 M2 | `akshare.macro_china_money_supply()` | 货币供应量增速 |
| 📋 财务指标 | `akshare.stock_financial_analysis_indicator()` | ROE、销售净利率等 |

### 存储方式

项目演示了三种数据存储范式：

- **📄 CSV**（`data/clean/stock_clean.csv`）  
  可读性强、跨平台、便于 Git 与 Excel 查看；劣势是体积大、无 Schema。

- **🚀 Parquet**（`data/clean/stock_clean.parquet`）  
  列式压缩、类型契约、按需读列。金融时间序列列多、重复读取场景多，Parquet 在体积与读取速度上显著优于 CSV。

- **🗄️ SQLite**（`data/combined/fin_data.db`）  
  在 `02_clean.ipynb` 中演示 JOIN 查询；**不提交至 Git**（见 `.gitignore`），克隆后运行 `02_clean.ipynb` 可重建。

---

## 📂 项目结构

```
dshw-p02/
├── 📘 01_download.ipynb          # 数据采集
├── 📗 02_clean.ipynb             # 数据清洗与存储
├── 📙 03_analysis.ipynb          # 统计分析、可视化与建模
├── 📖 _quarto.yml / index.qmd    # Quarto Book 配置
├── 📁 body/                      # 摘要、结论、图表索引
├── 📁 docs/                      # quarto render 输出
├── 📄 README.md
├── 📦 requirements.txt
├── 🔒 .gitignore
├── 🌐 report.html                # 导出的 HTML 报告
├── 📝 download_log.txt           # 下载日志
├── 📁 data/
│   ├── stock/                    # 原始股票行情（gitignore）
│   ├── index/                    # 原始指数行情（gitignore）
│   ├── macro/                    # 原始宏观数据（gitignore）
│   ├── finance/                  # 原始财务指标（gitignore）
│   ├── clean/                    # 清洗后数据
│   └── combined/                 # 合并数据与 SQLite
└── 🖼️ output/                    # 可视化输出
    ├── fig1_normalized_price.png
    ├── fig2_return_dist.png
    ├── fig3_corr_heatmap.png
    ├── fig4_macro_scatter.png
    ├── fig5_roe.png
    └── fig_capm_beta.png
```

> ⚠️ `data/stock/`、`data/index/`、`data/macro/`、`data/finance/` 已在 `.gitignore` 中忽略。克隆仓库后请运行 `01_download.ipynb` 重新获取原始数据。

---

## 🔧 技术栈

<p align="center">
  <img src="https://img.shields.io/badge/akshare-1.14%2B-red?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEyIDJDNi40NzcgMiAyIDYuNDc3IDIgMTJzNC40NzcgMTAgMTAgMTAgMTAtNC40NzcgMTAtMTBTMTcuNTIzIDIgMTIgMnoiIGZpbGw9IndoaXRlIi8+PC9zdmc+" alt="akshare">
  <img src="https://img.shields.io/badge/pandas-2.0%2B-150458?logo=pandas&logoColor=white" alt="pandas">
  <img src="https://img.shields.io/badge/numpy-1.24%2B-013243?logo=numpy&logoColor=white" alt="numpy">
  <img src="https://img.shields.io/badge/matplotlib-3.7%2B-11557c?logo=matplotlib&logoColor=white" alt="matplotlib">
  <img src="https://img.shields.io/badge/seaborn-0.13%2B-3d5a80?logo=python&logoColor=white" alt="seaborn">
  <img src="https://img.shields.io/badge/statsmodels-0.14%2B-2d6a4f?logo=python&logoColor=white" alt="statsmodels">
  <img src="https://img.shields.io/badge/scipy-1.11%2B-8CAAE6?logo=scipy&logoColor=white" alt="scipy">
  <img src="https://img.shields.io/badge/pyarrow-14.0%2B-F58F1A?logo=apache&logoColor=white" alt="pyarrow">
</p>

---
