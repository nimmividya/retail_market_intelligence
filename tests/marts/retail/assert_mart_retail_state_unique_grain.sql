SELECT
    state_fips,
    data_year,
    COUNT(*) AS row_count
FROM {{ ref('mart_retail_state') }}
GROUP BY
    state_fips,
    data_year
HAVING COUNT(*) > 1