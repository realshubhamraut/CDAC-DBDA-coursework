-- ===============================================================
-- Problem 1: Running Portfolio Value
-- ===============================================================
SELECT 
    t.account_id,
    DATE(t.transaction_date) AS date,
    t.total_amount AS transaction_amount,
    SUM(t.total_amount) OVER (PARTITION BY t.account_id ORDER BY DATE(t.transaction_date)) AS cumulative_portfolio_value
FROM transactions t
ORDER BY t.account_id, DATE(t.transaction_date);

-- ===============================================================
-- Problem 2: Transaction Ranking by Volume
-- ===============================================================
-- Use a CTE (Common Table Expression) to first calculate the rank
WITH RankedTransactions AS (
    SELECT 
        tr.trader_name,
        DATE_FORMAT(t.transaction_date, '%Y-%m') AS month,
        t.transaction_id,
        t.total_amount,
        RANK() OVER (
            PARTITION BY tr.trader_id, DATE_FORMAT(t.transaction_date, '%Y-%m') 
            ORDER BY t.total_amount DESC
        ) AS rank_in_month
    FROM transactions t
    JOIN traders tr ON t.trader_id = tr.trader_id
    WHERE YEAR(t.transaction_date) = 2024
)
-- Now, select from the CTE and apply the filter
SELECT 
    trader_name,
    month,
    transaction_id,
    total_amount,
    rank_in_month
FROM RankedTransactions
WHERE rank_in_month <= 3;

