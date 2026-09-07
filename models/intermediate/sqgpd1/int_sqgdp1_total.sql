{{ config(
    materialized='view',
    schema='INTERMEDIATE'
) }}

WITH quarterly_data AS (

    SELECT
        GEO_FIPS,
        GEO_NAME,
        QUARTER,
        GDP_VALUE,

        TRY_TO_NUMBER(
            LEFT(QUARTER, 4)
        ) AS YEAR

    FROM {{ ref('stg_sqgdp1') }}

    WHERE LINE_CODE = 1
      AND GEO_FIPS NOT IN (
          '00000',
          '91000',
          '92000',
          '93000',
          '94000',
          '95000',
          '96000',
          '97000',
          '98000'
      )

),

annual_data AS (

    SELECT
        GEO_FIPS,
        GEO_NAME,
        YEAR,

        AVG(GDP_VALUE) AS TOTAL_GDP_ANNUAL,

        COUNT(GDP_VALUE) AS QUARTERS_AVAILABLE

    FROM quarterly_data

    GROUP BY
        GEO_FIPS,
        GEO_NAME,
        YEAR

)

SELECT
    GEO_FIPS,
    GEO_NAME,
    YEAR,
    TOTAL_GDP_ANNUAL,
    QUARTERS_AVAILABLE,

    CONCAT(
        'SQGDP1_',
        GEO_FIPS,
        '_',
        YEAR
    ) AS GDP_BUSINESS_KEY

FROM annual_data

WHERE QUARTERS_AVAILABLE = 4