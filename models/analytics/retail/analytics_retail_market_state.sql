{{ config(
    materialized='table'
) }}

WITH source_data AS (

    SELECT
        STATE_FIPS,
        STATE_NAME,
        YEAR,

        RETAIL_ESTABLISHMENTS,
        RETAIL_EMPLOYMENT,
        RETAIL_ANNUAL_PAYROLL,

        TOTAL_GDP_ANNUAL,
        RETAIL_GDP_ANNUAL,
        RETAIL_GDP_SHARE,

        RETAIL_EMPLOYMENT_PER_ESTABLISHMENT,
        RETAIL_PAYROLL_PER_EMPLOYEE,
        RETAIL_GDP_PER_ESTABLISHMENT,
        RETAIL_GDP_PER_RETAIL_EMPLOYEE

    FROM {{ ref('mart_retail_market_state') }}

),

ranked AS (

    SELECT
        *,

        RANK() OVER (
            PARTITION BY YEAR
            ORDER BY RETAIL_GDP_SHARE DESC
        ) AS RETAIL_GDP_SHARE_RANK,

        RANK() OVER (
            PARTITION BY YEAR
            ORDER BY RETAIL_EMPLOYMENT DESC
        ) AS RETAIL_EMPLOYMENT_RANK,

        RANK() OVER (
            PARTITION BY YEAR
            ORDER BY RETAIL_GDP_PER_RETAIL_EMPLOYEE DESC
        ) AS RETAIL_GDP_PER_EMPLOYEE_RANK

    FROM source_data

)

SELECT *
FROM ranked