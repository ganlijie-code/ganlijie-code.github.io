| 项目   | 内容 |
|--------|------|
| 课程   | 数据分析与经济决策（ds2026） |
| 题目   | ex_Team01：T-A2_美股七姐妹财务与股价对比 |
| 小组   | 第 3 组 |
| 成员   | 刘飞龙（25210190）、廖婉琼（25210178）、刘凤里（25210191）、高思远（25210133）、杨艺欣（25210279）、司徒靖（25210231）、莫福群（25210212）、甘立杰（25210131） |
| GitHub | https://github.com/ganlijie-code/ds2026-G03-T-A2 |
| Pages  | https://ganlijie-code.github.io/ds2026-G03-T-A2/|
| 日期   | 2026-05-13 |

### 任务 3：分析与可视化，使用plotly生成可以交互的图表        

图 1：标准化股价走势（基期 = 1）  


```python
import pandas as pd
import plotly.express as px

prices = pd.read_csv('./data_raw/prices_raw.csv', index_col=0, parse_dates=True)

prices_norm = prices / prices.iloc[0]


prices_norm_reset = prices_norm.reset_index()
prices_norm_reset.rename(columns={'index': 'Date'}, inplace=True)


df_long = prices_norm_reset.melt(id_vars=['Date'], var_name='Ticker', value_name='Normalized Price')
print(prices_norm_reset.head())
fig = px.line(
    df_long, 
    x='Date', 
    y='Normalized Price', 
    color='Ticker',
    title='Magnificent 7: Normalized Stock Price Trend (Base = 1)',
    labels={'Normalized Price': 'Relative Price (Base=1)', 'Date': 'Date'},
    hover_data={'Date': '|%Y-%m-%d'} 
)

fig.update_layout(
    hovermode='x unified', 
    legend_title_text='Company Ticker',
    template='plotly_white',
    height=600,
    width=1200
)


fig.update_yaxes(title_text="Normalized Price")


fig.show()


fig.write_html("./output/fig_price_trend_interactive.html")
```

            Date      AAPL      AMZN     GOOGL      META      MSFT      NVDA  \
    0 2021-05-10  1.000000  1.000000  1.000000  1.000000  1.000000  1.000000   
    1 2021-05-11  0.992590  1.010475  0.990536  1.001830  0.996157  1.002839   
    2 2021-05-12  0.967836  0.987917  0.960074  0.988822  0.966907  0.964443   
    3 2021-05-13  0.985179  0.990904  0.972637  0.997679  0.983211  0.957906   
    4 2021-05-14  1.004730  1.010158  0.994166  1.032585  1.003924  0.998405   
    
           TSLA  
    0  1.000000  
    1  0.981178  
    2  0.937762  
    3  0.908829  
    4  0.937524  


[fig_price_trend_interactive.html](output/fig_price_trend_interactive.html)  



图 2：年度收益率热力图  


```python
import pandas as pd
import plotly.graph_objects as go
import numpy as np
import plotly.express as px
import plotly.io as pio


prices = pd.read_csv('./data_raw/prices_raw.csv', index_col=0, parse_dates=True)
prices = prices.ffill()
returns = prices.pct_change().dropna()


annual_returns_by_year = returns.resample('YE').apply(
    lambda x: (1 + x).prod() - 1
) * 100


df_heatmap = annual_returns_by_year.T


fig = go.Figure(data=go.Heatmap(
    z=df_heatmap.values,
    x=df_heatmap.columns.strftime('%Y'),  
    y=df_heatmap.index,                   
    colorscale='RdYlGn',                   
    zmid=0,                                
    text=df_heatmap.values,               
    texttemplate='%{text:.1f}%',          
    textfont={"size": 10},
    hovertemplate=(
        "<b>Stock</b>: %{y}<br>" +
        "<b>Year</b>: %{x}<br>" +
        "<b>Return</b>: %{z:.2f}%<extra></extra>"
    ),
    colorbar=dict(title="Annual Return (%)")
))

fig.update_layout(
    title='Seven Sisters Annual Returns Heatmap (%)',
    xaxis_title='Year',
    yaxis_title='Stock Ticker',
    width=1000,
    height=500,

    font=dict(family="Microsoft YaHei, SimHei, sans-serif"), 
    margin=dict(l=50, r=50, t=50, b=50)
)

fig.show()
fig.write_html("./output/fig_return_heatmap_interactive.html")
```


