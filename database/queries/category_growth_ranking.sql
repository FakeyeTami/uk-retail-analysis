WITH annual_sales AS (
    SELECT
        EXTRACT(YEAR FROM v.time_period::date) AS year,
        c.category_id,
        c.category_name,
        SUM(COALESCE(v.sales_value, 0)) AS annual_sales
    FROM retail_value_monthly v
    JOIN retail_category c
        ON v.category_id = c.category_id
    WHERE EXTRACT(YEAR FROM v.time_period::date) IN (2023, 2025)
    GROUP BY
        year,
        c.category_id,
        c.category_name
),
category_growth AS (
    SELECT
        current_year.category_id,
        current_year.category_name,
        baseline.annual_sales AS sales_2023,
        current_year.annual_sales AS sales_2025,
        ((current_year.annual_sales - baseline.annual_sales) / NULLIF(baseline.annual_sales, 0)) * 100 AS growth_percentage
    FROM annual_sales AS current_year
    JOIN annual_sales AS baseline
        ON current_year.category_id = baseline.category_id
        AND baseline.year = 2023
    WHERE current_year.year = 2025
)
SELECT
    category_name,
    ROUND(sales_2023::numeric, 2) AS sales_2023,
    ROUND(sales_2025::numeric, 2) AS sales_2025,
    ROUND(growth_percentage::numeric, 2) AS growth_percentage,
    RANK() OVER (
        ORDER BY growth_percentage DESC
    ) AS growth_rank
FROM category_growth
ORDER BY growth_rank;