
| 项目   | 内容 |  
|--------|------|  
| 课程   | 数据分析与经济决策（ds2026） |  
| 题目   | ex_Team01：T-A2_美股七姐妹财务与股价对比 |  
| 小组   | 第 3 组 |  
| 成员   | 刘飞龙（25210190）、廖婉琼（25210178）、刘凤里（25210191）、高思远（25210133）、杨艺欣（25210279）、司徒靖（25210231）、莫福群（25210212）、甘立杰（25210131） |  
| GitHub | https://github.com/ganlijie-code/ds2026-G03-T-A2 |  
| Pages  | https://ganlijie-code.github.io/ds2026-G03-T-A2/|  
| 日期   | 2026-05-13 |  

# 项目名称 — 模块说明
# T-A2_Magnificent7

美股七巨头股票分析项目

## 目录结构

- `data_raw/`: 原始数据（股价、财务数据） 
    prices_raw.csv: 股票价           
    financials_raw.csv: 财务数格数据        
    correlation_matrix.csv: 相关性矩阵        
    alpha_return.csv: 超额收益数据          
    institutional_holdings.csv: top 5 机构持仓数据            
- `data_clean/`: 清洗后的数据    
- `output/`: 可视化图表输出   
  fig_price_trend.png: 股价走势图       
  fig_return_heatmap.png: 收益率热力图           
  fig_risk_return.png: 风险收益关系图           
  fig_valuation.png: 价值关系图           

  fig_price_trend_interactive.html：标准化股价走势--plotly         
  fig_return_heatmap_interactive.html: 年度收益率热力图 --plotly       
  fig_risk_return_interactive.html: 风险-收益散点图 --plotly        
  fig_valuation_interactive.html: 估值指标对比（PE、PB 双轴柱状图）  --plotly        
  fig_annualized_alpha.html: 生成图表展示个股的超额收益 --plotly    
  correlation_heatmap.html: [七姐妹]两相关系数矩阵，热力图--plotly           



## 分析流程

1. `01_get_data.ipynb` - 获取原始数据
2. `02_data_clean.ipynb` - 数据清洗与预处理
3. `03_01_analysis_visualization.ipynb` - 使用plt分析与可视化--以及关于对应图表的问题回答
4. `03_02_analysis_visualization_by_plotly.ipynb` - 使用plotly生成可以交互的图表分析视图
5. `04_calculate_indicators.ipynb` - 加入标普 500 指数（^GSPC）作为基准，计算各股的超额收益（α）
6. `05_calculate_correlation.ipynb` - 计算两两相关系数矩阵，用热力图展示，分析「七姐妹」内部的分散化效果
7. `06_openBB.ipynb` - 使用OpenBB获取机构持仓数据,并生成前5大机构的对【7姐妹】持股的交互图表
