# U.S. Retail Market Intelligence System

## Business Problem

Retail businesses, investors, and market analysts need to understand which U.S. states offer the strongest retail-market fundamentals. However, retail performance cannot be evaluated effectively using a single metric such as total employment, number of establishments, or GDP alone.

The challenge is to combine multiple government data sources to create a consistent state-level view of the retail market and identify differences in:

* Retail business activity
* Retail employment
* Retail payroll
* Overall state economic output
* Retail industry's contribution to state GDP
* Retail GDP relative to employment and establishments

The business problem this project addresses is:

> **Which U.S. states have the strongest retail-market fundamentals, and what factors distinguish stronger retail markets from weaker ones?**

The analysis provides a standardized, state-level dataset that can be used to compare retail-market size, economic contribution, and productivity across U.S. states.

## Project Objective

The objective of this project is to build a reliable, analytics-ready data platform that combines U.S. government economic and business datasets to evaluate retail-market fundamentals across U.S. states.

The project aims to:

* Integrate retail business, employment, payroll, and GDP data from multiple government sources.
* Build a structured **Snowflake → dbt** data transformation pipeline using Staging, Intermediate, Marts, and Analytics layers.
* Standardize geographic identifiers and align source datasets to a common **State × Year** analytical grain.
* Create consistent business metrics for retail-market size, economic contribution, and productivity.
* Apply dbt data tests to validate data quality, model integrity, and business rules throughout the transformation pipeline.
* Produce a final analytical dataset suitable for direct consumption by BI and visualization tools.
* Develop a Tableau dashboard that enables users to compare retail-market fundamentals across U.S. states.
* Demonstrate an end-to-end **Analytics Engineering workflow**, from raw government data through tested analytical models to business-facing insights.

The final analytical output is designed to provide a consistent foundation for evaluating differences in retail-market scale, economic importance, employment, and productivity across U.S. states.

## Architecture

The project follows a layered Analytics Engineering architecture designed to separate raw data ingestion, source-specific transformations, business logic, curated datasets, and analytical outputs.

```text
Government Data Sources
        │
        ▼
   Snowflake RAW
        │
        ▼
    dbt STAGING
        │
        ▼
 dbt INTERMEDIATE
        │
        ▼
     dbt MARTS
        │
        ▼
   dbt ANALYTICS
        │
        ▼
       CSV
        │
        ▼
   Tableau Dashboard
```

### Layer Responsibilities

| Layer            | Purpose                                                                                                                      |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| **RAW**          | Stores the source data in Snowflake while preserving the original source information.                                        |
| **STAGING**      | Cleans and standardizes source-specific data, including column names, data types, geographic identifiers, and source values. |
| **INTERMEDIATE** | Applies reusable business transformations and integrates related datasets into consistent business concepts.                 |
| **MARTS**        | Produces curated, business-ready datasets at a consistent State × Year grain.                                                |
| **ANALYTICS**    | Creates analysis-ready metrics and rankings used to answer the project's business question.                                  |
| **Tableau**      | Presents the final analytical results through an interactive business dashboard.                                             |

### Design Principles

The architecture follows several Analytics Engineering principles:

* **Separation of concerns** — Source cleaning, business transformations, dimensional modeling, and analytical calculations are handled in separate layers.
* **Modular transformations** — Business logic is divided into reusable dbt models rather than implemented in a single large transformation.
* **Consistent grain** — The final marts and analytics model use a defined **State × Year** grain.
* **Source preservation** — Raw government data is preserved in Snowflake before transformation.
* **Tested transformations** — dbt tests validate data integrity and business rules throughout the transformation pipeline.
* **BI-ready outputs** — The Analytics layer provides a stable interface for Tableau and other downstream analytical tools.

This architecture allows the project to evolve from a single-year analysis into a multi-year retail-market intelligence platform as additional comparable source data becomes available.

## Data Pipeline

The data pipeline moves the government source data through a series of controlled transformation layers before delivering the final analytical output to Tableau.

```text
Government CSV Files
        ↓
Snowflake RAW
        ↓
dbt STAGING
        ↓
dbt INTERMEDIATE
        ↓
dbt MARTS
        ↓
dbt ANALYTICS
        ↓
Analytics CSV
        ↓
Tableau Dashboard
```

### Pipeline Flow

**1. Government CSV Files**

Publicly available datasets from the U.S. Census Bureau and U.S. Bureau of Economic Analysis are downloaded as CSV files.

