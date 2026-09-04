{{ config(
    materialized = 'view',
    schema = 'MARTS'
) }}

SELECT
    state_fips,
    data_year,

    COUNT(DISTINCT naics_code) AS retail_naics_industries,

    SUM(establishments) AS total_establishments,

    SUM(employment) AS total_employment,

    SUM(first_quarter_payroll)
        AS total_first_quarter_payroll_thousands,

    SUM(annual_payroll)
        AS total_annual_payroll_thousands,

    COUNT_IF(employment IS NOT NULL)
        AS employment_reported_records,

    COUNT_IF(employment IS NULL)
        AS employment_unavailable_records,

    COUNT_IF(first_quarter_payroll IS NOT NULL)
        AS first_quarter_payroll_reported_records,

    COUNT_IF(first_quarter_payroll IS NULL)
        AS first_quarter_payroll_unavailable_records,

    COUNT_IF(annual_payroll IS NOT NULL)
        AS annual_payroll_reported_records,

    COUNT_IF(annual_payroll IS NULL)
        AS annual_payroll_unavailable_records

FROM {{ ref('int_cbp_retail') }}

GROUP BY
    state_fips,
    data_year