{{ config(
    materialized='view',
    schema='STAGING'
) }}

SELECT
    -- Geographic identifiers
    TRIM(NAME)::VARCHAR AS state_name,
    TRIM(STATE)::VARCHAR(2) AS state_fips,

    -- ACS estimate period
    '2020-2024'::VARCHAR(9) AS estimate_period,

    -- Population
    TRY_TO_NUMBER(CP05_2024_001E)::NUMBER(38, 0)
        AS total_population,

    -- Income
    TRY_TO_NUMBER(CP03_2024_062E)::NUMBER(38, 0)
        AS median_household_income,

    TRY_TO_NUMBER(CP03_2024_088E)::NUMBER(38, 0)
        AS per_capita_income,

    -- Educational attainment
    TRY_TO_NUMBER(CP02_2024_067E)::NUMBER(5, 1)
        AS pct_high_school_or_higher,

    TRY_TO_NUMBER(CP02_2024_068E)::NUMBER(5, 1)
        AS pct_bachelors_or_higher,

    -- Labor market
    TRY_TO_NUMBER(CP03_2024_009E)::NUMBER(5, 1)
        AS unemployment_rate,

    -- Poverty
    TRY_TO_NUMBER(CP03_2024_119E)::NUMBER(5, 1)
        AS pct_families_below_poverty,

    TRY_TO_NUMBER(CP03_2024_128E)::NUMBER(5, 1)
        AS pct_people_below_poverty

FROM {{ source('acs', 'RAW_ACS') }}