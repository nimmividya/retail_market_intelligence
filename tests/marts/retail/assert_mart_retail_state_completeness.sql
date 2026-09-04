SELECT
    state_fips,
    data_year
FROM {{ ref('mart_retail_state') }}
WHERE
    employment_reported_records
    + employment_unavailable_records
    <> retail_naics_industries
    OR
    first_quarter_payroll_reported_records
    + first_quarter_payroll_unavailable_records
    <> retail_naics_industries
    OR
    annual_payroll_reported_records
    + annual_payroll_unavailable_records
    <> retail_naics_industries