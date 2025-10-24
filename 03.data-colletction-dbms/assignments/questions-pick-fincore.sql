-- Problem 16 – Monthly Asset Inflows/Outflows

-- creates a monthly report of deposits, withdrawals, and net cash flow per account.
-- adds running balance and month-over-month growth rate to track liquidity trends and performance over time.





-- Create a monthly report showing total deposits, withdrawals, net cash flow, and running balance for all accounts.
-- Show month-over-month growth rate.

SELECT
    account_id,
    year,
    month,
    total_deposits,
    total_withdrawals,
    net_cash_flow,
    SUM(net_cash_flow) OVER (PARTITION BY account_id ORDER BY year, month) AS running_balance,
    net_cash_flow / NULLIF(LAG(net_cash_flow) OVER (PARTITION BY account_id ORDER BY year, month), 0) AS month_over_month_growth
FROM (
    SELECT
        account_id,
        YEAR(movement_date) AS year,
        MONTH(movement_date) AS month,
        SUM(CASE WHEN movement_type = 'Deposit' THEN amount ELSE 0 END) AS total_deposits,
        SUM(CASE WHEN movement_type = 'Withdrawal' THEN amount ELSE 0 END) AS total_withdrawals,
        SUM(CASE WHEN movement_type = 'Deposit' THEN amount ELSE 0 END) - SUM(CASE WHEN movement_type = 'Withdrawal' THEN amount ELSE 0 END) AS net_cash_flow
    FROM cash_movements
    GROUP BY account_id, YEAR(movement_date), MONTH(movement_date)
) AS monthly_stats;

-- Problem 17: Quarter-over-Quarter Trading Volume Trends (2024) (already included earlier)
WITH QuarterlyStats AS (
    SELECT
        QUARTER(transaction_date) AS quarter,
        SUM(total_amount) AS total_transaction_value,
        COUNT(*) AS number_of_trades,
        AVG(total_amount) AS average_trade_size
    FROM transactions
    WHERE YEAR(transaction_date) = 2024
    GROUP BY QUARTER(transaction_date)
)
SELECT
    quarter,
    total_transaction_value,
    number_of_trades,
    average_trade_size,
    (total_transaction_value - LAG(total_transaction_value) OVER (ORDER BY quarter)) / LAG(total_transaction_value) OVER (ORDER BY quarter) AS qoq_value_change_pct,
    (number_of_trades - LAG(number_of_trades) OVER (ORDER BY quarter)) / LAG(number_of_trades) OVER (ORDER BY quarter) AS qoq_trades_change_pct,
    (average_trade_size - LAG(average_trade_size) OVER (ORDER BY quarter)) / LAG(average_trade_size) OVER (ORDER BY quarter) AS qoq_avg_trade_size_change_pct
FROM QuarterlyStats;

-- Problem 18: Seasonal Trading Patterns (avg monthly volume & peak months)
WITH monthly_vol AS (
    SELECT security_id, MONTH(transaction_date) AS month, SUM(quantity) AS total_volume
    FROM transactions
    GROUP BY security_id, MONTH(transaction_date)
), avg_month AS (
    SELECT security_id, AVG(total_volume) AS avg_monthly_volume FROM monthly_vol GROUP BY security_id
), peak AS (
    SELECT m.security_id, m.month, m.total_volume,
           RANK() OVER (PARTITION BY m.security_id ORDER BY m.total_volume DESC) AS rnk
    FROM monthly_vol m
)
SELECT s.security_id, s.security_symbol, p.month AS peak_month, p.total_volume AS peak_volume, am.avg_monthly_volume
FROM peak p
JOIN avg_month am ON p.security_id = am.security_id
JOIN securities s ON p.security_id = s.security_id
WHERE p.rnk = 1;

-- Problem 19: Client Lifecycle Analysis (segments by tenure)
SELECT
    CASE
      WHEN months_since_reg BETWEEN 0 AND 6 THEN 'New'
      WHEN months_since_reg BETWEEN 7 AND 24 THEN 'Growing'
      WHEN months_since_reg BETWEEN 25 AND 48 THEN 'Established'
      ELSE 'Mature' END AS segment,
    COUNT(*) AS num_clients,
    ROUND(AVG(a.current_balance),2) AS avg_account_balance,
    ROUND(AVG(tx.tx_count),2) AS avg_tx_frequency,
    ROUND(AVG(ps_count),2) AS avg_product_holdings
