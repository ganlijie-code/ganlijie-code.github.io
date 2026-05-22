# 项目说明（dshw_p02）

## 目录结构

```
dshw_p02/
├── 01_download.ipynb          # 数据采集
├── 02_clean.ipynb             # 数据清洗与存储
├── 03_analysis.ipynb          # 统计分析、可视化与建模
├── _quarto.yml                # Quarto Book 配置
├── index.qmd                  # 电子书首页
├── render.ps1                 # 一键渲染脚本
├── body/                      # 摘要、结论、图表索引
├── data/                      # 原始与清洗数据
├── output/                    # 可视化 PNG
└── docs/                      # quarto render 输出（GitHub Pages）
```

## 快速开始

```bash
cd dshw_p02
pip install -r requirements.txt

# 按顺序运行 Notebook（需联网下载）
jupyter notebook   # 01 → 02 → 03

# 生成 Quarto 电子书
quarto render
# 或 Windows:
.\render.ps1
```

## 编译电子书

| 步骤 | 命令 |
|------|------|
| 安装 Quarto | [https://quarto.org/docs/get-started/](https://quarto.org/docs/get-started/) |
| 渲染 | `quarto render` 或 `.\render.ps1` |
| 本地预览 | 打开 `docs/index.html` |
| 在线阅读 | [GitHub Pages](https://ganlijie-code.github.io/dshw_p02/docs) |

`render.ps1` 会在渲染后将 `output/*.png` 复制到 `docs/body/figures/`，供图表索引章节引用。

## 技术栈

Python 3.10+ · Jupyter · pandas · akshare · matplotlib · seaborn · statsmodels · pyarrow

> 本报告仅供课程/研究交流，不构成投资建议。
