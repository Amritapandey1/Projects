# Blinkit — Inventory Replenishment Priority Analysis (SQL)

## Objective
Answer the operational question a dark-store/quick-commerce ops team asks every morning: "What do we need to order today?" — by scoring SKUs on stockout risk, reorder thresholds, and revenue exposure.

## Approach
A single SQL query joins inventory, SKU, and dark-store tables and builds a weighted **replenishment priority score** per SKU per store, combining:
- Whether the item is currently out of stock (highest weight)
- Whether it's below its reorder point
- Whether it's perishable
- Days since last restock
- Potential revenue at risk if the item stays unavailable

Each SKU is also tagged with an urgency label:
- Order Immediately — out of stock
- Order Today — below reorder point
- Can Wait — healthy stock level

## Output
A ranked, store-level list of the top 20 SKUs to reorder today, with quantity to order, reorder cost, and potential revenue if restocked in time.

## Business Value
Turns raw inventory snapshots into a prioritized, actionable reorder list — reducing stockouts on high-revenue and perishable items without requiring manual review of every SKU/store combination.

## Files
- `Blinkit.sql` — full replenishment priority query

## Tools
SQL