FROM (
    SELECT c.client_id, DATEDIFF(CURRENT_DATE, c.registration_date)/30 AS months_since_reg
    FROM clients c
) cl
LEFT JOIN accounts a ON cl.client_id = a.client_id
LEFT JOIN (
    SELECT account_id, COUNT(*) AS tx_count FROM transactions GROUP BY account_id
) tx ON a.account_id = tx.account_id
LEFT JOIN (
    SELECT account_id, COUNT(*) AS ps_count FROM product_subscriptions GROUP BY account_id
) ps ON a.account_id = ps.account_id
GROUP BY segment;

-- Problem 20: Dividend Income Forecast for Q4 2024 (per account)
-- Simple forecast: average quarterly dividend per share * current quantity * expected payout (uses historical dividends table)


WITH HistoricalDividends AS (
    SELECT
        ph.account_id,
        d.security_id,
        AVG(d.dividend_per_share) AS avg_dividend_per_share
    FROM portfolio_holdings ph
    JOIN dividends d ON ph.security_id = d.security_id
    WHERE d.ex_dividend_date < '2024-10-01'
    GROUP BY ph.account_id, d.security_id
),
Q4Holdings AS (
    SELECT
        ph.account_id,
        ph.security_id,
        ph.quantity
    FROM portfolio_holdings ph
    WHERE ph.holding_date BETWEEN '2024-10-01' AND '2024-12-31'
)
SELECT
    qh.account_id,
    qh.security_id,
    qh.quantity,
    hd.avg_dividend_per_share,
    (qh.quantity * hd.avg_dividend_per_share) AS forecasted_dividend_income
FROM Q4Holdings qh
JOIN HistoricalDividends hd ON qh.account_id = hd.account_id AND qh.security_id = hd.security_id;


