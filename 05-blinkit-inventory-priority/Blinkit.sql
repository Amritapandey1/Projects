-- ============================================================
-- Blinkit Dark-Store Inventory — Stock-Risk & Replenishment Analysis
-- Tables: inventory, skus, dark_stores  |  Engine: MySQL
-- Each query runs against the current-day snapshot (snapshot_date = CURDATE())
-- ============================================================


-- QUERY 1: Stockout Rate by Category — where are we running dry?
SELECT
    s.category,
    COUNT(*)                                                       AS skus_tracked,
    SUM(CASE WHEN i.quantity_available = 0 THEN 1 ELSE 0 END)      AS stockouts,
    ROUND(100.0 * SUM(CASE WHEN i.quantity_available = 0 THEN 1 ELSE 0 END)
                / COUNT(*), 1)                                     AS stockout_rate_pct,
    SUM(CASE WHEN i.quantity_available < i.reorder_point THEN 1 ELSE 0 END)
                                                                   AS below_reorder_point
FROM inventory i
JOIN skus s ON i.sku_id = s.sku_id
WHERE i.snapshot_date = CURDATE()
GROUP BY s.category
ORDER BY stockout_rate_pct DESC;


-- QUERY 2: Revenue at Risk by Store — where is the money exposed?
-- Potential revenue tied to items at/below reorder point, per dark store.
SELECT
    ds.store_name,
    ds.city,
    COUNT(*)                                                       AS items_needing_reorder,
    SUM(CASE WHEN i.quantity_available = 0 THEN 1 ELSE 0 END)      AS out_of_stock_items,
    ROUND(SUM(i.reorder_quantity * s.mrp), 2)                      AS potential_revenue_at_risk_inr
FROM inventory i
JOIN skus s ON i.sku_id = s.sku_id
JOIN dark_stores ds ON i.store_id = ds.store_id
WHERE i.snapshot_date = CURDATE()
  AND i.quantity_available <= i.reorder_point
GROUP BY ds.store_name, ds.city
ORDER BY potential_revenue_at_risk_inr DESC;


-- QUERY 3: Perishable Ageing / Spoilage Risk — capital sitting too long
-- Perishable SKUs restocked > 7 days ago that still hold stock above reorder point
-- → not selling through → likely write-off / waste.
SELECT
    s.product_name,
    s.category,
    ds.store_name,
    i.quantity_available,
    DATEDIFF(CURDATE(), DATE(i.last_restocked_at))                 AS days_since_restock,
    ROUND(i.quantity_available * s.cost_price, 2)                  AS capital_tied_up_inr
FROM inventory i
JOIN skus s ON i.sku_id = s.sku_id
JOIN dark_stores ds ON i.store_id = ds.store_id
WHERE i.snapshot_date = CURDATE()
  AND s.is_perishable = TRUE
  AND i.quantity_available > i.reorder_point
  AND DATEDIFF(CURDATE(), DATE(i.last_restocked_at)) > 7
ORDER BY days_since_restock DESC, capital_tied_up_inr DESC;


-- QUERY 4: Replenishment Priority Score — what to order today
-- Priority score = weighted combination of:
--   stockout (highest weight) + below reorder point + perishability
--   + days since restock + revenue at risk
SELECT
    s.product_name,
    s.category,
    s.is_perishable,
    ds.store_name,
    ds.city,
    i.quantity_available,
    i.reorder_point,
    i.reorder_quantity                                          AS units_to_order,
    ROUND(i.reorder_quantity * s.cost_price, 2)                AS reorder_cost_inr,
    ROUND(i.reorder_quantity * s.mrp, 2)                       AS potential_revenue_inr,
    DATEDIFF(CURDATE(), DATE(i.last_restocked_at))             AS days_since_restock,
    ROUND(
        (CASE WHEN i.quantity_available = 0 THEN 50 ELSE 0 END)
        + (CASE WHEN i.quantity_available < i.reorder_point THEN 20 ELSE 0 END)
        + (CASE WHEN s.is_perishable = TRUE THEN 15 ELSE 0 END)
        + LEAST(DATEDIFF(CURDATE(), DATE(i.last_restocked_at)), 15)
        + LEAST(ROUND(i.reorder_quantity * s.mrp / 100), 15)
    , 0)                                                        AS priority_score,
    CASE
        WHEN i.quantity_available = 0 THEN '🔴 Order Immediately'
        WHEN i.quantity_available < i.reorder_point THEN '🟡 Order Today'
        ELSE '🟢 Can Wait'
    END                                                         AS urgency
FROM inventory i
JOIN skus s ON i.sku_id = s.sku_id
JOIN dark_stores ds ON i.store_id = ds.store_id
WHERE i.snapshot_date = CURDATE()
AND i.quantity_available <= i.reorder_point
ORDER BY priority_score DESC
LIMIT 20;