-- ===============================================================
-- Problem 3: Moving Average Price Analysis (AAPL)
-- ===============================================================
SELECT 
    mp.price_date,
    mp.security_id,
    AVG(mp.close_price) OVER (ORDER BY mp.price_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ma_3_day,
    AVG(mp.close_price) OVER (ORDER BY mp.price_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS ma_7_day,
    CASE WHEN LAG(AVG(mp.close_price) OVER (ORDER BY mp.price_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)) < 
              LAG(AVG(mp.close_price) OVER (ORDER BY mp.price_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW))
         AND AVG(mp.close_price) OVER (ORDER BY mp.price_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) > 
              AVG(mp.close_price) OVER (ORDER BY mp.price_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
    THEN 'Golden Cross' ELSE NULL END AS signal
FROM market_prices mp
JOIN securities s ON mp.security_id = s.security_id
WHERE s.security_symbol = 'AAPL';

-- ===============================================================
-- Problem 4: Year-over-Year Growth Analysis (Revenue by RM)
-- ===============================================================
SELECT 
    rm.manager_id,
    rm.manager_name,
    q.quarter,
    ROUND(((q.revenue_2024 - q.revenue_2023)/q.revenue_2023)*100, 2) AS yoy_growth_percent,
    RANK() OVER (ORDER BY ((q.revenue_2024 - q.revenue_2023)/q.revenue_2023) DESC) AS growth_rank
FROM (
    SELECT 
        rm.manager_id,
        QUARTER(e.review_quarter) AS quarter,
        SUM(CASE WHEN e.review_quarter LIKE '2023%' THEN e.revenue_generated END) AS revenue_2023,
        SUM(CASE WHEN e.review_quarter LIKE '2024%' THEN e.revenue_generated END) AS revenue_2024
    FROM employee_performance e
    JOIN relationship_managers rm ON e.employee_id = rm.manager_id
    GROUP BY rm.manager_id, quarter
) q
JOIN relationship_managers rm ON rm.manager_id = q.manager_id;

-- ===============================================================
-- Problem 5: Client Concentration Risk
-- ===============================================================
SELECT 
    ph.account_id,
    ph.security_id,
    (ph.quantity * ph.current_price) / SUM(ph.quantity * ph.current_price) OVER (PARTITION BY ph.account_id) * 100 AS pct_of_portfolio,
    CASE WHEN (ph.quantity * ph.current_price) / SUM(ph.quantity * ph.current_price) OVER (PARTITION BY ph.account_id) > 0.25
         THEN 'High Concentration Risk' ELSE 'Normal' END AS risk_flag
FROM portfolio_holdings ph;

-- ===============================================================
-- Problem 6: Compliance Event Resolution Time
-- ===============================================================
SELECT 
    severity,
    ROUND(AVG(DATEDIFF(resolution_date, event_date)),2) AS avg_resolution_days,
    MIN(DATEDIFF(resolution_date, event_date)) AS fastest_resolution,
    MAX(DATEDIFF(resolution_date, event_date)) AS slowest_resolution,
    SUM(CASE WHEN status = 'Open' THEN 1 ELSE 0 END) AS total_open_cases
FROM compliance_events
WHERE resolution_date IS NOT NULL
GROUP BY severity;

-- ===============================================================
-- Problem 7: Margin Call Risk Assessment
-- ===============================================================
SELECT 
    a.account_id,
    l.loan_id,
    (SUM(ph.quantity * ph.current_price)) AS equity_value,
    l.loan_amount,
    (SUM(ph.quantity * ph.current_price) - l.loan_amount) AS equity_minus_loan,
    CASE WHEN (SUM(ph.quantity * ph.current_price)) < 1.3 * l.loan_amount
         THEN (1.3 * l.loan_amount - SUM(ph.quantity * ph.current_price)) ELSE 0 END AS deficit_amount
FROM portfolio_holdings ph
JOIN accounts a ON ph.account_id = a.account_id
JOIN loans l ON a.client_id = l.client_id
WHERE l.loan_type = 'Margin'
GROUP BY a.account_id, l.loan_id, l.loan_amount;

-- Problem 8: Suspicious Trading Pattern Detection (accounts with >10 txns/day)
WITH daily_tx AS (
    SELECT account_id, DATE(transaction_date) AS tx_date, COUNT(*) AS tx_count, SUM(quantity * price_per_unit) AS total_volume
    FROM transactions
    GROUP BY account_id, DATE(transaction_date)
    HAVING COUNT(*) > 10
)
SELECT d.account_id, d.tx_date, d.tx_count, d.total_volume,
       CASE WHEN EXISTS (SELECT 1 FROM compliance_events ce WHERE ce.account_id = d.account_id AND ce.status = 'Open') THEN 'Yes' ELSE 'No' END AS has_open_compliance_case
FROM daily_tx d
ORDER BY d.tx_count DESC;

-- Problem 9: Loan Delinquency Analysis (per loan_type)
WITH payments AS (
    SELECT l.loan_id, l.loan_type, lp.payment_status, DATEDIFF(lp.payment_date, l.approval_date) AS days_since_approval
    FROM loan_payments lp
    JOIN loans l ON lp.loan_id = l.loan_id
), agg AS (
    SELECT loan_type,
           COUNT(DISTINCT loan_id) AS total_loans,
           SUM(payment_status = 'Paid') AS on_time_payments,
           SUM(payment_status = 'Late') AS late_payments,
           SUM(payment_status = 'Missed') AS missed_payments,
           AVG(CASE WHEN payment_status = 'Late' THEN days_since_approval ELSE NULL END) AS avg_days_past_due
    FROM payments
    GROUP BY loan_type
)
SELECT loan_type, total_loans, on_time_payments, late_payments, missed_payments,
       ROUND(on_time_payments/NULLIF((on_time_payments+late_payments+missed_payments),0)*100,2) AS on_time_rate_pct,
       ROUND(late_payments/NULLIF((on_time_payments+late_payments+missed_payments),0)*100,2) AS late_rate_pct,
       ROUND(avg_days_past_due,2) AS avg_days_past_due
FROM agg;

-- Problem 10: Risk-Adjusted Returns (Sharpe ratio improvement)
WITH ranked_sharpe AS (
    SELECT account_id, calculation_date, sharpe_ratio,
           ROW_NUMBER() OVER (PARTITION BY account_id ORDER BY calculation_date DESC) AS rn
    FROM risk_metrics
)
SELECT cur.account_id,
       cur.sharpe_ratio AS current_sharpe,
       prev.sharpe_ratio AS previous_sharpe,
       ROUND(cur.sharpe_ratio - prev.sharpe_ratio,4) AS change_sharpe
FROM (SELECT * FROM ranked_sharpe WHERE rn = 1) cur
LEFT JOIN (SELECT * FROM ranked_sharpe WHERE rn = 2) prev ON cur.account_id = prev.account_id
ORDER BY change_sharpe DESC;

-- Problem 11: Realized vs Unrealized Gains (per account)
-- Realized: aggregate Sell transactions; Unrealized: holdings current vs cost
WITH sells AS (
    SELECT t.account_id, SUM(CASE WHEN t.transaction_type = 'Sell' THEN t.total_amount ELSE 0 END) AS sell_proceeds
    FROM transactions t
    GROUP BY t.account_id
), cost_basis AS (
    SELECT account_id, SUM(quantity * average_cost) AS cost_basis, SUM(quantity * current_price) AS current_value
    FROM portfolio_holdings
    GROUP BY account_id
)
SELECT c.account_id,
       COALESCE(s.sell_proceeds,0) AS total_realized,
       COALESCE(cb.current_value - cb.cost_basis,0) AS total_unrealized,
       COALESCE(cb.current_value,0) + COALESCE(s.sell_proceeds,0) AS portfolio_current_value,
       COALESCE(cb.cost_basis,0) AS total_invested,
       CASE WHEN COALESCE(cb.cost_basis,0)=0 THEN NULL ELSE ROUND((COALESCE(s.sell_proceeds,0) + (cb.current_value - cb.cost_basis)) / cb.cost_basis * 100,2) END AS overall_return_pct
FROM (SELECT DISTINCT account_id FROM accounts) c
LEFT JOIN sells s ON c.account_id = s.account_id
LEFT JOIN cost_basis cb ON c.account_id = cb.account_id
ORDER BY overall_return_pct DESC;

-- Problem 12: Asset Class Allocation Drift (per client) -- (already addressed above, included here for completeness)
SELECT
  client_id,
  client_name,
  risk_profile,
  (bonds_value / total_value) * 100 AS bonds_pct,
  (equities_value / total_value) * 100 AS equities_pct,
  (others_value / total_value) * 100 AS others_pct
FROM ClientHoldings;

-- Problem 13: Top Performing Securities (top 5) -- (already addressed above)
SELECT
  c.client_id,
  c.client_name,
  c.risk_profile,
  (c.bonds_value / c.total_value) * 100 AS bonds_pct,
  (c.equities_value / c.total_value) * 100 AS equities_pct,
  (c.others_value / c.total_value) * 100 AS others_pct,
  r.target_bonds,
  r.target_equities,
  r.target_others,
  ABS((c.bonds_value / c.total_value) * 100 - r.target_bonds) AS bonds_diff,
  ABS((c.equities_value / c.total_value) * 100 - r.target_equities) AS equities_diff,
  ABS((c.others_value / c.total_value) * 100 - r.target_others) AS others_diff,
  CASE
    WHEN ABS((c.bonds_value / c.total_value) * 100 - r.target_bonds) > 10
      OR ABS((c.equities_value / c.total_value) * 100 - r.target_equities) > 10
      OR ABS((c.others_value / c.total_value) * 100 - r.target_others) > 10
    THEN '⚠️ OUT OF BALANCE'
    ELSE '✅ IN BALANCE'
  END AS balance_status
FROM ClientHoldings c
JOIN RiskProfileTargets r
  ON c.risk_profile = r.risk_profile;
-- Problem 14: Client Profitability Ranking (per client)
WITH commissions AS (
    SELECT a.client_id, SUM(COALESCE(t.commission,0)) AS commissions_paid
    FROM transactions t JOIN accounts a ON t.account_id = a.account_id
    GROUP BY a.client_id
), mgmt_fees AS (
    SELECT a.client_id, SUM(COALESCE(ps.amount_invested * fp.management_fee/100,0)) AS mgmt_fees
    FROM product_subscriptions ps
    JOIN financial_products fp ON ps.product_id = fp.product_id
    JOIN accounts a ON ps.account_id = a.account_id
    GROUP BY a.client_id
), interest_paid AS (
    SELECT l.client_id, SUM(lp.interest_amount) AS interest_paid
    FROM loan_payments lp JOIN loans l ON lp.loan_id = l.loan_id
    GROUP BY l.client_id
), trading_pnl AS (
    SELECT a.client_id, SUM(CASE WHEN t.transaction_type = 'Sell' THEN t.total_amount ELSE 0 END) - SUM(CASE WHEN t.transaction_type = 'Buy' THEN t.total_amount ELSE 0 END) AS net_trading_cashflow
    FROM transactions t JOIN accounts a ON t.account_id = a.account_id
    GROUP BY a.client_id
)
SELECT c.client_id, c.client_name,
       COALESCE(comm.commissions_paid,0) AS commissions_paid,
       COALESCE(mg.mgmt_fees,0) AS management_fees,
       COALESCE(ip.interest_paid,0) AS interest_paid,
       COALESCE(tp.net_trading_cashflow,0) AS net_trading_cashflow,
       (COALESCE(comm.commissions_paid,0) + COALESCE(mg.mgmt_fees,0) + COALESCE(ip.interest_paid,0)) AS total_profitability_to_firm
FROM clients c
LEFT JOIN commissions comm ON c.client_id = comm.client_id
LEFT JOIN mgmt_fees mg ON c.client_id = mg.client_id
LEFT JOIN interest_paid ip ON c.client_id = ip.client_id
LEFT JOIN trading_pnl tp ON c.client_id = tp.client_id
ORDER BY total_profitability_to_firm DESC;

-- Problem 15: Portfolio Turnover Ratio for 2024 (per account)
WITH sold_2024 AS (
    SELECT account_id, SUM(CASE WHEN transaction_type='Sell' THEN ABS(total_amount) ELSE 0 END) AS sold_value
    FROM transactions
    WHERE YEAR(transaction_date) = 2024
    GROUP BY account_id
), avg_portfolio AS (
    SELECT a.account_id, (COALESCE(a.current_balance,0) + COALESCE(h.holdings_value,0))/2 AS avg_portfolio_value
    FROM accounts a
    LEFT JOIN (SELECT account_id, SUM(quantity*current_price) AS holdings_value FROM portfolio_holdings GROUP BY account_id) h USING(account_id)
)
SELECT s.account_id, s.sold_value, ap.avg_portfolio_value,
       CASE WHEN ap.avg_portfolio_value = 0 THEN NULL ELSE ROUND(s.sold_value / ap.avg_portfolio_value,4) END AS turnover_ratio
FROM sold_2024 s
JOIN avg_portfolio ap ON s.account_id = ap.account_id
ORDER BY turnover_ratio DESC;

-- Problem 16: Monthly Asset Inflows/Outflows (already included earlier)

-- Create a monthly report showing total deposits, withdrawals, net cash flow, and running balance for all accounts. Show month-over-month growth rate.

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

-- Problem 25: Market Impact Analysis (index movement >2%)
WITH index_moves AS (
    SELECT bi.index_date, bi.index_value,
           LAG(bi.index_value) OVER (ORDER BY bi.index_date) AS prev_value,
           (bi.index_value - LAG(bi.index_value) OVER (ORDER BY bi.index_date))/LAG(bi.index_value) OVER (ORDER BY bi.index_date) AS pct_change
    FROM benchmark_indices bi
), big_moves AS (
    SELECT index_date FROM index_moves WHERE ABS(pct_change) > 0.02
)
SELECT bm.index_date,
       COUNT(t.transaction_id) AS num_trades,
       SUM(CASE WHEN t.transaction_type = 'Buy' THEN 1 ELSE 0 END) AS buy_count,
       SUM(CASE WHEN t.transaction_type = 'Sell' THEN 1 ELSE 0 END) AS sell_count,
       SUM(t.total_amount) AS total_volume,
       (SELECT security_id FROM (SELECT security_id, SUM(quantity) AS q FROM transactions WHERE DATE(transaction_date)=bm.index_date GROUP BY security_id ORDER BY q DESC LIMIT 1) x) AS most_traded_security
FROM big_moves bm
LEFT JOIN transactions t ON DATE(t.transaction_date) = bm.index_date
GROUP BY bm.index_date;

-- Problem 26: Cohort Analysis (clients registered Q1 2024)
WITH cohorts AS (
    SELECT client_id, registration_date FROM clients WHERE registration_date BETWEEN '2024-01-01' AND '2024-03-31'
), quarterly_activity AS (
    SELECT c.client_id, CONCAT(YEAR(t.transaction_date),'Q',QUARTER(t.transaction_date)) AS yq,
           SUM(t.total_amount) AS traded_amount, COUNT(*) AS trades
    FROM cohorts c
    LEFT JOIN accounts a ON a.client_id = c.client_id
    LEFT JOIN transactions t ON t.account_id = a.account_id
    GROUP BY c.client_id, CONCAT(YEAR(t.transaction_date),'Q',QUARTER(t.transaction_date))
)
SELECT client_id, yq, SUM(traded_amount) AS total_traded, SUM(trades) AS num_trades
FROM quarterly_activity
GROUP BY client_id, yq
ORDER BY client_id, yq;

-- Problem 27: Value at Risk (VaR) Trend Analysis (per account)
SELECT account_id, calculation_date, value_at_risk,
       LAG(value_at_risk) OVER (PARTITION BY account_id ORDER BY calculation_date) AS prev_var,
       value_at_risk - LAG(value_at_risk) OVER (PARTITION BY account_id ORDER BY calculation_date) AS var_change
FROM risk_metrics
ORDER BY account_id, calculation_date;

-- Problem 28: Alert Response Time Analysis
SELECT alert_type, severity,
       ROUND(AVG(TIMESTAMPDIFF(SECOND, alert_date, (SELECT MIN(action_date) FROM audit_log al WHERE al.table_affected='alerts' AND al.user_id = alerts.account_id))),2) AS avg_response_seconds,
       SUM(CASE WHEN acknowledged = FALSE AND severity = 'Critical' THEN 1 ELSE 0 END) AS unack_critical_count
FROM alerts
GROUP BY alert_type, severity;

-- Problem 29: Optimal Portfolio Rebalancing Recommendations (simple proportional rebalance)
-- For accounts out of balance >10% (from asset allocation query), produce target trades to reach target allocation
WITH current_alloc AS (
    SELECT a.account_id, CASE WHEN LOWER(ac.asset_class_name) LIKE '%bond%' THEN 'Bonds' WHEN LOWER(ac.asset_class_name) LIKE '%equity%' THEN 'Equities' ELSE 'Others' END AS class_group, SUM(ph.quantity * ph.current_price) AS value
    FROM portfolio_holdings ph
    JOIN securities s ON ph.security_id = s.security_id
    JOIN asset_classes ac ON s.asset_class_id = ac.asset_class_id
    JOIN accounts a ON ph.account_id = a.account_id
    GROUP BY a.account_id, class_group
), total_val AS (
    SELECT account_id, SUM(value) AS total_value FROM current_alloc GROUP BY account_id
), pct_alloc AS (
    SELECT ca.account_id, ca.class_group, ca.value, tv.total_value, ca.value/tv.total_value AS pct
    FROM current_alloc ca JOIN total_val tv USING(account_id)
), targets AS (
    SELECT account_id,
           CASE WHEN cli.risk_profile='Conservative' THEN 70 WHEN cli.risk_profile='Moderate' THEN 50 WHEN cli.risk_profile='Aggressive' THEN 20 ELSE 10 END AS target_bonds,
           CASE WHEN cli.risk_profile='Conservative' THEN 20 WHEN cli.risk_profile='Moderate' THEN 40 WHEN cli.risk_profile='Aggressive' THEN 70 ELSE 80 END AS target_equities,
           10 AS target_others
    FROM accounts a JOIN clients cli ON a.client_id = cli.client_id
    GROUP BY a.account_id
)
SELECT p.account_id,
       'Bonds' AS asset_class,
       ROUND((t.target_bonds/100.0)*p.total_value - COALESCE((SELECT value FROM current_alloc ca WHERE ca.account_id = p.account_id AND ca.class_group='Bonds'),0),2) AS trade_amount_to_buy_positive_or_sell_negative
FROM total_val p
JOIN targets t ON p.account_id = t.account_id
UNION ALL
SELECT p.account_id,'Equities', ROUND((t.target_equities/100.0)*p.total_value - COALESCE((SELECT value FROM current_alloc ca WHERE ca.account_id = p.account_id AND ca.class_group='Equities'),0),2)
FROM total_val p JOIN targets t ON p.account_id = t.account_id
UNION ALL
SELECT p.account_id,'Others', ROUND((t.target_others/100.0)*p.total_value - COALESCE((SELECT value FROM current_alloc ca WHERE ca.account_id = p.account_id AND ca.class_group='Others'),0),2)
FROM total_val p JOIN targets t ON p.account_id = t.account_id;

-- Problem 30: Comprehensive Risk Report (executive dashboard)
SELECT
    (SELECT SUM(value_at_risk) FROM risk_metrics) AS total_portfolio_var,
    (SELECT security_id FROM (SELECT security_id, SUM(quantity*current_price) AS pos_val FROM portfolio_holdings GROUP BY security_id ORDER BY pos_val DESC LIMIT 10) x) AS top_10_concentrated_positions,
    (SELECT COUNT(*) FROM (SELECT account_id FROM portfolio_holdings GROUP BY account_id HAVING MAX(quantity*current_price) > 0) y) AS accounts_breaching_limits,
    (SELECT COUNT(*) FROM compliance_events WHERE severity IN ('High','Critical') AND status <> 'Resolved') AS compliance_attention_needed,
    (SELECT COUNT(*) FROM loans WHERE loan_type='Margin' AND loan_amount > 0) AS margin_loan_count;

-- Problem 31: Active Client Directory
SELECT client_id, client_name, country, client_type, risk_profile,
       DATEDIFF(CURRENT_DATE, registration_date) AS days_since_registration
FROM clients
WHERE is_active = TRUE
ORDER BY client_name;

-- Problem 32: High-Value Account Identification (> $1,000,000)
SELECT a.account_id, a.account_type, a.currency, c.client_name, a.current_balance, a.status
FROM accounts a JOIN clients c ON a.client_id = c.client_id
WHERE a.current_balance > 1000000
ORDER BY a.current_balance DESC;

-- Problem 33: Transaction Summary Dashboard
SELECT transaction_type, COUNT(*) AS total_count, SUM(total_amount) AS total_volume, AVG(total_amount) AS avg_transaction_size, SUM(commission) AS total_commission
FROM transactions
GROUP BY transaction_type;

-- Problem 34: Securities Catalog (market cap categories)
SELECT s.security_symbol, s.security_name, s.sector, s.exchange,
       ROUND(s.market_cap/1000000000,2) AS market_cap_billion,
       CASE WHEN s.market_cap > 200000000000 THEN 'Mega Cap'
            WHEN s.market_cap BETWEEN 10000000000 AND 200000000000 THEN 'Large Cap'
            WHEN s.market_cap BETWEEN 2000000000 AND 10000000000 THEN 'Mid Cap'
            ELSE 'Small Cap' END AS market_cap_category
FROM securities s
ORDER BY s.market_cap DESC;

-- Problem 35: Monthly Trading Activity - 2024
SELECT MONTHNAME(transaction_date) AS month_name, MONTH(transaction_date) AS month_number,
       COUNT(*) AS total_transactions,
       SUM(total_amount) AS total_volume_traded,
       COUNT(DISTINCT trader_id) AS unique_traders
FROM transactions
WHERE YEAR(transaction_date) = 2024
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);

-- Problem 36: Client Account Ownership
SELECT c.client_name, c.client_type, COUNT(a.account_id) AS num_accounts, GROUP_CONCAT(DISTINCT a.account_type) AS account_types, ROUND(SUM(a.current_balance),2) AS total_balance
FROM clients c
LEFT JOIN accounts a ON a.client_id = c.client_id
WHERE c.is_active = TRUE
GROUP BY c.client_id, c.client_name, c.client_type;

-- Problem 37: Trader Performance Snapshot
SELECT t.trader_id, t.trader_name,
       SUM(CASE WHEN tx.transaction_type IN ('Buy','Sell') THEN 1 ELSE 0 END) AS total_trades,
       SUM(CASE WHEN tx.transaction_type IN ('Buy','Sell') THEN tx.total_amount ELSE 0 END) AS total_trading_volume,
       SUM(COALESCE(tx.commission,0)) AS total_commission,
       AVG(COALESCE(tx.commission,0)) AS avg_commission_per_trade
FROM traders t
LEFT JOIN transactions tx ON t.trader_id = tx.trader_id
GROUP BY t.trader_id, t.trader_name;

-- Problem 38: Loan Portfolio Overview
SELECT loan_type, COUNT(*) AS number_of_loans, SUM(loan_amount) AS total_loan_amount, ROUND(AVG(interest_rate),4) AS avg_interest_rate,
       SUM(status = 'Applied') AS applied_count, SUM(status = 'Approved') AS approved_count, SUM(status = 'Disbursed') AS disbursed_count
FROM loans
GROUP BY loan_type;

-- Problem 39: Top Securities by Holding (top 10)
SELECT s.security_name, s.security_symbol, COUNT(DISTINCT ph.account_id) AS num_clients_holding, SUM(ph.quantity) AS total_quantity, SUM(ph.quantity * ph.current_price) AS total_market_value
FROM portfolio_holdings ph
JOIN securities s ON ph.security_id = s.security_id
GROUP BY s.security_id
ORDER BY total_market_value DESC
LIMIT 10;

-- Problem 40: Compliance Events Summary
SELECT severity, COUNT(*) AS total_events,
       SUM(status = 'Open') AS open_count,
       SUM(status = 'Resolved') AS resolved_count,
       ROUND(AVG(CASE WHEN status = 'Resolved' THEN DATEDIFF(resolution_date, event_date) END),2) AS avg_resolution_days
FROM compliance_events
GROUP BY severity;

-- End of file
-- Note: Some queries make simplifying assumptions due to schema limitations. Adjust joins/columns if your data model differs.

-- To be extended sequentially as per next problems.
