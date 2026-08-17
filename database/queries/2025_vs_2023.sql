WITH annual_volume AS (
    SELECT
        EXTRACT(YEAR FROM v.time_period::date) AS year,
        c.category_name,
        ROUND(AVG(v.volume_index)::numeric, 2) AS annual_volume_index
    FROM retail_volume_monthly v
    JOIN retail_category c
        ON v.category_id = c.category_id
    WHERE v.category_id IN (1, 2)
    GROUP BY year, c.category_name
)
SELECT
    current_year.category_name,
    current_year.annual_volume_index AS volume_2025,
    baseline.annual_volume_index AS volume_2023,
    ROUND(
    (
        (
            current_year.annual_volume_index - baseline.annual_volume_index
            )
        / baseline.annual_volume_index
        ) * 100, 2
    ) AS percentage_difference
FROM annual_volume AS current_year
JOIN annual_volume AS baseline
    ON current_year.category_name = baseline.category_name
    AND baseline.year = 2023
WHERE current_year.year = 2025;


;

