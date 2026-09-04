{{ config(
    materialized = 'view',
    schema = 'INTERMEDIATE'
) }}

SELECT
    state_fips,
    naics_code,
    2023 AS data_year,

    establishments,

    employment,
    employment_flag,

    first_quarter_payroll,
    first_quarter_payroll_flag,

    annual_payroll,
    annual_payroll_flag

FROM {{ ref('stg_cbp') }}

WHERE legal_form = '-'
  AND REGEXP_LIKE(naics_code, '^(44|45)[0-9]{4}$')