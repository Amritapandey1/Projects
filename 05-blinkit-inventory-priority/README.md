# Blinkit — Inventory Replenishment & Stock-Risk Analysis (SQL)

## Objective
Turn a daily dark-store inventory snapshot into the decisions a quick-commerce ops team makes every morning: what's running dry, where the money is exposed, what's about to spoil, and exactly what to reorder today.

## Dataset
Three related tables:
- `inventory` — per-SKU, per-store daily snapshot (quantity available, reorder point/quantity, last restock, snapshot date)
- `skus` — product master (name, category, perishable flag, cost price, MRP)
- `dark_stores` — store master (name, city)

## Analysis (4 queries)
1. **Stockout rate by category** — which product categories are running dry, and how many SKUs sit below their reorder point.
2. **Revenue at risk by store** — the rupee exposure from under-stocked items at each dark store, so the highest-value gaps get attention first.
3. **Perishable ageing / spoilage risk** — perishable SKUs restocked over a week ago that still hold stock above reorder point: capital tied up and likely to be written off.
4. **Replenishment priority score** — a weighted score per SKU (stockout, below reorder point, perishability, days since restock, revenue at risk) producing a ranked "order today" list with an urgency label.

## Business Value
Converts a raw inventory snapshot into a prioritised, financially-aware reorder workflow — surfacing stockouts on high-revenue and perishable items, quantifying exposure by store, and flagging waste risk, without manually reviewing every SKU/store combination.

## Files
- `Blinkit.sql` — all four analytical queries

## Tools
SQL (MySQL)
