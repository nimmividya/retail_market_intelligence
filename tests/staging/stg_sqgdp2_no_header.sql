SELECT *
FROM {{ ref('stg_sqgdp2') }}
WHERE GEO_FIPS = 'GeoFIPS'