SELECT
    state_fips,
    estimate_period,
    COUNT(*) AS row_count
FROM {{ ref('stg_acs') }}
GROUP BY
    state_fips,
    estimate_period
HAVING COUNT(*) > 1