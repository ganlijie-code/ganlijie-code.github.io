| 项目   | 内容 |
|--------|------|
| 课程   | 数据分析与经济决策（ds2026） |
| 题目   | ex_Team01：T-A2_美股七姐妹财务与股价对比 |
| 小组   | 第 3 组 |
| 成员   | 刘飞龙（25210190）、廖婉琼（25210178）、刘凤里（25210191）、高思远（25210133）、杨艺欣（25210279）、司徒靖（25210231）、莫福群（25210212）、甘立杰（25210131） |
| GitHub | https://github.com/ganlijie-code/ds2026-G03-T-A2 |
| Pages  | https://ganlijie-code.github.io/ds2026-G03-T-A2/|
| 日期   | 2026-05-13 |

### 任务 1：数据获取（01_get_data.ipynb）   
目标：获取七家公司近 5 年的日度股价数据和最新财务指标。   


```python
import yfinance as yf
import pandas as pd
import os
import os
proxy = 'http://127.0.0.1:7897'
os.environ['HTTP_PROXY'] = proxy
os.environ['HTTPS_PROXY'] = proxy



# 定义股票代码
tickers = ['AAPL', 'MSFT', 'NVDA', 'GOOGL', 'AMZN', 'META', 'TSLA']

# 确保输出目录存在
output_dir = './data_raw'
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

print("Starting data download...")

# 1. 批量下载股票价格（过去 5 年，每日，自动调整）
# 注意：如果提供了多个股票代码，yf.download 将返回一个包含 MultiIndex 列的 DataFrame。
# 我们选择 ['Close'] 以获取调整后的收盘价。

try:
    prices = yf.download(tickers, period='5y', auto_adjust=True)['Close']
    
    # 将价格数据保存到 CSV 文件中
    prices.to_csv(os.path.join(output_dir, 'prices_raw.csv'))
    print(f"Price data downloaded and saved to {output_dir}/prices_raw.csv")
except Exception as e:
    print(f"Error downloading price data: {e}")

# 2. 获取财务摘要指标
print("Fetching financial indicators...")
records = []
for tk in tickers:
    try:
        # 创建股票代码对象并获取信息
        ticker_obj = yf.Ticker(tk)
        info = ticker_obj.info
        
        # 将相关的财务指标添加到记录列表中
        records.append({
            'ticker': tk,
            'name': info.get('shortName'),
            'marketCap': info.get('marketCap'),
            'trailingPE': info.get('trailingPE'),
            'priceToBook': info.get('priceToBook'),
            'revenueGrowth': info.get('revenueGrowth'),
            'grossMargins': info.get('grossMargins'),
            'returnOnEquity': info.get('returnOnEquity'),
        })
    except Exception as e:
        print(f"Error fetching info for {tk}: {e}")
        # 根据偏好添加空记录或跳过。
        records.append({
            'ticker': tk,
            'name': None,
            'marketCap': None,
            'trailingPE': None,
            'priceToBook': None,
            'revenueGrowth': None,
            'grossMargins': None,
            'returnOnEquity': None,
        })

# 根据偏好添加空记录或跳过。
df_financials = pd.DataFrame(records)
df_financials.to_csv(os.path.join(output_dir, 'financials_raw.csv'), index=False)
print(f"Financial data downloaded and saved to {output_dir}/financials_raw.csv")

print('Data acquisition completed.')
```
