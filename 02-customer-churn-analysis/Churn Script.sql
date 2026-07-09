CREATE DATABASE saas_project;
USE saas_project;
DESCRIBE customers;

SHOW TABLES;
SELECT COUNT(*) FROM customers;
SELECT 
  COUNT(*) AS total_customers,
  SUM(Churn = 'Yes') AS churned_customers,
  ROUND(SUM(Churn = 'Yes') / COUNT(*) * 100, 2) AS churn_rate_pct
FROM customers;

SELECT
  Contract,
  COUNT(*) AS customers,
  SUM(Churn = 'Yes') AS churned_customers,
  ROUND(SUM(Churn = 'Yes') / COUNT(*) * 100, 2) AS churn_rate_pct
FROM customers
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

SELECT
  CASE
    WHEN tenure < 12 THEN '0–1 year'
    WHEN tenure BETWEEN 12 AND 24 THEN '1–2 years'
    WHEN tenure BETWEEN 25 AND 48 THEN '2–4 years'
    ELSE '4+ years'
  END AS tenure_group,
  COUNT(*) AS customers,
  SUM(Churn = 'Yes') AS churned_customers,
  ROUND(SUM(Churn = 'Yes') / COUNT(*) * 100, 2) AS churn_rate_pct
FROM customers
GROUP BY tenure_group
ORDER BY churn_rate_pct DESC;

SELECT
  PaymentMethod,
  COUNT(*) AS customers,
  SUM(Churn = 'Yes') AS churned_customers,
  ROUND(SUM(Churn = 'Yes') / COUNT(*) * 100, 2) AS churn_rate_pct
FROM customers
GROUP BY PaymentMethod
ORDER BY churn_rate_pct DESC;
SELECT
  Contract,
  ROUND(SUM(CASE WHEN Churn='Yes' THEN MonthlyCharges ELSE 0 END), 2) AS monthly_revenue_at_risk
FROM customers
GROUP BY Contract
ORDER BY monthly_revenue_at_risk DESC;


