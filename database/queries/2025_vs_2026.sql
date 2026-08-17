WITH predicte_sales AS (
    SELECT
        c.category_id,
        c.category_name,
        ROUND(
            SUM(
                CASE
                    WHEN EXTRACT(YEAR FROM v.time_period::date) = 2025
                    THEN v.sales_value
                END
            )::numeric,
            2
        ) AS sales_2025_ytd,
        ROUND(
            SUM(
                CASE
                    WHEN EXTRACT(YEAR FROM v.time_period::date) = 2026
                    THEN v.sales_value
                END
            )::numeric, 2) AS sales_2026_ytd
    FROM retail_value_monthly v
    JOIN retail_category c
        ON v.category_id = c.category_id
    WHERE
        EXTRACT(MONTH FROM v.time_period::date) <= 6
        AND EXTRACT(YEAR FROM v.time_period::date) IN (2025, 2026)
    GROUP BY
        c.category_id,
        c.category_name
)
SELECT
    category_id,
    category_name,
    sales_2025_ytd,
    sales_2026_ytd,
    ROUND(((sales_2026_ytd - sales_2025_ytd) / NULLIF(sales_2025_ytd, 0)) * 100, 2) AS predicted_growth_percentage
FROM predicte_sales
ORDER BY predicted_growth_percentage DESC;