SELECT
    EXTRACT(YEAR FROM v.time_period::date) AS year, c.category_name,
    ROUND(AVG(v.volume_index)::numeric, 2) AS annual_volume_index
FROM retail_volume_monthly v
JOIN retail_category c
    ON v.category_id = c.category_id
WHERE v.category_id IN (1, 2)
GROUP BY year, c.category_name
ORDER BY year, c.category_name;
