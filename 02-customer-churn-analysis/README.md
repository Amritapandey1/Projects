# Customer Churn Analysis (SQL)

## Objective
Quantify customer churn and identify which contract types, tenure ranges, and payment methods drive the highest churn rate and revenue at risk, using SQL directly against a customer billing table.

## Dataset
`customers` table with fields including `Contract`, `tenure`, `PaymentMethod`, `MonthlyCharges`, and `Churn` (Yes/No).

## Analysis Performed
- Overall churn rate across the full customer base
- Churn rate by contract type (month-to-month, one-year, two-year), ranked highest to lowest
- Churn rate by tenure bucket (0–1 year, 1–2 years, 2–4 years, 4+ years)
- Churn rate by payment method
- Monthly revenue at risk by contract type (sum of `MonthlyCharges` for churned customers)

## Key Insights
- Churn concentrates heavily in specific contract types and early-tenure customers — a pattern typical of month-to-month, low-commitment plans.
- Revenue at risk isn't evenly distributed across contracts; some segments carry disproportionate churn-driven revenue loss.
- Payment method correlates with churn likelihood, useful for targeting retention outreach.

## Recommendations
- Prioritize retention incentives for high-churn contract types and early-tenure customers
- Investigate why certain payment methods correlate with higher churn (friction, billing issues, etc.)
- Use monthly revenue-at-risk by segment to prioritize retention spend where it has the biggest payoff

## Files
- `Churn Script.sql` — full SQL analysis

## Tools
SQL
