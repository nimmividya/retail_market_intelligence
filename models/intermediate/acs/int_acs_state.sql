{{ config(
    materialized='view',
    schema='INTERMEDIATE'
) }}

SELECT
    state_fips,
    state_name,
    estimate_period,

    -- Business key
    CONCAT(
        'ACS_',
        state_fips,
        '_',
        estimate_period
    ) AS acs_business_key,

    total_population,
    median_household_income,
    per_capita_income,

    pct_high_school_or_higher,
    pct_bachelors_or_higher,

    unemployment_rate,

    pct_families_below_poverty,
    pct_people_below_poverty

FROM {{ ref('stg_acs') }}

WHERE state_fips <> '72'