[fig_return_heatmap_interactive.html](output/fig_return_heatmap_interactive.html)


图 3：风险-收益散点图  


```python
import plotly.express as px
import pandas as pd
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
df_metrics = metrics.reset_index()
df_metrics.rename(columns={'index': 'Ticker'}, inplace=True)

df_metrics['Volatility (%)'] = df_metrics['年化波动率'] * 100
df_metrics['Return (%)'] = df_metrics['年化收益率'] * 100

fig = px.scatter(
    df_metrics, 
    x='Volatility (%)', 
    y='Return (%)',
    text='Ticker',       
    size='夏普比率',      
    color='Ticker',      
    hover_data={
        'Ticker': True,
        'Volatility (%)': ':.2f',
        'Return (%)': ':.2f',
        '夏普比率': ':.2f',
        '最大回撤': ':.2%'
    },
    title='Risk-Return Distribution (Last 5 Years)'
)

fig.update_traces(textposition='top center', marker=dict(size=15))

fig.add_hline(y=0, line_dash="dash", line_color="gray", annotation_text="Zero Return")

fig.update_layout(
    xaxis_title='Annual Volatility (%)',
    yaxis_title='Annual Return (%)',
    width=800,
    height=600,
    font=dict(family="Microsoft YaHei, SimHei, sans-serif"), # Attempt to support Chinese fonts
    legend_title_text='Stock Ticker'
)

fig.show()
fig.write_html("./output/fig_risk_return_interactive.html")
```

    AAPL     0
    AMZN     0
    GOOGL    0
    META     0
    MSFT     0
    NVDA     0
    TSLA     0
    dtype: int64
    

[fig_risk_return_interactive.html](output/fig_risk_return_interactive.html)



图 4：估值指标对比（PE、PB 双轴柱状图）  


```python
import pandas as pd
import plotly.graph_objects as go
from plotly.subplots import make_subplots

# 读取数据
financials = pd.read_csv('./data_raw/financials_raw.csv', index_col='ticker')

# 创建带有双Y轴的子图
fig = make_subplots(specs=[[{"secondary_y": True}]])

tickers = financials.index.tolist()
x_pos = list(range(len(tickers)))

# 添加 PE 柱状图（左侧Y轴）
fig.add_trace(
    go.Bar(
        x=tickers,
        y=financials['trailingPE'],
        name='PE（市盈率）',
        marker_color='steelblue',
        opacity=0.8,
        width=0.35,
        offsetgroup=0,
        offset=-0.375,
        hovertemplate='<b>%{x}</b><br>PE: %{y:.2f}<extra></extra>'
    ),
    secondary_y=False,
)

# 添加 PB 柱状图（右侧Y轴）
fig.add_trace(
    go.Bar(
        x=tickers,
        y=financials['priceToBook'],
        name='PB（市净率）',
        marker_color='darkorange',
        opacity=0.8,
        width=0.35,
        offsetgroup=1,
        offset=0.025,
        hovertemplate='<b>%{x}</b><br>PB: %{y:.2f}<extra></extra>'
    ),
    secondary_y=True,
)

# 设置布局
fig.update_layout(
    title=dict(
        text='七姐妹估值对比：PE 与 PB',
        x=0.5,
        xanchor='center',
        font=dict(size=18)
    ),
    barmode='group',
    bargap=0.25,
    bargroupgap=0.1,
    legend=dict(
        orientation="h",
        yanchor="bottom",
        y=1.02,
        xanchor="right",
        x=1
    ),
    hovermode='x unified',
    template='plotly_white',
    width=1000,
    height=600,
)

# 设置 X 轴
fig.update_xaxes(
    title_text="",
    tickangle=0,
    showgrid=False
)

# 设置左侧 Y 轴（PE）
fig.update_yaxes(
    title_text="市盈率（PE）",
    secondary_y=False,
    showgrid=True,
    gridcolor='lightgray',
    range=[0, 450]
)

# 设置右侧 Y 轴（PB）
fig.update_yaxes(
    title_text="市净率（PB）",
    secondary_y=True,
    showgrid=False,
    range=[0, 45]
)

fig.show()

# 保存为交互式 HTML
fig.write_html('./output/fig_valuation_interactive.html', include_plotlyjs='cdn')
print("交互式图表已保存至: ./output/fig_valuation_interactive.html")


```

[fig_valuation_interactive.html](output/fig_valuation_interactive.html)

    交互式图表已保存至: ./output/fig_valuation_interactive.html
    
