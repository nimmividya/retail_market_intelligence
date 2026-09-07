{{ config(
    materialized='view'
) }}

WITH retail_business AS (

    SELECT
        STATE_FIPS,
        2023 AS YEAR,

        ESTABLISHMENTS AS RETAIL_ESTABLISHMENTS,
        EMPLOYMENT AS RETAIL_EMPLOYMENT,
        ANNUAL_PAYROLL AS RETAIL_ANNUAL_PAYROLL,

        EMPLOYMENT_FLAG,
        ANNUAL_PAYROLL_FLAG

    FROM {{ ref('stg_cbp') }}

    WHERE NAICS_CODE = '44----'
      AND LEGAL_FORM = '-'

)

SELECT
    STATE_FIPS,
    YEAR,
    RETAIL_ESTABLISHMENTS,
    RETAIL_EMPLOYMENT,
    RETAIL_ANNUAL_PAYROLL,
    EMPLOYMENT_FLAG,
    ANNUAL_PAYROLL_FLAG,

    MD5(
        CONCAT(
            STATE_FIPS,
            '|',
            YEAR
        )
    ) AS BUSINESS_KEY

FROM retail_business