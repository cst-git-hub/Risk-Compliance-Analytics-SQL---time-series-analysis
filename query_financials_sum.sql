WITH yearly_financials AS (
    SELECT
        f.entity_id,
        f.year,
        SUM(f.revenue) AS total_revenue,
        SUM(f.profit) AS total_profit
    FROM financials f
    GROUP BY f.entity_id, f.year
)

SELECT
    entity_id,
    year,
    total_revenue,
    total_profit,

    -- YoY revenue change
    total_revenue
      - LAG(total_revenue) OVER (PARTITION BY entity_id ORDER BY year)
      AS yoy_revenue_change,

    -- YoY profit change
    total_profit
      - LAG(total_profit) OVER (PARTITION BY entity_id ORDER BY year)
      AS yoy_profit_change

FROM yearly_financials
ORDER BY entity_id, year;