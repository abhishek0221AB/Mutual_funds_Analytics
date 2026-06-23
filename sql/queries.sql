-- ============================================================
-- queries.sql
-- Bluestock Fintech — Mutual Fund Analytics Capstone
-- Day 2: 10 Analytical SQL Queries
-- ============================================================

-- Query 1: Top 5 funds by AUM
SELECT
    f.fund_house,
    f.scheme_name,
    a.aum_crore
FROM fact_aum a
JOIN dim_fund f ON a.fund_house = f.fund_house
ORDER BY a.aum_crore DESC
LIMIT 5;

-- Query 2: Average NAV per month for each fund
SELECT
    amfi_code,
    strftime('%Y-%m', nav_date) AS month,
    ROUND(AVG(nav), 2)          AS avg_nav
FROM fact_nav
GROUP BY amfi_code, month
ORDER BY amfi_code, month;

-- Query 3: SIP inflow YoY growth
SELECT
    month,
    sip_inflow_crore,
    ROUND(yoy_growth_pct, 2) AS yoy_growth_pct
FROM fact_sip_industry
WHERE yoy_growth_pct > 0
ORDER BY month;

-- Query 4: Total transactions by state
SELECT
    state,
    COUNT(*)            AS total_transactions,
    ROUND(SUM(amount_inr) / 1000000.0, 2) AS total_amount_millions
FROM fact_transactions
GROUP BY state
ORDER BY total_transactions DESC;

-- Query 5: Funds with expense_ratio < 1%
SELECT
    amfi_code,
    scheme_name,
    fund_house,
    expense_ratio_pct
FROM dim_fund
WHERE expense_ratio_pct < 1.0
ORDER BY expense_ratio_pct ASC;

-- Query 6: Best performing funds by 3-year return
SELECT
    f.scheme_name,
    f.fund_house,
    f.category,
    p.return_3yr_pct,
    p.sharpe_ratio
FROM fact_performance p
JOIN dim_fund f ON p.amfi_code = f.amfi_code
ORDER BY p.return_3yr_pct DESC
LIMIT 10;

-- Query 7: Transaction split by type (SIP vs Lumpsum vs Redemption)
SELECT
    transaction_type,
    COUNT(*)                                AS total_count,
    ROUND(SUM(amount_inr) / 1000000.0, 2)  AS total_amount_millions,
    ROUND(AVG(amount_inr), 2)              AS avg_amount
FROM fact_transactions
GROUP BY transaction_type
ORDER BY total_count DESC;

-- Query 8: Top 5 states by average SIP amount
SELECT
    state,
    ROUND(AVG(amount_inr), 2) AS avg_sip_amount,
    COUNT(*)                   AS total_sip_count
FROM fact_transactions
WHERE transaction_type = 'Sip'
GROUP BY state
ORDER BY avg_sip_amount DESC
LIMIT 5;

-- Query 9: Funds with highest alpha (outperforming benchmark)
SELECT
    f.scheme_name,
    f.fund_house,
    f.category,
    p.alpha,
    p.beta,
    p.return_3yr_pct,
    p.benchmark_3yr_pct
FROM fact_performance p
JOIN dim_fund f ON p.amfi_code = f.amfi_code
ORDER BY p.alpha DESC
LIMIT 10;

-- Query 10: Monthly SIP inflow trend (highest 5 months)
SELECT
    month,
    sip_inflow_crore,
    active_sip_accounts_crore
FROM fact_sip_industry
ORDER BY sip_inflow_crore DESC
LIMIT 5;