-- Problem 21: Cross-Border Transaction Analysis (FX impact)
-- Identify transactions where account.currency != security trade currency (assuming securities.exchange implies currency; we'll use exchange_rates table to get rate between account.currency and security.currency if available)
-- For simplicity, assume security trading currency is USD for exchanges 'NYSE','NASDAQ', else use account currency
WITH acct_cur AS (
    SELECT a.account_id, a.currency AS acct_currency
    FROM accounts a
), sec_cur AS (
    SELECT s.security_id, CASE WHEN s.exchange IN ('NYSE','NASDAQ') THEN 'USD' ELSE 'USD' END AS sec_currency
    FROM securities s
), tx_fx AS (
    SELECT t.transaction_id, t.account_id, t.security_id, t.total_amount, ac.acct_currency, sc.sec_currency
    FROM transactions t
    JOIN acct_cur ac ON t.account_id = ac.account_id
    JOIN sec_cur sc ON t.security_id = sc.security_id
    WHERE ac.acct_currency <> sc.sec_currency
)
SELECT tx.transaction_id, tx.account_id, tx.security_id, tx.total_amount,
       er.exchange_rate AS acct_to_sec_rate,
       ROUND(tx.total_amount * COALESCE(er.exchange_rate,1),2) AS amount_in_security_currency
FROM tx_fx tx
LEFT JOIN exchange_rates er ON er.base_currency = tx.acct_currency AND er.quote_currency = tx.sec_currency
ORDER BY tx.account_id;

-- Problem 22: Relationship Manager Performance Dashboard
SELECT rm.manager_id, rm.manager_name,
       COALESCE(SUM(ph.quantity * ph.current_price),0) AS total_aum,
       COUNT(DISTINCT CASE WHEN c.is_active THEN c.client_id END) AS active_clients,
       COALESCE(SUM(t.commission),0) AS ytd_revenue_generated,
       ROUND(AVG(ep.client_satisfaction),2) AS avg_client_satisfaction,
       SUM(CASE WHEN ce.severity IN ('High','Critical') THEN 1 ELSE 0 END) AS compliance_issues
FROM relationship_managers rm
LEFT JOIN clients c ON c.relationship_manager_id = rm.manager_id
LEFT JOIN accounts a ON a.client_id = c.client_id
LEFT JOIN portfolio_holdings ph ON ph.account_id = a.account_id
LEFT JOIN transactions t ON t.account_id = a.account_id AND YEAR(t.transaction_date) = YEAR(CURRENT_DATE)
LEFT JOIN employee_performance ep ON ep.employee_id = rm.manager_id
LEFT JOIN compliance_events ce ON ce.account_id = a.account_id
GROUP BY rm.manager_id, rm.manager_name;

-- Problem 23: Product Subscription Analysis (per product)
SELECT fp.product_id, fp.product_name,
       COUNT(ps.subscription_id) AS total_subscriptions,
       SUM(ps.amount_invested) AS total_aum,
       AVG(DATEDIFF(CURRENT_DATE, ps.subscription_date)) AS avg_holding_days,
       -- retention: clients with >1 subscription to same product over time / total unique clients
       ROUND(COUNT(DISTINCT ps.account_id)/NULLIF(COUNT(ps.subscription_id),0)*100,2) AS client_retention_proxy
FROM financial_products fp
LEFT JOIN product_subscriptions ps ON fp.product_id = ps.product_id
GROUP BY fp.product_id, fp.product_name;

-- Problem 24: Branch Performance Comparison (via relationship_manager -> branch mapping assumed)
-- Assuming relationship_managers.region maps to branch city/country; if branches table exists, need mapping. We'll approximate by manager region = branch_name
SELECT b.branch_id, b.branch_name,
       SUM(CASE WHEN cm.movement_type IN ('Deposit','Transfer In') THEN cm.amount ELSE 0 END) AS total_deposits,
       SUM(CASE WHEN t.transaction_type IN ('Buy','Sell') THEN t.total_amount ELSE 0 END) AS transaction_volume,
       SUM(CASE WHEN l.loan_type IS NOT NULL THEN l.loan_amount ELSE 0 END) AS loan_disbursements,
       SUM(COALESCE(t.commission,0)) AS total_commission
FROM branches b
LEFT JOIN relationship_managers rm ON rm.region = b.city
LEFT JOIN clients c ON c.relationship_manager_id = rm.manager_id
LEFT JOIN accounts a ON a.client_id = c.client_id
LEFT JOIN cash_movements cm ON cm.account_id = a.account_id
LEFT JOIN transactions t ON t.account_id = a.account_id
LEFT JOIN loans l ON l.client_id = c.client_id
GROUP BY b.branch_id, b.branch_name
ORDER BY total_deposits DESC;







-- Problem 17 – Quarter-over-Quarter Trading Volume Trends (2024)

-- analyzes trading activity by quarter for 2024.
-- computes total transaction value, number of trades, average trade size, and quarter-over-quarter % changes to measure market activity growth.

-- ⸻

-- Problem 18 – Seasonal Trading Patterns

-- identifies seasonal trading trends by calculating average monthly volumes and detecting peak trading months for each security.
-- helps in recognizing cyclical behavior and high-activity periods.

-- ⸻

-- Problem 19 – Client Lifecycle Analysis

-- segments clients based on tenure (New, Growing, Established, Mature).
-- provides insights on average balance, transaction frequency, and product holdings for each segment — useful for client retention and targeting.

-- ⸻

-- Problem 20 – Dividend Income Forecast (Q4 2024)

-- forecasts expected dividend income for Q4 2024 by multiplying average historical dividend per share with current holdings.
-- helps anticipate quarterly income streams for accounts.

-- ⸻

-- Problem 21 – Cross-Border Transaction Analysis (FX Impact)

-- detects transactions involving different currencies between accounts and securities.
-- calculates FX-adjusted transaction amounts using exchange rates to evaluate foreign exchange exposure and conversion impact.

-- ⸻

-- Problem 22 – Relationship Manager Performance Dashboard

-- creates a performance overview for each relationship manager.
-- shows total AUM, active clients, revenue, client satisfaction, and compliance issues — supporting performance reviews and KPI tracking.

-- ⸻

-- Problem 23 – Product Subscription Analysis

-- analyzes performance of each financial product.
-- includes total subscriptions, total AUM, average holding days, and retention proxy, helping assess product popularity and client loyalty.

-- ⸻

-- Problem 24 – Branch Performance Comparison

-- compares branch-level performance by aggregating deposits, transaction volumes, loan disbursements, and commissions.
-- ranks branches to identify top-performing regions and areas needing improvement.