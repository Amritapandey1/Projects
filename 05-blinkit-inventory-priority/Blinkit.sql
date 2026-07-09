-- QUERY 7: Replenishment Priority Score — What to Order Today
-- Priority score = weighted combination of:
--   stockout (highest weight) + below reorder point + days since restock + revenue at risk
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