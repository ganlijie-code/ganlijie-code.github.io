| 项目   | 内容 |
|--------|------|
| 课程   | 数据分析与经济决策（ds2026） |
| 题目   | ex_Team01：T-A2_美股七姐妹财务与股价对比 |
| 小组   | 第 3 组 |
| 成员   | 刘飞龙（25210190）、廖婉琼（25210178）、刘凤里（25210191）、高思远（25210133）、杨艺欣（25210279）、司徒靖（25210231）、莫福群（25210212）、甘立杰（25210131） |
| GitHub | https://github.com/ganlijie-code/ds2026-G03-T-A2 |
| Pages  | https://ganlijie-code.github.io/ds2026-G03-T-A2/|
| 日期   | 2026-05-13 |

### 任务：计算两两相关系数矩阵，用热力图展示   （选做）
目标：计算相关系数，生成可交互的热力图


```python
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import os

import plotly.graph_objects as go
import plotly.express as px

# --- Configuration ---
DATA_DIR = r'./data_raw'
INPUT_FILE = os.path.join(DATA_DIR, 'prices_raw.csv')
OUTPUT_CORR_CSV = os.path.join(DATA_DIR, 'correlation_matrix.csv')
OUTPUT_HEATMAP_HTML = os.path.join('./output', 'correlation_heatmap.html')

MAG7_TICKERS = ['AAPL', 'MSFT', 'NVDA', 'GOOGL', 'AMZN', 'META', 'TSLA']

def load_and_preprocess_data(filepath):
    """
    Loads stock prices, filters for Magnificent 7, and calculates daily returns.
    """
    if not os.path.exists(filepath):
        raise FileNotFoundError(f"Data file not found: {filepath}")
    
    print(f"Loading data from {filepath}...")
    df_prices = pd.read_csv(filepath, index_col=0, parse_dates=True)
    
    # Filter for specific tickers
    available_tickers = [t for t in MAG7_TICKERS if t in df_prices.columns]
    
    if len(available_tickers) < 2:
        raise ValueError("Not enough stock data found in the file.")
        
    print(f"Found tickers: {available_tickers}")
    df_selected = df_prices[available_tickers]
    
    # Drop rows with missing values
    df_clean = df_selected.dropna()
    
    if df_clean.empty:
        raise ValueError("No valid data remaining after cleaning NaNs.")
        
    # Calculate daily logarithmic returns
    df_returns = np.log(df_clean / df_clean.shift(1)).dropna()
    
    return df_returns, available_tickers

def calculate_correlation_matrix(df_returns):
    """
    Calculates the Pearson correlation matrix.
    """
    print("Calculating correlation matrix...")
    corr_matrix = df_returns.corr(method='pearson')
    return corr_matrix

def plot_interactive_heatmap(corr_matrix, save_path):
    """
    Generates an interactive heatmap using Plotly and saves it as an HTML file.
    """
    print("Generating interactive heatmap...")
    
    # Create the heatmap figure
    fig = go.Figure(data=go.Heatmap(
        z=corr_matrix.values,
        x=corr_matrix.columns,
        y=corr_matrix.index,
        colorscale='RdBu_r', # Red-Blue reversed: Blue for negative, Red for positive
        zmin=-1,
        zmax=1,
        text=np.round(corr_matrix.values, 2), # Show values on hover/cells
        hoverongaps=False,
        texttemplate="%{text}", # Display text in cells
        textfont={"size": 10},
        colorbar=dict(title="Correlation")
    ))

    # Update layout for better appearance
    fig.update_layout(
        title='Interactive Correlation Matrix: Magnificent 7 Stocks',
        xaxis_title='Stock Ticker',
        yaxis_title='Stock Ticker',
        width=800,
        height=700,
        xaxis=dict(tickangle=45),
        yaxis=dict(autorange='reversed'), # Reverse y-axis to match standard matrix layout
        template='plotly_white'
    )

    # Show the figure
    fig.show()
    
    # Save as interactive HTML
    fig.write_html(save_path)
    print(f"Interactive heatmap saved to: {save_path}")

def analyze_diversification(corr_matrix):
    """
    Analyzes the diversification effect based on average correlations.
    """
    print("\n--- Diversification Analysis ---")
    
    # Get values excluding diagonal
    n = corr_matrix.shape[0]
    total_sum = np.sum(corr_matrix.values) - n
    num_pairs = n * (n - 1)
    
    if num_pairs == 0:
        return

    avg_corr = total_sum / num_pairs
    
    print(f"Average Pairwise Correlation: {avg_corr:.4f}")
    
    if avg_corr > 0.7:
        print("Assessment: HIGH Correlation. Limited diversification benefits.")
    elif avg_corr > 0.4:
        print("Assessment: MODERATE Correlation. Some diversification benefits.")
    else:
        print("Assessment: LOW Correlation. Good diversification potential.")

def main():
    try:
        # 1. Load Data
        df_returns, tickers = load_and_preprocess_data(INPUT_FILE)
        
        # 2. Calculate Correlation
        corr_matrix = calculate_correlation_matrix(df_returns)
        
        # 3. Save Correlation Matrix to CSV
        corr_matrix.to_csv(OUTPUT_CORR_CSV)
        print(f"Correlation matrix saved to: {OUTPUT_CORR_CSV}")
        
        # 4. Plot Interactive Heatmap
        plot_interactive_heatmap(corr_matrix, OUTPUT_HEATMAP_HTML)
        
        # 5. Analyze Results
        analyze_diversification(corr_matrix)
        
    except FileNotFoundError as e:
        print(f"Error: {e}")
    except ValueError as e:
        print(f"Data Error: {e}")
    except ImportError:
        print("Error: Missing library. Please install plotly using 'pip install plotly'")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    main()
```

    Loading data from ./data_raw\prices_raw.csv...
    Found tickers: ['AAPL', 'MSFT', 'NVDA', 'GOOGL', 'AMZN', 'META', 'TSLA']
    Calculating correlation matrix...
    Correlation matrix saved to: ./data_raw\correlation_matrix.csv
    Generating interactive heatmap...
    



    Interactive heatmap saved to: ./output\correlation_heatmap.html
    
    --- Diversification Analysis ---
    Average Pairwise Correlation: 0.5180
    Assessment: MODERATE Correlation. Some diversification benefits.


