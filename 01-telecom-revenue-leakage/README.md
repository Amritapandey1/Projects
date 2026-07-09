# Telecom Revenue Leakage & Billing Anomaly Detection

## Problem Statement
Telecom companies lose revenue to billing inconsistencies, system errors, and unmonetized usage. These leakages are hard to catch because they're spread across customer segments, hidden inside high-usage behavior, and rarely flagged in real time.

## Objective
Identify high-risk customers, quantify revenue leakage, and uncover the patterns driving billing anomalies to enable proactive revenue assurance.

## Dataset
Customer-level telecom usage and billing data:
- `CustomerID` — unique identifier
- `CallDurationMinutes` — total call usage
- `DataUsageGB` — data consumption
- `SubscriptionPlan` — Basic / Standard / Premium
- `IsBillingAnomaly` — flag (1 = anomaly, 0 = normal)

## Approach
1. **Data quality check** — nulls, anomaly distribution, plan-level coverage
2. **Plan-level performance analysis** — customer distribution, average usage, anomaly rate, revenue estimation per plan
3. **Billing anomaly deep dive** — anomalous vs. normal usage patterns, cross-analysis by plan
4. **Customer segmentation** — by call duration and data usage buckets
5. **Revenue leakage quantification** — revenue at risk per plan, leakage % at plan level
6. **Outlier detection** — Z-score analysis to flag extreme usage and potential system-level billing gaps

## Key Insights
- Customers with data usage above 7.5GB show the highest concentration of anomalies, suggesting billing systems may struggle to track heavy usage accurately.
- Premium plan users drive the largest revenue at risk per customer — a small anomaly rate there has an outsized dollar impact.
- Anomalous users consistently show higher call duration and data usage than normal users, meaning leakage tracks with usage intensity rather than being random.
- "Very high usage" behavioral segments show disproportionately high anomaly rates and leakage contribution.
- Outliers beyond 2 standard deviations are strong candidates for manual audit.

## Business Impact
- Quantified revenue at risk by plan and surfaced the highest-value leakage segments
- Replaced broad, unfocused audits with targeted investigation areas
- Estimated potential to reduce leakage by 10–20% through targeted fixes

## Recommendations
- Add usage-based billing validation checks for high-usage customers and sudden spikes
- Prioritize anomaly monitoring on Premium plans given their revenue exposure
- Build a real-time anomaly detection system flagging high usage + anomaly patterns together

## Files
- `P1_ Telecom Revenue Leakage Analysis.docx` — full write-up
- `Telecom_Revenue_Assurance_Analysis.xlsx` — underlying dataset/analysis
- `Revenue Analysis- Telecom.pbix` — Power BI dashboard

## Tools
SQL, Excel, Power BI
