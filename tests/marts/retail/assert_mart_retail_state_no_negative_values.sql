SELECT *
FROM {{ ref('mart_retail_state') }}
WHERE total_establishments < 0
   OR total_employment < 0
   OR total_first_quarter_payroll_thousands < 0
   OR total_annual_payroll_thousands < 0