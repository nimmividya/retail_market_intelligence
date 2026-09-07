{{ config(materialized='view') }}

WITH retail_gdp AS (

    SELECT
        GEO_FIPS,
        GEO_NAME,
        QUARTER,
        GDP_VALUE
    FROM {{ ref('stg_sqgdp2') }}
    WHERE LINE_CODE = '35'
      AND INDUSTRY_CLASSIFICATION = '44-45'
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

annual_retail_gdp AS (

    SELECT
        GEO_FIPS,
        GEO_NAME,

        LEFT(QUARTER, 4) AS YEAR,

        SUM(GDP_VALUE) AS RETAIL_GDP_ANNUAL,

        COUNT_IF(GDP_VALUE IS NOT NULL) AS QUARTERS_AVAILABLE

    FROM retail_gdp

    GROUP BY
        GEO_FIPS,
        GEO_NAME,
        LEFT(QUARTER, 4)

),

final AS (

    SELECT
        GEO_FIPS,
        GEO_NAME,
        TRY_TO_NUMBER(YEAR) AS YEAR,
        RETAIL_GDP_ANNUAL,
        QUARTERS_AVAILABLE,

        GEO_FIPS
            || '|'
            || YEAR AS GDP_BUSINESS_KEY

    FROM annual_retail_gdp

)

SELECT *
FROM final