# Time Series Analysis – Financial Trends (SQL)
## Purpose of this extension
This analysis extends the original dataset by adding historical financial records
to enable meaningful year-over-year (YoY) analysis.

## Data preparation
The original `financials` table was intentionally extended with additional
historical data points, resulting in multiple consecutive years per entity.

## Analytical focus
The analysis focuses on:
- yearly aggregation of revenue
- year-over-year absolute change
- year-over-year percentage growth
- trend labeling (growing / declining / flat)

## Robust aggregation logic
Although the current dataset contains one record per entity per year,
all calculations intentionally use explicit aggregation functions
(e.g. `SUM(revenue)`).

This design choice ensures robustness against:
- future changes in data granularity (e.g. monthly or quarterly data)
- multiple records per entity-year
- integration of additional data sources

The approach reflects real-world analytics scenarios, where assumptions
about data aggregation cannot always be guaranteed.

## SQL techniques demonstrated
- Common Table Expressions (CTEs)
- Explicit aggregation for resilience
- Window functions (`LAG`) for time-based comparison
- CASE expressions for trend classification
- NULL-aware logic to avoid misleading results

## Output
The final queries produce time-ordered financial indicators per entity,
making trends and potential early risk signals visible.

## Supporting materials
- SQL queries
- Execution screenshots

All queries were executed locally in SQL Server.
