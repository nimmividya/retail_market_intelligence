SELECT
    GEO_FIPS,
    YEAR
FROM {{ ref('int_sqgdp2_retail') }}
GROUP BY
    GEO_FIPS,
    YEAR
HAVING COUNT(*) > 1