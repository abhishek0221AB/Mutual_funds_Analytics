-- ============================================================
-- schema.sql
-- Bluestock Fintech — Mutual Fund Analytics Capstone
-- 5-Table Star Schema for SQLite
-- ============================================================

-- Drop tables if they exist (for clean re-runs)
DROP TABLE IF EXISTS fact_performance;
DROP TABLE IF EXISTS fact_transactions;
DROP TABLE IF EXISTS fact_nav;
DROP TABLE IF EXISTS fact_aum;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_fund;

-- ============================================================
-- DIMENSION TABLE 1 — dim_fund
-- Master list of all 40 mutual fund schemes
-- ============================================================
CREATE TABLE dim_fund (
    amfi_code           INTEGER     PRIMARY KEY,
    fund_house          TEXT        NOT NULL,
    scheme_name         TEXT        NOT NULL,
    category            TEXT,
    sub_category        TEXT,
    plan                TEXT,
    launch_date         DATE,
    benchmark           TEXT,
    expense_ratio_pct   REAL,
    exit_load_pct       REAL,
    min_sip_amount      REAL,
    min_lumpsum_amount  REAL,
    fund_manager        TEXT,
    risk_category       TEXT,
    sebi_category_code  TEXT
);



-- ============================================================
-- FACT TABLE 1 — fact_nav
-- Daily NAV for all schemes
-- ============================================================
CREATE TABLE fact_nav (
    id              INTEGER     PRIMARY KEY AUTOINCREMENT,
    amfi_code       INTEGER     NOT NULL,
    nav_date        DATE        NOT NULL,
    nav             REAL        NOT NULL,
    daily_return    REAL,
    FOREIGN KEY (amfi_code) REFERENCES dim_fund(amfi_code)
);

-- ============================================================
-- FACT TABLE 2 — fact_transactions
-- Investor SIP/Lumpsum/Redemption transactions
-- ============================================================
CREATE TABLE fact_transactions (
    id                  INTEGER     PRIMARY KEY AUTOINCREMENT,
    investor_id         TEXT        NOT NULL,
    transaction_date    DATE        NOT NULL,
    amfi_code           INTEGER     NOT NULL,
    transaction_type    TEXT        NOT NULL,   -- SIP / Lumpsum / Redemption
    amount_inr          REAL        NOT NULL,
    state               TEXT,
    city                TEXT,
    city_tier           TEXT,                   -- T30 / B30
    age_group           TEXT,
    gender              TEXT,
    annual_income_lakh  REAL,
    payment_mode        TEXT,
    kyc_status          TEXT,
    FOREIGN KEY (amfi_code) REFERENCES dim_fund(amfi_code)
);

-- ============================================================
-- FACT TABLE 3 — fact_performance
-- Risk & return metrics per scheme
-- ============================================================
CREATE TABLE fact_performance (
    id                  INTEGER     PRIMARY KEY AUTOINCREMENT,
    amfi_code           INTEGER     NOT NULL,
    return_1yr_pct      REAL,
    return_3yr_pct      REAL,
    return_5yr_pct      REAL,
    benchmark_3yr_pct   REAL,
    alpha               REAL,
    beta                REAL,
    sharpe_ratio        REAL,
    sortino_ratio       REAL,
    std_dev_ann_pct     REAL,
    max_drawdown_pct    REAL,
    morningstar_rating  INTEGER,
    negative_sharpe     INTEGER,                -- 1 = flagged negative Sharpe
    FOREIGN KEY (amfi_code) REFERENCES dim_fund(amfi_code)
);

-- ============================================================
-- FACT TABLE 4 — fact_aum
-- Quarterly AUM by fund house
-- ============================================================
CREATE TABLE fact_aum (
    id          INTEGER     PRIMARY KEY AUTOINCREMENT,
    fund_house  TEXT        NOT NULL,
    date        DATE        NOT NULL,
    aum_crore   REAL,
    num_schemes INTEGER
);

-- ============================================================
-- FACT TABLE 5 — fact_sip_industry
-- Monthly industry-level SIP inflow data
-- ============================================================
CREATE TABLE fact_sip_industry (
    id                      INTEGER     PRIMARY KEY AUTOINCREMENT,
    month                   TEXT        NOT NULL,
    sip_inflow_crore        REAL,
    active_sip_accounts_crore REAL,
    new_sip_accounts_lakh   REAL,
    sip_aum_lakh_crore      REAL,
    yoy_growth_pct          REAL
);

-- ============================================================
-- INDEXES for fast query performance
-- ============================================================
CREATE INDEX idx_nav_amfi    ON fact_nav(amfi_code);
CREATE INDEX idx_nav_date    ON fact_nav(nav_date);
CREATE INDEX idx_txn_amfi    ON fact_transactions(amfi_code);
CREATE INDEX idx_txn_date    ON fact_transactions(transaction_date);
CREATE INDEX idx_txn_state   ON fact_transactions(state);
CREATE INDEX idx_perf_amfi   ON fact_performance(amfi_code);