**2. Snowflake RAW**

The source files are loaded into Snowflake RAW tables. Raw source information is preserved before transformation, including Census suppression and status codes in the CBP data.

**3. dbt STAGING**

The staging models clean and standardize the raw data. This includes geographic identifier cleaning, column standardization, data-type conversion, source-specific filtering, and preparation of the datasets for downstream transformations.

**4. dbt INTERMEDIATE**

The intermediate layer applies the core business logic. Retail industries are aggregated, quarterly GDP data is transformed into annual measures, Retail Trade GDP is separated from total GDP, and the datasets are integrated at the required business grain.

**5. dbt MARTS**

The marts layer combines the transformed business concepts into curated, business-ready datasets at a consistent **State × Year** grain.

**6. dbt ANALYTICS**

The analytics layer produces the final analytical model, including retail GDP share, productivity metrics, and state-level rankings used to compare retail-market fundamentals.

**7. Analytics CSV**

The final analytics dataset is exported from Snowflake as a CSV for downstream visualization.

**8. Tableau Dashboard**

The analytical output is connected to Tableau to create the **Retail Market Intelligence** dashboard, presenting key retail-market KPIs, geographic distribution, and state rankings for 2023.

This pipeline separates data preparation, transformation, business logic, and presentation, creating a reproducible workflow from raw government data to business-facing analytics.


## Data Sources

This project uses publicly available data from the U.S. Census Bureau and the U.S. Bureau of Economic Analysis (BEA).

| Source | Dataset | CSV File | Purpose |
|---|---|---|---|
| U.S. Census Bureau | American Community Survey (ACS) 2024 5-Year Estimates — Comparison Profiles | `ACS_2024_5Year_State_Comparison_Profiles.csv` | State population and demographic context |
| U.S. Census Bureau | County Business Patterns (CBP) 2023 — State File | `cbp23st.csv` | Retail establishments, employment, and payroll |
| U.S. Bureau of Economic Analysis (BEA) | State Quarterly GDP Summary (SQGDP1) | `SQGDP1__ALL_AREAS_2005_2026.csv` | Total state GDP |
| U.S. Bureau of Economic Analysis (BEA) | GDP by State (SQGDP2) | `SQGDP2__ALL_AREAS_2005_2026.csv` | Retail Trade GDP and industry-level GDP |

### Official Source Websites

