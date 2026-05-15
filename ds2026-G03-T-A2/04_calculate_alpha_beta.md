| 项目   | 内容 |
|--------|------|
| 课程   | 数据分析与经济决策（ds2026） |
| 题目   | ex_Team01：T-A2_美股七姐妹财务与股价对比 |
| 小组   | 第 3 组 |
| 成员   | 刘飞龙（25210190）、廖婉琼（25210178）、刘凤里（25210191）、高思远（25210133）、杨艺欣（25210279）、司徒靖（25210231）、莫福群（25210212）、甘立杰（25210131） |
| GitHub | https://github.com/ganlijie-code/ds2026-G03-T-A2 |
| Pages  | https://ganlijie-code.github.io/ds2026-G03-T-A2/|
| 日期   | 2026-05-13 |

### 任务： 加入标普 500 指数（^GSPC）作为基准，计算各股的超额收益（α）  （选做） 
目标：下载标普500指数数据，并计算各股超额收益


```python
import os
import pandas as pd
import numpy as np
import yfinance as yf
import glob
import yfinance as yf
import statsmodels.api as sm
import datetime

# --- Configuration ---
DATA_DIR = r'./data_raw'
LOCAL_PRICE_FILE = os.path.join(DATA_DIR, 'prices_raw.csv')
OUTPUT_FILE = os.path.join(DATA_DIR, 'alpha_results.csv')

RISK_FREE_RATE_ANNUAL = 0.05  # 5% annual risk-free rate (approximate)
TRADING_DAYS_PER_YEAR = 252
MAG7_TICKERS = ['AAPL', 'MSFT', 'NVDA', 'GOOGL', 'AMZN', 'META', 'TSLA']

# Proxy settings if needed (uncomment if you are behind a proxy)
proxy = 'http://127.0.0.1:7897'
os.environ['HTTP_PROXY'] = proxy
os.environ['HTTPS_PROXY'] = proxy

def load_local_stock_data(filepath):
    """Loads stock prices from the local CSV file."""
    if not os.path.exists(filepath):
        raise FileNotFoundError(f"Local price file not found: {filepath}")
    
    print(f"Loading local stock data from {filepath}...")
    # Assuming the CSV has Date as index or first column, and Tickers as columns
    df = pd.read_csv(filepath, index_col=0, parse_dates=True)
    
    # Filter only for Magnificent 7 tickers to ensure we only process what we need
    available_tickers = [t for t in MAG7_TICKERS if t in df.columns]
    if not available_tickers:
        print(f"Available columns in local file: {df.columns.tolist()}")
        raise ValueError("None of the Magnificent 7 tickers found in the local CSV columns.")
        
    return df[available_tickers]

def download_sp500_data(start_date, end_date):
    """Downloads S&P 500 (^GSPC) data and extracts the Adj Close price."""
    print(f"Downloading S&P 500 (^GSPC) data from {start_date} to {end_date}...")
    try:
        # Download data
        sp500_df = yf.download('^GSPC', start=start_date, end=end_date, progress=False)
        
        if sp500_df.empty:
            raise ValueError("Downloaded S&P 500 data is empty.")
            
        # Handle potential MultiIndex columns in newer yfinance versions
        if isinstance(sp500_df.columns, pd.MultiIndex):
            # Try to get Adj Close first, then Close
            if ('Adj Close', '^GSPC') in sp500_df.columns:
                sp500_prices = sp500_df[('Adj Close', '^GSPC')]
            elif ('Close', '^GSPC') in sp500_df.columns:
                sp500_prices = sp500_df[('Close', '^GSPC')]
            else:
                raise KeyError("Could not find Price column in MultiIndex S&P 500 data")
        else:
            # Standard single-level columns
            if 'Adj Close' in sp500_df.columns:
                sp500_prices = sp500_df['Adj Close']
            elif 'Close' in sp500_df.columns:
                sp500_prices = sp500_df['Close']
            else:
                raise KeyError("Could not find Price column in S&P 500 data")

        # Ensure it is a Series and name it correctly
        sp500_prices = sp500_prices.squeeze()
        sp500_prices.name = '^GSPC'
        
        print(f"S&P 500 data downloaded. Shape: {sp500_prices.shape}")
        return sp500_prices

    except Exception as e:
        raise Exception(f"Failed to download/process S&P 500 data: {e}")

def calculate_returns(prices):
    """Calculates daily logarithmic returns."""
    return np.log(prices / prices.shift(1)).dropna()

def calculate_capm_metrics(stock_returns, market_returns, rf_daily):
    """
    Calculates Alpha and Beta using CAPM regression.
    Model: R_stock - R_f = alpha + beta * (R_market - R_f) + error
    """
    # Merge stock and market returns on date index
    merged = pd.merge(stock_returns, market_returns, left_index=True, right_index=True, how='inner')
    merged.columns = ['Stock_Return', 'Market_Return']
    merged.dropna(inplace=True)
    
    if len(merged) < 10:
        return np.nan, np.nan

    # Calculate Excess Returns
    merged['Excess_Stock'] = merged['Stock_Return'] - rf_daily
    merged['Excess_Market'] = merged['Market_Return'] - rf_daily
    
    # Prepare for Regression (OLS)
    X = sm.add_constant(merged['Excess_Market']) # Adds intercept term
    y = merged['Excess_Stock']
    
    model = sm.OLS(y, X).fit()
    
    # Extract parameters
    alpha_daily = model.params['const']
    beta = model.params['Excess_Market']
    
    # Annualize Alpha (assuming daily alpha)
    alpha_annual = alpha_daily * TRADING_DAYS_PER_YEAR
    
    return alpha_annual, beta

def main():
    try:
        # 1. Load Local Stock Data
        df_stocks = load_local_stock_data(LOCAL_PRICE_FILE)
        
        # Determine date range from local data to download matching SP500 data
        start_date = df_stocks.index.min()
        end_date = df_stocks.index.max()
        start_str = start_date.strftime('%Y-%m-%d')
        end_str = end_date.strftime('%Y-%m-%d')
        
        # 2. Download S&P 500 Data
        sp500_prices = download_sp500_data(start_str, end_str)
        
        # 3. Calculate Returns
        print("Calculating returns...")
        stock_returns = calculate_returns(df_stocks)
        market_returns = calculate_returns(sp500_prices)
        
        # 4. Calculate Daily Risk-Free Rate
        # Formula: (1 + R_annual)^(1/252) - 1
        rf_daily = (1 + RISK_FREE_RATE_ANNUAL) ** (1/TRADING_DAYS_PER_YEAR) - 1
        
        # 5. Calculate Alpha and Beta for each stock
        results = []
        print("Calculating Alpha and Beta for each stock...")
        
        for ticker in df_stocks.columns:
            if ticker not in stock_returns.columns:
                continue
                
            s_ret = stock_returns[ticker]
            alpha_annual, beta = calculate_capm_metrics(s_ret, market_returns, rf_daily)
            
            results.append({
                'Ticker': ticker,
                'Annualized_Alpha': alpha_annual,
                'Beta': beta,
                'Start_Date': start_str,
                'End_Date': end_str
            })
            print(f"Processed {ticker}: Alpha = {alpha_annual:.4f}, Beta = {beta:.4f}")
            
        # 6. Save Results
        df_results = pd.DataFrame(results)
        # Sort by Alpha descending to see best performers first
        df_results = df_results.sort_values(by='Annualized_Alpha', ascending=False)
        
        df_results.to_csv(OUTPUT_FILE, index=False)
        print(f"\nResults successfully saved to {OUTPUT_FILE}")
        
        print("\n--- Summary of Alpha (Excess Return) ---")
        print(df_results[['Ticker', 'Annualized_Alpha', 'Beta']].to_string(index=False))
        
    except Exception as e:
        print(f"An error occurred: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    main()
```

    Loading local stock data from ./data_raw\prices_raw.csv...
    Downloading S&P 500 (^GSPC) data from 2021-05-10 to 2026-05-08...
    S&P 500 data downloaded. Shape: (1255,)
    Calculating returns...
    Calculating Alpha and Beta for each stock...
    Processed AAPL: Alpha = 0.0427, Beta = 1.2185
    Processed MSFT: Alpha = -0.0066, Beta = 1.1433
    Processed NVDA: Alpha = 0.3568, Beta = 2.1418
    Processed GOOGL: Alpha = 0.1223, Beta = 1.2647
    Processed AMZN: Alpha = -0.0378, Beta = 1.4970
    Processed META: Alpha = -0.0096, Beta = 1.6176
    Processed TSLA: Alpha = -0.0406, Beta = 1.9954
    
    Results successfully saved to ./data_raw\alpha_results.csv
    
    --- Summary of Alpha (Excess Return) ---
    Ticker  Annualized_Alpha     Beta
      NVDA          0.356775 2.141836
     GOOGL          0.122295 1.264750
      AAPL          0.042724 1.218485
      MSFT         -0.006615 1.143319
      META         -0.009647 1.617599
      AMZN         -0.037786 1.497036
      TSLA         -0.040600 1.995397
    

