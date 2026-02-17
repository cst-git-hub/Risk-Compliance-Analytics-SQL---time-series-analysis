WITH yearly_financials AS (
    SELECT
        f.entity_id,
        f.year,
        SUM(f.revenue) AS total_revenue
    FROM financials f
    GROUP BY f.entity_id, f.year
)

SELECT
    entity_id,
    year,
    total_revenue,

    LAG(total_revenue) OVER (PARTITION BY entity_id ORDER BY year) AS prev_year_revenue,

    CASE
        WHEN LAG(total_revenue) OVER (PARTITION BY entity_id ORDER BY year) = 0
             OR LAG(total_revenue) OVER (PARTITION BY entity_id ORDER BY year) IS NULL
        THEN NULL
        ELSE
            (total_revenue
             - LAG(total_revenue) OVER (PARTITION BY entity_id ORDER BY year))
            * 100
            / LAG(total_revenue) OVER (PARTITION BY entity_id ORDER BY year)
    END AS yoy_revenue_growth_pct

FROM yearly_financials
ORDER BY entity_id, year;