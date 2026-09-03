SELECT
    state_fips,
    naics_code,
    establishments,
    employment,
    first_quarter_payroll,
    annual_payroll
FROM {{ ref('stg_cbp') }}
WHERE establishments < 0
   OR employment < 0
   OR first_quarter_payroll < 0
   OR annual_payroll < 0