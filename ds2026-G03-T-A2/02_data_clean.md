| 项目   | 内容 |
|--------|------|
| 课程   | 数据分析与经济决策（ds2026） |
| 题目   | ex_Team01：T-A2_美股七姐妹财务与股价对比 |
| 小组   | 第 3 组 |
| 成员   | 刘飞龙（25210190）、廖婉琼（25210178）、刘凤里（25210191）、高思远（25210133）、杨艺欣（25210279）、司徒靖（25210231）、莫福群（25210212）、甘立杰（25210131） |
| GitHub | https://github.com/ganlijie-code/ds2026-G03-T-A2 |
| Pages  | https://ganlijie-code.github.io/ds2026-G03-T-A2/|
| 日期   | 2026-05-13 |

### 任务 2：数据清洗（02_data_clean.ipynb）   
目标：处理缺失值、计算收益率序列、整理财务指标表。 


```python
import pandas as pd
import numpy as np

prices = pd.read_csv('./data_raw/prices_raw.csv', index_col=0, parse_dates=True)

# 检查缺失值
print(prices.isnull().sum())

# 前向填充（节假日停市产生的缺失）
prices = prices.ffill()

# 计算日度收益率
returns = prices.pct_change().dropna()

# 计算年化收益率（假设 252 个交易日）
annual_return = returns.mean() * 252

# 计算年化波动率
annual_vol = returns.std() * np.sqrt(252)

# 计算最大回撤
def max_drawdown(series):
    cumulative = (1 + series).cumprod()
    rolling_max = cumulative.cummax()
    drawdown = (cumulative - rolling_max) / rolling_max
    return drawdown.min()

max_dd = returns.apply(max_drawdown)

# 计算夏普比率（假设无风险利率 4.5%，当前美国短期国债水平）
rf = 0.045 / 252
sharpe = (returns.mean() - rf) / returns.std() * np.sqrt(252)

metrics = pd.DataFrame({
    '年化收益率': annual_return,
    '年化波动率': annual_vol,
    '最大回撤':   max_dd,
    '夏普比率':   sharpe,
})
metrics.to_csv('./data_clean/metrics.csv')
```