- [U.S. Census Bureau — American Community Survey](https://www.census.gov/data/developers/data-sets/acs-5year/2024.html)
- [U.S. Census Bureau — County Business Patterns](https://www.census.gov/data/datasets/2023/econ/cbp/2023-cbp.html)
- [U.S. Bureau of Economic Analysis — Interactive Data](https://www.bea.gov/itable)

## Data Preparation and Cleaning

The source datasets were downloaded from official U.S. government data sources and loaded into Snowflake RAW tables.

The raw data was preserved as closely as possible to the original source data. Cleaning and standardization were performed through the dbt transformation layers rather than manually modifying the source files.

Key preparation steps included:

- Standardizing state and geographic identifiers.
- Cleaning quoted and inconsistent FIPS codes.
- Converting source fields to appropriate analytical data types.
- Preserving Census suppression and status codes in the CBP data.
- Handling suppressed or unavailable values without treating them as zero.
- Filtering the BEA datasets to the required geographic and industry records.
- Reshaping quarterly GDP data into an analytical structure.
- Calculating annual GDP from quarterly observations when all four quarters were available.
- Aligning datasets to a common state and year grain.


## Data Transformation

### Staging

The staging layer provides a clean and standardized representation of the raw Snowflake data.

Staging models were created for:

- ACS
- County Business Patterns
- SQGDP1
- SQGDP2

The staging layer handles source-specific cleaning, naming standardization, data type conversion, and filtering while maintaining a close relationship with the original source data.

### Intermediate

The intermediate layer transforms the cleaned staging data into business-oriented datasets that can be used to build the final retail-market marts.

#### Grain

The intermediate models use different grains depending on the business purpose of each model:

| Intermediate Model     | Grain                        |
| ---------------------- | ---------------------------- |
| `int_acs_state`        | State × Year                 |
| `int_cbp_retail`       | State × 6-digit NAICS × Year |
| `int_cbp_retail_state` | State × Year                 |
| `int_retail_business`  | State × Year                 |
| `int_sqgdp1_total`     | State × Year                 |
| `int_sqgdp2_retail`    | State × Year                 |
| `int_retail_market`    | State × Year                 |

The `int_cbp_retail` model retains the detailed retail-industry grain of **State × 6-digit NAICS × Year**, while the other intermediate models primarily operate at the **State × Year** level.

This layer performs the core business transformations and integration logic, including:

* Aggregating County Business Patterns data from retail NAICS industries to the state level.
* Calculating state-level retail establishments, employment, and payroll metrics.
* Transforming quarterly BEA GDP data into annual state-level GDP measures.
* Separating total state GDP from Retail Trade GDP.
* Calculating the retail industry's share of total state GDP.
* Standardizing geographic identifiers across Census Bureau and BEA datasets.
* Joining retail business activity with state economic data.
* Aligning datasets to a common state and year grain.
* Creating derived productivity metrics such as employment per establishment and payroll per employee.

The intermediate models provide the foundation for the marts by converting source-specific data into consistent business concepts while keeping the transformations modular and reusable.


### Marts

The marts layer transforms the intermediate business logic into curated, business-ready datasets designed for analysis and downstream consumption.

#### Grain

The mart models use a consistent **State × Year** grain.

| Mart Model                 | Grain        | Purpose                               |
| -------------------------- | ------------ | ------------------------------------- |
| `mart_retail_state`        | State × Year | State-level retail business activity  |
| `mart_retail_market_state` | State × Year | Integrated retail-market fundamentals |

The marts layer combines and organizes the key retail and economic measures required to answer the project's business question.

Key measures include:

* Retail establishments
* Retail employment
* Retail annual payroll
* Total state GDP
* Retail Trade GDP
* Retail GDP share of total state GDP
* Retail employment per establishment
* Retail payroll per employee
* Retail GDP per establishment
* Retail GDP per retail employee

The mart models provide a stable, business-friendly interface between the transformation layers and the Analytics and Tableau layers. They are designed to be easy for analysts and BI tools to consume without requiring knowledge of the underlying source-specific transformations.

### Analytics

The analytics layer transforms the curated mart data into analysis-ready metrics and rankings that directly support the project's business question.

#### Grain

The analytics model uses a **State × Year** grain.

| Analytics Model                 | Grain        | Purpose                                                          |
| ------------------------------- | ------------ | ---------------------------------------------------------------- |
| `analytics_retail_market_state` | State × Year | Compare and rank U.S. states based on retail-market fundamentals |

#### Final Analytical Output

The `analytics_retail_market_state` model contains the following columns:

| Column                                | Description                                    |
| ------------------------------------- | ---------------------------------------------- |
| `STATE_FIPS`                          | State FIPS geographic identifier               |
| `STATE_NAME`                          | State name                                     |
| `YEAR`                                | Data year                                      |
| `RETAIL_ESTABLISHMENTS`               | Total retail establishments                    |
| `RETAIL_EMPLOYMENT`                   | Total retail employment                        |
| `RETAIL_ANNUAL_PAYROLL`               | Total annual retail payroll                    |
| `TOTAL_GDP_ANNUAL`                    | Total annual state GDP                         |
| `RETAIL_GDP_ANNUAL`                   | Annual Retail Trade GDP                        |
| `RETAIL_GDP_SHARE`                    | Retail Trade GDP as a share of total state GDP |
| `RETAIL_EMPLOYMENT_PER_ESTABLISHMENT` | Retail employment per establishment            |
| `RETAIL_PAYROLL_PER_EMPLOYEE`         | Annual retail payroll per employee             |
| `RETAIL_GDP_PER_ESTABLISHMENT`        | Retail GDP generated per establishment         |
| `RETAIL_GDP_PER_RETAIL_EMPLOYEE`      | Retail GDP generated per retail employee       |
| `RETAIL_GDP_SHARE_RANK`               | State ranking based on retail GDP share        |
| `RETAIL_EMPLOYMENT_RANK`              | State ranking based on retail employment       |
| `RETAIL_GDP_PER_EMPLOYEE_RANK`        | State ranking based on retail GDP per employee |

#### Ranking Methodology

The analytics model calculates three independent rankings using the SQL `RANK()` window function.

##### 1. Retail GDP Share Rank

States are ranked by `RETAIL_GDP_SHARE` in descending order.

```sql
RANK() OVER (
    PARTITION BY YEAR
    ORDER BY RETAIL_GDP_SHARE DESC
)
```

A rank of **1** represents the state with the highest Retail Trade GDP as a percentage of total state GDP.

This ranking measures the **relative importance of retail to the state's economy**.

##### 2. Retail Employment Rank

States are ranked by `RETAIL_EMPLOYMENT` in descending order.

```sql
RANK() OVER (
    PARTITION BY YEAR
    ORDER BY RETAIL_EMPLOYMENT DESC
)
```

A rank of **1** represents the state with the largest retail workforce.

This ranking measures **retail-market scale in terms of employment**.

##### 3. Retail GDP per Employee Rank

States are ranked by `RETAIL_GDP_PER_RETAIL_EMPLOYEE` in descending order.

```sql
RANK() OVER (
    PARTITION BY YEAR
    ORDER BY RETAIL_GDP_PER_RETAIL_EMPLOYEE DESC
)
```

A rank of **1** represents the state with the highest retail GDP generated per retail employee.

This ranking provides a measure of **retail economic output per employee**.

#### Why Three Rankings?

The three rankings provide complementary perspectives on retail-market strength:

* **Retail GDP Share** — How important is retail to the state's overall economy?
* **Retail Employment** — How large is the state's retail workforce?
* **Retail GDP per Employee** — How much economic output is generated per retail employee?

The analytics layer intentionally keeps these measures separate rather than combining them into a single composite score. This avoids introducing subjective weighting assumptions and allows users to evaluate retail-market strength from multiple perspectives.

The resulting analytics table is designed for direct consumption by Tableau and other business intelligence tools.

#### Annual Data Coverage

The underlying government datasets contain different periods of annual and quarterly data. However, the final integrated retail-market analysis is currently limited to **2023**.

The primary reason is that the County Business Patterns (CBP) retail business data used in this project is available for **2023**, while the BEA GDP datasets contain quarterly observations across multiple years.

For the integrated analysis, the datasets are therefore aligned to a common **State × Year** grain for **2023**.

| Data Component           | Source Coverage Used  | Role in Analysis                               |
| ------------------------ | --------------------- | ---------------------------------------------- |
| ACS                      | 2024 5-Year Estimates | State population and demographic context       |
| CBP Retail               | 2023                  | Retail establishments, employment, and payroll |
| Total State GDP          | BEA quarterly data    | Annualized total state GDP for 2023            |
| Retail Trade GDP         | BEA quarterly data    | Annualized Retail Trade GDP for 2023           |
| Integrated Retail Market | 2023                  | Final state-level retail-market analysis       |

For BEA GDP, annual values are calculated from the four quarterly observations for the calendar year:

```text
Annual GDP = (Q1 + Q2 + Q3 + Q4) / 4
```

An annual GDP value is calculated only when all four quarterly observations are available.

As a result, the current analytics output contains **51 state-level records for 2023**, representing the 50 U.S. states plus the District of Columbia.

The multi-year BEA data provides an opportunity for future expansion of the project when comparable annual CBP retail business data is incorporated.

## Data Quality and Testing

Data quality was treated as an integral part of the Analytics Engineering workflow. dbt tests were used to validate data integrity, model relationships, and business rules throughout the transformation pipeline.

The project includes **68 data tests** covering the staging, intermediate, marts, and analytics layers.

Testing includes:

* **Not-null tests** — Ensures required fields contain values.
* **Unique tests** — Ensures columns used as business keys or identifiers do not contain unexpected duplicates.
* **Accepted-values tests** — Validates that fields contain only expected values.
* **Relationship tests** — Validates referential integrity between related models.
* **Business-key validation** — Confirms that models maintain their intended grain and uniqueness.
* **Analytical ranking validation** — Confirms that the state rankings produce the expected number of distinct ranks.

### Full Project Validation

The complete dbt project was validated using:

```bash
dbt build
```

Final validation results:

| Validation             | Result |
| ---------------------- | -----: |
| dbt Models             |     14 |
| Data Tests             |     68 |
| Total Build Operations |     82 |
| Passed                 |     82 |
| Warnings               |      0 |
| Errors                 |      0 |
| Skipped                |      0 |

**Final result: 82/82 operations passed successfully.**

This provides confidence that the transformed datasets meet the defined structural, integrity, and business-rule requirements before being consumed by Tableau.

The project also uses `dbt docs generate` to generate documentation and a data catalog for the models, sources, columns, and relationships in the dbt project.

### Full Project Validation

The complete dbt project was validated using:

```bash
dbt build
```

Final validation results:

| Validation             | Result |
| ---------------------- | -----: |
| dbt Models             |     14 |
| Data Tests             |     68 |
| Total Build Operations |     82 |
| Passed                 |     82 |
| Warnings               |      0 |
| Errors                 |      0 |
| Skipped                |      0 |

**Final result: 82/82 operations passed successfully.**

This provides confidence that the transformed datasets meet the defined structural, integrity, and business-rule requirements before being consumed by Tableau.

The project also uses `dbt docs generate` to generate documentation and a data catalog for the models, sources, columns, and relationships in the dbt project.

## Tableau Dashboard
![Screenshot 2026-09-09 at 14.54.06.png](tableau/Screenshot%202026-09-09%20at%2014.54.06.png)

The dashboard presents U.S. state retail-market fundamentals for 2023,
including retail GDP, employment, establishments, annual payroll,
retail GDP share, and geographic distribution.

## Key Findings

The 2023 analysis demonstrates that retail-market strength can be evaluated from multiple complementary perspectives rather than through a single measure.

### 1. Retail is not equally important across state economies

**Retail GDP Share** measures the contribution of Retail Trade to a state's overall GDP. States with higher retail GDP shares have a greater relative dependence on retail economic activity.

This provides a different perspective from simply comparing the total size of retail GDP.

### 2. Retail-market scale varies substantially across states

**Retail Employment** provides an indication of the size of the retail workforce and therefore the scale of retail business activity within each state.

The analysis allows states to be compared based on the size of their retail employment base rather than relying only on overall economic size.

### 3. Retail economic output per employee provides a productivity perspective

**Retail GDP per Retail Employee** measures retail economic output relative to the size of the retail workforce.

This provides an additional perspective on retail-market productivity and helps distinguish markets with large retail employment from markets that generate relatively high economic output per employee.

### 4. No single metric fully defines retail-market strength

The analysis intentionally maintains the three rankings separately:

* **Retail GDP Share** — relative importance of retail to the state economy
* **Retail Employment** — retail-market scale
* **Retail GDP per Employee** — retail economic output per employee

Rather than creating a subjective composite score, the project allows users to evaluate state retail markets according to different dimensions of market strength.

### Overall Finding

The analysis demonstrates the value of integrating business activity and economic data into a common analytical model. Combining retail establishments, employment, payroll, and GDP measures provides a more complete view of state-level retail-market fundamentals than any individual metric alone.


## Technology Stack

This project uses a modern Analytics Engineering stack to transform public government data into a tested analytical dataset and business-facing dashboard.

| Technology               | Purpose                                                              |
| ------------------------ | -------------------------------------------------------------------- |
| **Snowflake**            | Cloud data warehouse for storing and transforming project data       |
| **dbt Core**             | Data transformation, modeling, testing, and documentation            |
| **SQL**                  | Data cleaning, transformation, modeling, and analytical calculations |
| **Python**               | Supporting data preparation and workflow tasks                       |
| **Tableau**              | Interactive business intelligence and visualization                  |
| **Git / GitHub**         | Version control and portfolio documentation                          |
| **Government Open Data** | Source data from U.S. Census Bureau and Bureau of Economic Analysis  |

### Analytics Engineering Practices

The project demonstrates several core Analytics Engineering practices:

* Layered data modeling using **STAGING → INTERMEDIATE → MARTS → ANALYTICS**
* Separation of raw data from transformed analytical models
* Reusable SQL transformations with dbt
* Data validation through automated dbt tests
* Documentation and data lineage using dbt
* Preservation of source suppression/status codes where appropriate
* Business-oriented analytical modeling
* Separation of data transformation from BI visualization

## Project Outcome

The project successfully transforms multiple U.S. government datasets into a unified state-level retail-market analytical model.

The completed workflow demonstrates the ability to:

1. Identify and assess appropriate public data sources
2. Load raw government datasets into Snowflake
3. Build a structured dbt transformation pipeline
4. Create reusable STAGING, INTERMEDIATE, MARTS, and ANALYTICS models
5. Apply automated data-quality testing throughout the pipeline
6. Produce an analytics-ready state-level dataset
7. Develop a business-facing Tableau dashboard
8. Translate the resulting data into meaningful retail-market insights

The final result is a reproducible Analytics Engineering workflow that connects **raw public data to business intelligence**.

The project demonstrates practical skills in **SQL, Snowflake, dbt, data modeling, data quality, documentation, and Tableau**, with an emphasis on producing reliable analytical data for business decision-making.





