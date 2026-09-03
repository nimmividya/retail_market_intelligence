WITH source AS (

    SELECT *
    FROM {{ source('cbp', 'RAW_CBP') }}

),

renamed AS (

    SELECT

        -- ============================================================
        -- Geographic / Classification Dimensions
        -- ============================================================

        FIPSTATE AS state_fips,

        NAICS AS naics_code,

        LFO AS legal_form,


        -- ============================================================
        -- Overall Business Measures
        -- ============================================================

        EMP_NF AS employment_flag,

        TRY_TO_NUMBER(EMP) AS employment,

        QP1_NF AS first_quarter_payroll_flag,

        TRY_TO_NUMBER(QP1) AS first_quarter_payroll,

        AP_NF AS annual_payroll_flag,

        TRY_TO_NUMBER(AP) AS annual_payroll,

        TRY_TO_NUMBER(EST) AS establishments,


        -- ============================================================
        -- Employment Size: Less Than 5 Employees
        -- ============================================================

        E_LT5_NF AS establishments_lt_5_flag,

        TRY_TO_NUMBER(E_LT5) AS establishments_lt_5,

        Q_LT5_NF AS first_quarter_payroll_lt_5_flag,

        TRY_TO_NUMBER(Q_LT5) AS first_quarter_payroll_lt_5,

        A_LT5_NF AS annual_payroll_lt_5_flag,

        TRY_TO_NUMBER(A_LT5) AS annual_payroll_lt_5,

        TRY_TO_NUMBER(N_LT5) AS employment_lt_5,


        -- ============================================================
        -- Employment Size: 5-9 Employees
        -- ============================================================

        E5_9_NF AS establishments_5_9_flag,

        TRY_TO_NUMBER(E5_9) AS establishments_5_9,

        Q5_9_NF AS first_quarter_payroll_5_9_flag,

        TRY_TO_NUMBER(Q5_9) AS first_quarter_payroll_5_9,

        A5_9_NF AS annual_payroll_5_9_flag,

        TRY_TO_NUMBER(A5_9) AS annual_payroll_5_9,

        TRY_TO_NUMBER(N5_9) AS employment_5_9,


        -- ============================================================
        -- Employment Size: 10-19 Employees
        -- ============================================================

        E10_19_NF AS establishments_10_19_flag,

        TRY_TO_NUMBER(E10_19) AS establishments_10_19,

        Q10_19_NF AS first_quarter_payroll_10_19_flag,

        TRY_TO_NUMBER(Q10_19) AS first_quarter_payroll_10_19,

        A10_19_NF AS annual_payroll_10_19_flag,

        TRY_TO_NUMBER(A10_19) AS annual_payroll_10_19,

        TRY_TO_NUMBER(N10_19) AS employment_10_19,


        -- ============================================================
        -- Employment Size: 20-49 Employees
        -- ============================================================

        E20_49_NF AS establishments_20_49_flag,

        TRY_TO_NUMBER(E20_49) AS establishments_20_49,

        Q20_49_NF AS first_quarter_payroll_20_49_flag,

        TRY_TO_NUMBER(Q20_49) AS first_quarter_payroll_20_49,

        A20_49_NF AS annual_payroll_20_49_flag,

        TRY_TO_NUMBER(A20_49) AS annual_payroll_20_49,

        TRY_TO_NUMBER(N20_49) AS employment_20_49,


        -- ============================================================
        -- Employment Size: 50-99 Employees
        -- ============================================================

        E50_99_NF AS establishments_50_99_flag,

        TRY_TO_NUMBER(E50_99) AS establishments_50_99,

        Q50_99_NF AS first_quarter_payroll_50_99_flag,

        TRY_TO_NUMBER(Q50_99) AS first_quarter_payroll_50_99,

        A50_99_NF AS annual_payroll_50_99_flag,

        TRY_TO_NUMBER(A50_99) AS annual_payroll_50_99,

        TRY_TO_NUMBER(N50_99) AS employment_50_99,


        -- ============================================================
        -- Employment Size: 100-249 Employees
        -- ============================================================

        E100_249_NF AS establishments_100_249_flag,

        TRY_TO_NUMBER(E100_249) AS establishments_100_249,

        Q100_249_NF AS first_quarter_payroll_100_249_flag,

        TRY_TO_NUMBER(Q100_249) AS first_quarter_payroll_100_249,

        A100_249_NF AS annual_payroll_100_249_flag,

        TRY_TO_NUMBER(A100_249) AS annual_payroll_100_249,

        TRY_TO_NUMBER(N100_249) AS employment_100_249,


        -- ============================================================
        -- Employment Size: 250-499 Employees
        -- ============================================================

        E250_499_NF AS establishments_250_499_flag,

        TRY_TO_NUMBER(E250_499) AS establishments_250_499,

        Q250_499_NF AS first_quarter_payroll_250_499_flag,

        TRY_TO_NUMBER(Q250_499) AS first_quarter_payroll_250_499,

        A250_499_NF AS annual_payroll_250_499_flag,

        TRY_TO_NUMBER(A250_499) AS annual_payroll_250_499,

        TRY_TO_NUMBER(N250_499) AS employment_250_499,


        -- ============================================================
        -- Employment Size: 500-999 Employees
        -- ============================================================

        E500_999_NF AS establishments_500_999_flag,

        TRY_TO_NUMBER(E500_999) AS establishments_500_999,

        Q500_999_NF AS first_quarter_payroll_500_999_flag,

        TRY_TO_NUMBER(Q500_999) AS first_quarter_payroll_500_999,

        A500_999_NF AS annual_payroll_500_999_flag,

        TRY_TO_NUMBER(A500_999) AS annual_payroll_500_999,

        TRY_TO_NUMBER(N500_999) AS employment_500_999,


        -- ============================================================
        -- Employment Size: 1,000+ Employees
        -- ============================================================

        E1000_NF AS establishments_1000_plus_flag,

        TRY_TO_NUMBER(E1000) AS establishments_1000_plus,

        Q1000_NF AS first_quarter_payroll_1000_plus_flag,

        TRY_TO_NUMBER(Q1000) AS first_quarter_payroll_1000_plus,

        A1000_NF AS annual_payroll_1000_plus_flag,

        TRY_TO_NUMBER(A1000) AS annual_payroll_1000_plus,

        TRY_TO_NUMBER(N1000) AS employment_1000_plus

    FROM source

)

SELECT *
FROM renamed