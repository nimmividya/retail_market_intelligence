SELECT *
FROM {{ ref('int_cbp_retail') }}
WHERE establishments < 0
   OR employment < 0
   OR first_quarter_payroll < 0
   OR annual_payroll < 0