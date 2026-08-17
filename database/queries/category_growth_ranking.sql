WITH annual_sales AS (
    SELECT
        EXTRACT(YEAR FROM v.time_period::date) AS year, c.category_id, c.category_name,
        ROUND(SUM(v.sales_value)::numeric, 2) AS annual_sales
    FROM retail_value_monthly v
    JOIN retail_category c
        ON v.category_id = c.category_id
    GROUP BY year, c.category_id, c.category_name
)

SELECT
    current_year.category_name,
    baseline.annual_sales AS sales_2023,
    current_year.annual_sales AS sales_2025
FROM annual_sales AS current_year
JOIN annual_sales AS baseline
    ON current_year.category_id = baseline.category_id
    AND baseline.year = 2023
WHERE current_year.year = 2025
ORDER BY current_year.category_name;