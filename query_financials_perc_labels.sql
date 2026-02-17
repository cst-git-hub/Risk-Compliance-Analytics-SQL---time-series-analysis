WITH yearly_financials AS (
    SELECT
        entity_id,
        year,
        SUM(revenue) AS total_revenue
    FROM financials
    GROUP BY entity_id, year
),
yoy_calc AS (
    SELECT
        entity_id,
        year,
        total_revenue,
        LAG(total_revenue) OVER (PARTITION BY entity_id ORDER BY year) AS prev_year
    FROM yearly_financials
)
SELECT
    entity_id,
    year,
    total_revenue,
    prev_year,

    CASE
        WHEN prev_year IS NULL THEN NULL
        ELSE (total_revenue - prev_year) * 100 / prev_year
    END AS yoy_growth_pct,

    CASE
        WHEN prev_year IS NULL THEN 'N/A'
        WHEN total_revenue > prev_year THEN 'Growing'
        WHEN total_revenue < prev_year THEN 'Declining'
        ELSE 'Flat'
    END AS trend_label

FROM yoy_calc
ORDER BY entity_id, year;