CREATE TABLE IF NOT EXISTS retail_category (
    category_id        INTEGER PRIMARY KEY,
    category_name      VARCHAR(255) NOT NULL,
    agg_sic            VARCHAR(50),
    percentage_weight  DECIMAL(6,2),
    sales_2023         DECIMAL(12,2)
);


CREATE TABLE IF NOT EXISTS retail_volume_monthly (
    date_id       INTEGER NOT NULL,
    time_period   DATE NOT NULL,
    category_id   INTEGER NOT NULL,
    volume_code   VARCHAR(10),
    volume_index  DECIMAL(10,2),

    PRIMARY KEY (date_id, category_id),

    FOREIGN KEY (category_id)
        REFERENCES retail_category(category_id)
);


CREATE TABLE IF NOT EXISTS retail_value_monthly (
    date_id      INTEGER NOT NULL,
    time_period  DATE NOT NULL,
    category_id  INTEGER NOT NULL,
    value_code   VARCHAR(10),
    sales_value  DECIMAL(12,2),

    PRIMARY KEY (date_id, category_id),

    FOREIGN KEY (category_id)
        REFERENCES retail_category(category_id)
);


CREATE INDEX IF NOT EXISTS idx_volume_date
    ON retail_volume_monthly(date_id);

CREATE INDEX IF NOT EXISTS idx_volume_category
    ON retail_volume_monthly(category_id);

CREATE INDEX IF NOT EXISTS idx_value_date
    ON retail_value_monthly(date_id);

CREATE INDEX IF NOT EXISTS idx_value_category
    ON retail_value_monthly(category_id);