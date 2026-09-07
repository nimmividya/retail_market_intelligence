SELECT
    STATE_FIPS,
    YEAR,
    COUNT(*) AS row_count
FROM {{ ref('int_retail_business') }}
GROUP BY
    STATE_FIPS,
    YEAR
HAVING COUNT(*) > 1