数据可视化：生成图表展示个股的超额收益可交互的图表   


```python
import pandas as pd
import plotly.graph_objects as go
import os

# --- Configuration ---
DATA_DIR = r'./data_raw'

INPUT_FILE = os.path.join(DATA_DIR, 'alpha_results.csv')

def plot_fixed_horizontal_bar(filepath):
    """
    Generates a horizontal bar chart with fixed margins and axis ranges 
    to prevent label clipping for extreme values.
    """
    if not os.path.exists(filepath):
        raise FileNotFoundError(f"Results file not found: {filepath}")
    
    # 1. Load Data
    df = pd.read_csv(filepath)
    
    # Sort by Alpha ascending to place negative values at the bottom (optional, but clean)
    # Or sort by descending to see best performers at top. Let's do descending.
    df_sorted = df.sort_values(by='Annualized_Alpha', ascending=False).reset_index(drop=True)
    
    # Define colors: Green for positive, Red for negative
    colors = ['#ef553b' if x < 0 else '#00cc96' for x in df_sorted['Annualized_Alpha']]
    
    # Calculate dynamic range for padding
    min_alpha = df_sorted['Annualized_Alpha'].min()
    max_alpha = df_sorted['Annualized_Alpha'].max()
    
    # Add 5% padding to the range to ensure labels don't touch the edges
    padding = 0.05 
    x_range = [min_alpha - padding, max_alpha + padding]

    # 2. Create Figure
    fig = go.Figure()
    
    fig.add_trace(go.Bar(
        y=df_sorted['Ticker'],
        x=df_sorted['Annualized_Alpha'],
        orientation='h',
        marker_color=colors,
        text=[f'{x:.2%}' for x in df_sorted['Annualized_Alpha']],
        textposition='outside', # Places text outside the bar
        hovertemplate=(
            "<b>%{y}</b><br>" +
            "Alpha: %{x:.2%}<br>" +
            "Beta: %{customdata[0]:.2f}<br>" +
            "<extra></extra>"
        ),
        customdata=df_sorted[['Beta']].values
    ))
    
    # 3. Layout Configuration with Fixed Margins and Range
    fig.update_layout(
        title={
            'text': "Magnificent 7: Annualized Alpha (Excess Return)",
            'y':0.95,
            'x':0.5,
            'xanchor': 'center',
            'yanchor': 'top'
        },
        template='plotly_white',
        height=500,
        width=900,
        
        # --- KEY FIX 1: Increase Left Margin ---
        # l=120 gives enough space for negative labels like "-4.06%"
        margin=dict(l=120, r=50, t=50, b=50),
        
        xaxis=dict(
            tickformat='.2%',
            zeroline=True,
            zerolinewidth=2,
            zerolinecolor='black',
            # --- KEY FIX 2: Set Explicit Range with Padding ---
            range=x_range,
            title="Annualized Alpha"
        ),
        yaxis=dict(
            title="Stock Ticker"
        ),
        showlegend=False
    )
    
    # 4. Show Plot
    fig.show()

    # Optional: Save as HTML for sharing
    fig.write_html("./output/fig_annualized_alpha.html")

# Execute the function
try:
    plot_fixed_horizontal_bar(INPUT_FILE)
except Exception as e:
    print(f"Error generating plot: {e}")
```


