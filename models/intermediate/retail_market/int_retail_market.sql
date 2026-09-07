WITH retail_business AS (

    SELECT
        STATE_FIPS,
        YEAR,
        RETAIL_ESTABLISHMENTS,
        RETAIL_EMPLOYMENT,
        RETAIL_ANNUAL_PAYROLL,
        EMPLOYMENT_FLAG,
        ANNUAL_PAYROLL_FLAG
    FROM {{ ref('int_retail_business') }}
    WHERE YEAR = 2023

),

total_gdp AS (

    SELECT
        LEFT(GEO_FIPS, 2) AS STATE_FIPS,
        GEO_NAME AS STATE_NAME,
        YEAR,
        TOTAL_GDP_ANNUAL,
        QUARTERS_AVAILABLE AS TOTAL_GDP_QUARTERS_AVAILABLE
    FROM {{ ref('int_sqgdp1_total') }}
    WHERE YEAR = 2023

),

retail_gdp AS (

    SELECT
        LEFT(GEO_FIPS, 2) AS STATE_FIPS,
        YEAR,
        RETAIL_GDP_ANNUAL,
        QUARTERS_AVAILABLE AS RETAIL_GDP_QUARTERS_AVAILABLE
    FROM {{ ref('int_sqgdp2_retail') }}
    WHERE YEAR = 2023

)

SELECT
    rb.STATE_FIPS,
    tg.STATE_NAME,
    rb.YEAR,

    rb.RETAIL_ESTABLISHMENTS,
    rb.RETAIL_EMPLOYMENT,
    rb.RETAIL_ANNUAL_PAYROLL,

    rb.EMPLOYMENT_FLAG,
    rb.ANNUAL_PAYROLL_FLAG,

    tg.TOTAL_GDP_ANNUAL,
    rg.RETAIL_GDP_ANNUAL,

    tg.TOTAL_GDP_QUARTERS_AVAILABLE,
    rg.RETAIL_GDP_QUARTERS_AVAILABLE,

    rg.RETAIL_GDP_ANNUAL
        / NULLIF(tg.TOTAL_GDP_ANNUAL, 0)
        AS RETAIL_GDP_SHARE

FROM retail_business rb

INNER JOIN total_gdp tg
    ON rb.STATE_FIPS = tg.STATE_FIPS
    AND rb.YEAR = tg.YEAR

INNER JOIN retail_gdp rg
    ON rb.STATE_FIPS = rg.STATE_FIPS
    AND rb.YEAR = rg.YEAR