[correlation_heatmap.html](output/correlation_heatmap.html)
    

分析「七姐妹」内部的分散化效果？    

答：

一、总体结论：分散化效果有限（中等偏弱）

从整体数据来看，这7只股票之间的相关系数普遍处于 0.41 到 0.63 之间。

中度相关：大部分相关系数集中在 0.5 - 0.6 区间。在投资组合理论中，低于 0.3 才被视为具有较好的分散化效果，而高于 0.7 则视为高度联动。目前的数值表明，虽然它们不是完全同步（如指数基金内部那样接近 1.0），但行业集中度风险依然很高。持有这7只股票并不能有效规避科技板块的系统性风险。

二、具体数据分析

A. 核心科技股的高联动性（分散化效果最差的部分）

以下几对股票的相关性最高，说明它们的业务模式、投资者群体或受宏观因素（如利率、AI叙事）的影响非常相似：

| 股票对 | 相关系数 | 说明 |
|:---|---:|:---|
| MSFT & AMZN | 0.626 | 两者在云计算领域（Azure vs AWS）是直接竞争对手，且都是大型综合科技巨头，走势高度一致 |
| GOOGL & AMZN | 0.614 | 同样受到数字广告和云服务市场的双重驱动 |
| MSFT & NVDA | 0.608 | 反映了 AI 基础设施建设的紧密捆绑关系 |

启示：同时持有 MSFT、AMZN 和 GOOGL 带来的边际分散化收益很低，因为它们本质上是在押注相同的宏观科技趋势。

B. TSLA (特斯拉) 是主要的分散化来源

最低相关性：TSLA 与其他所有股票的相关性都是最低的。

| 股票对 | 相关系数 | 排名 |
|:---|---:|:---|
| TSLA & META | 0.341 | 全表最低 |
| TSLA & MSFT | 0.411 | 较低 |
| TSLA & GOOGL | 0.417 | 较低 |

原因：特斯拉不仅被视为科技股，更被视为汽车股和消费品股。其股价受电动车交付量、马斯克个人言论、汽车行业周期等非纯软件/互联网因素影响较大。

启示：在这7只股票的组合中，TSLA 提供了最大的特异性风险分散效果。如果科技股回调，TSLA 可能因为汽车行业的独立逻辑而表现不同（尽管它波动性极大）。

C. AAPL (苹果) 与 META (Meta) 的相对独立性

| 股票对 | 相关系数 | 说明 |
|:---|---:|:---|
| AAPL & META | 0.463 | 除 TSLA 涉及的对子外，相关性较低的一组 |
| NVDA & AAPL | 0.500 | 刚好处于中位数，说明虽然都在科技圈，但硬件供应链（Apple）与AI芯片（Nvidia）的周期并不完全重合 |

原因：苹果主要依赖硬件销售和生态系统服务，而 Meta 几乎完全依赖数字广告。两者的收入驱动因素差异较大。

三、平均相关性分析

我们可以粗略计算每只股票与其他6只股票的平均相关系数，来评估其在组合中的"独特性"：

| 股票 | 平均相关系数 | 独特性评价 |
|:---|---:|:---|
| TSLA | 0.426 | 最独特，分散化贡献最大 |
| META | 0.495 | 较独特 |
| AAPL | 0.522 | 中等 |
| NVDA | 0.521 | 中等 |
| GOOGL | 0.523 | 中等 |
| MSFT | 0.546 | 较低 |
| AMZN | 0.559 | 最跟随大盘/其他科技股，分散化贡献最小 |

四、投资建议与总结

1. 不要误以为"买了7只就是分散"

虽然你持有7家公司，但它们都属于成长型科技。如果美联储加息或科技监管收紧，这7只股票很可能同时下跌。这个组合的 Beta 值（市场敏感度）依然很高。

2. TSLA 的双刃剑作用

TSLA 提供了最好的分散化效果（低相关性），但它也是波动率最高的股票。它的低相关性部分源于其不可预测性，而非稳定的低风险属性。

3. 如何真正提高分散化

如果你希望降低风险，仅在这7只股票内部调整权重效果有限。建议引入与科技股相关性低甚至负相关的资产，例如：

- 价值股/传统行业：如金融 (JPM)、能源 (XOM)、医疗 (JNJ)
- 固定收益：国债或高等级公司债
- 小盘股：罗素2000指数成分股，其驱动因素与 mega-cap tech 不同

根据此相关矩阵，这7只股票构成的组合是一个高β、高集中度的科技成长组合。它们之间的分散化效果不足以抵消行业系统性风险，但在科技板块内部，TSLA 和 META 提供了一定的差异化缓冲。

