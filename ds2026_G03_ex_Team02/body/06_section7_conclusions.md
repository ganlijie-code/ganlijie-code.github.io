# 第7节 进阶分析结论（数据—图形—结论）

## 数据官方来源

- 长鑫财务：上交所招股说明书 PDF → `data/ipo/cxkj_financials.csv`

- IPO 事件日：安徽证监局辅导备案 `cxkj_ipo_tutor.csv`、上交所受理 `cxkj_register.csv`

- A 股行情/指数：akshare（新浪/交易所指数）→ `data/stock/`, `data/index/`

- 美股 MU 年报：akshare `mu_annual_us.csv`（SEC 披露汇总）

- 同业财务：akshare 同花顺财务摘要 `finance_ths_*.csv`


## 7.1 CAPM 回归结论

name     beta       r2  beta_pvalue
兆易创新 1.379771 0.238048 5.047312e-93
澜起科技 1.308004 0.205304 6.392440e-79
北京君正 1.425673 0.214674 6.752838e-83
中芯国际 1.042556 0.188715 6.877686e-66
北方华创 1.218371 0.195816 6.093787e-75


**结论**：存储产业链公司 Beta 多显著大于 1（p<0.05），系统性风险高于市场；相对科创50 的 Beta 见 `fig7_capm_beta_dual_benchmark.png`。


## 7.2 事件研究结论

                 event  asset  car_event_end_pct  ar_mean_pct  ar_tstat  ar_pvalue est_window  n_ar
 科创板 IPO 受理（上交所）|半导体指数  半导体指数           6.453236     0.496403  1.537695   0.150063   -120~-21    13
科创板 IPO 受理（上交所）|存储同业等权 存储同业等权           5.080757     0.390827  0.669756   0.515694   -120~-21    13
 辅导工作完成（安徽证监局备案）|半导体指数  半导体指数          -0.507641    -0.033843 -0.116557   0.908866   -120~-21    15
辅导工作完成（安徽证监局备案）|存储同业等权 存储同业等权          -0.558093    -0.037206 -0.116245   0.909109   -120~-21    15


**结论**：以沪深300 为市场模型的 CAR 见 `fig7_event_study_car_detailed.png`；若事件窗 AR 的 p>0.05，则异常收益**统计上不显著**，IPO 消息或已被预期。


## 7.3 预测与财务回归

- 营收 OLS 与 95% CI：`fig7_revenue_ols_forecast.png`, `revenue_forecast_ols_ci.csv`

- 归母净利~营收：`fig7_profit_revenue_regression.png`（上交所招股说明书（上会稿 2026-05-20） 年报样本，解释力有限）

- 长鑫 vs 美光营收：`fig7_cxmt_mu_revenue_regression.png`


## 7.4 同业 PS 回归隐含市值

 cxmt_revenue_2024_bn  implied_mcap_bn_from_peer_ps  implied_ps_ratio  model_r2  ln_rev_coef
           241.782487                   1635.782084          6.765511  0.081503     0.229532


**结论**：在可比公司历史 PS—收入对数关系下，长鑫 2024 收入对应**模型隐含市值**见上表；须与一级市场 1282—1584 亿报道区间交叉验证。
