SELECT
    c.category_name,
    ROUND(SUM(v.sales_value)::numeric, 2) AS total_sales_value,
    ROUND((SUM(v.sales_value)::numeric / SUM(SUM(v.sales_value)::numeric) OVER ()) * 100, 2) AS total_percentage
FROM retail_value_monthly v
JOIN retail_category c
    ON v.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_percentage DESC;