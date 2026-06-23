# Data Dictionary — Bluestock MF Capstone

_Auto-generated after cleaning. Reflects processed dataset schemas._

**Total datasets:** 10

---

## 01_fund_master

**Source:** AMFI India / mfapi.in

**Rows:** 40  |  **Columns:** 15


| Column | Dtype | Description |
|--------|-------|-------------|
| `amfi_code` | int64 | AMFI unique scheme code (PK / FK) |
| `fund_house` | str | AMC name (e.g. SBI Mutual Fund) |
| `scheme_name` | str | Full official AMFI scheme name |
| `category` | str | Equity / Debt / Hybrid |
| `sub_category` | str | Large Cap / Mid Cap / Small Cap / Liquid etc. |
| `plan` | str | Regular or Direct |
| `launch_date` | str | Fund launch date (YYYY-MM-DD) |
| `benchmark` | str | Official benchmark index |
| `expense_ratio_pct` | float64 | Annual expense ratio in % (0.1–2.5) |
| `exit_load_pct` | float64 | Exit load percentage |
| `min_sip_amount` | int64 | — |
| `min_lumpsum_amount` | int64 | — |
| `fund_manager` | str | Primary fund manager name |
| `risk_category` | str | SEBI risk: Low / Moderate / High / Very High |
| `sebi_category_code` | str | Internal SEBI code (EC01, DC01, etc.) |


## 02_nav_history

**Source:** mfapi.in REST API (real anchor values)

**Rows:** 46,000  |  **Columns:** 3


| Column | Dtype | Description |
|--------|-------|-------------|
| `amfi_code` | int64 | AMFI unique scheme code (PK / FK) |
| `date` | str | NAV / transaction date (business days only) |
| `nav` | float64 | Net Asset Value in Rs. |


## 03_aum_by_fund_house

**Source:** AMFI Quarterly Reports

**Rows:** 90  |  **Columns:** 5


| Column | Dtype | Description |
|--------|-------|-------------|
| `date` | str | NAV / transaction date (business days only) |
| `fund_house` | str | AMC name (e.g. SBI Mutual Fund) |
| `aum_lakh_crore` | float64 | — |
| `aum_crore` | int64 | AUM in Rs. crore |
| `num_schemes` | int64 | Number of schemes under that fund house |


## 04_monthly_sip_inflows

**Source:** AMFI Monthly Notes

**Rows:** 48  |  **Columns:** 6


| Column | Dtype | Description |
|--------|-------|-------------|
| `month` | str | Month in YYYY-MM format |
| `sip_inflow_crore` | int64 | Total SIP inflows in Rs. crore (AMFI) |
| `active_sip_accounts_crore` | float64 | Active SIP accounts in crore |
| `new_sip_accounts_lakh` | float64 | New SIP registrations in lakh |
| `sip_aum_lakh_crore` | float64 | SIP AUM in Rs. lakh crore |
| `yoy_growth_pct` | float64 | YoY growth % in SIP inflows (computed) |


## 05_category_inflows

**Source:** AMFI Monthly Notes / FY2024-25

**Rows:** 144  |  **Columns:** 3


| Column | Dtype | Description |
|--------|-------|-------------|
| `month` | str | Month in YYYY-MM format |
| `category` | str | Equity / Debt / Hybrid |
| `net_inflow_crore` | float64 | Net inflow into category in Rs. crore |


## 06_industry_folio_count

**Source:** AMFI published milestones

**Rows:** 21  |  **Columns:** 6


| Column | Dtype | Description |
|--------|-------|-------------|
| `month` | str | Month in YYYY-MM format |
| `total_folios_crore` | float64 | — |
| `equity_folios_crore` | float64 | — |
| `debt_folios_crore` | float64 | — |
| `hybrid_folios_crore` | float64 | — |
| `others_folios_crore` | float64 | — |


## 07_scheme_performance

**Source:** Computed from nav_history + benchmark_indices

**Rows:** 40  |  **Columns:** 19


| Column | Dtype | Description |
|--------|-------|-------------|
| `amfi_code` | int64 | AMFI unique scheme code (PK / FK) |
| `scheme_name` | str | Full official AMFI scheme name |
| `fund_house` | str | AMC name (e.g. SBI Mutual Fund) |
| `category` | str | Equity / Debt / Hybrid |
| `plan` | str | Regular or Direct |
| `return_1yr_pct` | float64 | 1-year absolute return % |
| `return_3yr_pct` | float64 | 3-year CAGR % |
| `return_5yr_pct` | float64 | 5-year CAGR % |
| `benchmark_3yr_pct` | float64 | — |
| `alpha` | float64 | Return above benchmark (return_3yr - benchmark_3yr) |
| `beta` | float64 | Market sensitivity (1.0 = same as market) |
| `sharpe_ratio` | float64 | Risk-adjusted return (higher = better, >1 is good) |
| `sortino_ratio` | float64 | Like Sharpe but only penalises downside vol |
| `std_dev_ann_pct` | float64 | Annualised std dev of daily returns % |
| `max_drawdown_pct` | float64 | Worst peak-to-trough decline (negative) |
| `aum_crore` | int64 | AUM in Rs. crore |
| `expense_ratio_pct` | float64 | Annual expense ratio in % (0.1–2.5) |
| `morningstar_rating` | int64 | — |
| `risk_grade` | str | — |


## 08_investor_transactions

**Source:** Synthetic (real geographic/demographic distributions)

**Rows:** 32,778  |  **Columns:** 13


| Column | Dtype | Description |
|--------|-------|-------------|
| `investor_id` | str | Unique investor ID (INV000001–INV005000) |
| `transaction_date` | str | — |
| `amfi_code` | int64 | AMFI unique scheme code (PK / FK) |
| `transaction_type` | str | SIP / Lumpsum / Redemption |
| `amount_inr` | int64 | Transaction amount in Indian Rupees |
| `state` | str | Investor's Indian state |
| `city` | str | — |
| `city_tier` | str | T30 (Top 30 cities) or B30 (Beyond Top 30) |
| `age_group` | str | 18-25 / 26-35 / 36-45 / 46-55 / 56+ |
| `gender` | str | — |
| `annual_income_lakh` | float64 | — |
| `payment_mode` | str | UPI / Net Banking / Mandate / Cheque |
| `kyc_status` | str | Verified (~92%) or Pending (~8%) |


## 09_portfolio_holdings

**Source:** AMFI / Fund factsheets Dec 2025

**Rows:** 322  |  **Columns:** 8


| Column | Dtype | Description |
|--------|-------|-------------|
| `amfi_code` | int64 | AMFI unique scheme code (PK / FK) |
| `stock_symbol` | str | NSE/BSE ticker symbol of holding |
| `stock_name` | str | — |
| `sector` | str | Sector of the stock (e.g. Banking, IT) |
| `weight_pct` | float64 | Portfolio weight % of this stock |
| `market_value_cr` | float64 | — |
| `current_price_inr` | float64 | — |
| `portfolio_date` | str | — |


## 10_benchmark_indices

**Source:** NSE India / BSE India Bhavcopy

**Rows:** 8,050  |  **Columns:** 3


| Column | Dtype | Description |
|--------|-------|-------------|
| `date` | str | NAV / transaction date (business days only) |
| `index_name` | str | Benchmark index name (e.g. Nifty 50) |
| `close_value` | float64 | Closing index value for that date |

