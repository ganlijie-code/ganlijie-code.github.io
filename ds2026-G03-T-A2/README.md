| 项目   | 内容                                                                                                                                                           |
| ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 课程   | 数据分析与经济决策（ds2026）                                                                                                                                   |
| 题目   | ex_Team01：T-A2_美股七姐妹财务与股价对比                                                                                                                       |
| 小组   | 第 3 组                                                                                                                                                        |
| 成员   | 刘飞龙（25210190）、廖婉琼（25210178）、刘凤里（25210191）、高思远（25210133）、杨艺欣（25210279）、司徒靖（25210231）、莫福群（25210212）、甘立杰（25210131） |
| GitHub | https://github.com/ganlijie-code/ds2026-G03-T-A2                                                                                                               |
| Pages  | https://ganlijie-code.github.io/ds2026-G03-T-A2/                                                                                                               |
| 日期   | 2026-05-13                                                                                                                                                     |

## 📊 项目简介

本项目对美股"七姐妹"（Magnificent 7）进行全面的财务与股价对比分析，包括数据获取、清洗、可视化、Alpha/Beta 计算、相关性分析以及机构持仓分析。

## 📁 目录结构

- **📂 data_raw/** - 原始数据目录

  - 📄 prices_raw.csv - 股票价格原始数据
  - 📄 financials_raw.csv - 财务数据原始数据
  - 📄 correlation_matrix.csv - 相关性矩阵数据
  - 📄 alpha_results.csv - Alpha 超额收益数据
  - 📄 institutional_holdings_magnificent7.csv - 机构持仓数据（前5大机构）
- **📂 data_clean/** - 清洗后数据目录

  - 📄 metrics.csv - 清洗后的指标数据
- **📂 output/** - 可视化输出目录

  - **📊 静态图表 (PNG)**

    - 🖼️ fig_price_trend.png - 股价走势对比图
    - 🖼️ fig_return_heatmap.png - 年度收益率热力图
    - 🖼️ fig_risk_return.png - 风险-收益关系散点图
    - 🖼️ fig_valuation.png - 估值指标对比图（PE、PB）
  - **🌐 交互式图表 (HTML)**

    - 🌟 fig_price_trend_interactive.html - 标准化股价走势
    - 🌟 fig_return_heatmap_interactive.html - 年度收益率热力图
    - 🌟 fig_risk_return_interactive.html - 风险-收益散点图
    - 🌟 fig_valuation_interactive.html - 估值指标对比（双轴柱状图）
    - 🌟 fig_annualized_alpha.html - 年化 Alpha 超额收益
    - 🌟 correlation_heatmap.html - 相关系数矩阵热力图
- **📓 Jupyter Notebooks** - 分析流程脚本

  - 📓 01_get_data1.ipynb - Step 1: 数据获取
  - 📓 02_data_clean.ipynb - Step 2: 数据清洗与预处理
  - 📓 03_01_analysis_visualization.ipynb - Step 3a: Matplotlib 可视化分析
  - 📓 03_02_analysis_visualization_by_plotly.ipynb - Step 3b: Plotly 交互式可视化
  - 📓 04_calculate_alpha_beta.ipynb - Step 4: Alpha/Beta 计算
  - 📓 05_calculate_correlation.ipynb - Step 5: 相关性分析
  - 📓 06_openBB.ipynb - Step 6: OpenBB 机构持仓分析
- **📄 其他文件**

  - 📄 README.md - 项目说明文档
  - 📄 T-A2_美股七姐妹财务与股价对比.md - 作业题目文档

## page展示

### 🔄 分析流程（在线查看）

1. [获取美股七姐妹的原始股价和财务数据](https://ganlijie-code.github.io/ds2026-G03-T-A2/01_get_data1.md) ：获取美股七姐妹的原始股价和财务数据，数据来源：Yahoo Finance 等金融数据接口
2. [处理缺失值和异常值](https://ganlijie-code.github.io/ds2026-G03-T-A2/02_data_clean.md) ：处理缺失值和异常值，数据格式标准化，生成清洗后的数据集
3. [可视化分析](https://ganlijie-code.github.io/ds2026-G03-T-A2/03_01_analysis_visualization.md) :使用 Matplotlib 生成静态图表,包含对应图表的问题分析与回答
4. [生成交互式图表](https://ganlijie-code.github.io/ds2026-G03-T-A2/03_02_analysis_visualization_by_plotly.md) ： 使用 Plotly 生成交互式图表，支持悬停查看等交互功能
5. [计算各股超额收益](https://ganlijie-code.github.io/ds2026-G03-T-A2/04_calculate_alpha_beta.md) ：以标普 500 指数（^GSPC）为基准，计算各股的超额收益（α）和风险系数（β）
6. [相关性分析](https://ganlijie-code.github.io/ds2026-G03-T-A2/05_calculate_correlation.md) ：计算两两相关系数矩阵，使用热力图展示"七姐妹"内部的分散化效果，并进行简单分析
7. [机构持仓分析](https://ganlijie-code.github.io/ds2026-G03-T-A2/06_openBB.md) ：使用 OpenBB 获取机构持仓数据，生成前 5 大机构对"七姐妹"持股的交互式图表
