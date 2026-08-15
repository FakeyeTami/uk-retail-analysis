COPY retail_category (
    category_id,
    category_name,
    agg_sic,
    percentage_weight,
    sales_2023
)
FROM 'data/processed/retail_category.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE
);

COPY retail_volume_monthly (
    date_id,
    time_period,
    category_id,
    volume_code,
    volume_index
)
FROM '/data/processed/retail_volume_monthly.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE
);

COPY retail_value_monthly (
    date_id,
    time_period,
    category_id,
    value_code,
    sales_value
)
FROM '../data/processed/retail_value_monthly.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE
);

SELECT COUNT(*) FROM retail_category;

SELECT COUNT(*) FROM retail_volume_monthly;

SELECT COUNT(*) FROM retail_value_monthly;

