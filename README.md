# U.S. Retail Market Intelligence System

An end-to-end **Analytics Engineering project** using Snowflake, dbt, SQL, Python, and Tableau to analyze U.S. retail-market fundamentals.

## Business Question

> **Which U.S. states have the strongest retail-market fundamentals, and what measurable economic and business factors explain that strength?**

Retail-market strength cannot be evaluated effectively using a single metric such as employment, number of establishments, or GDP alone.

This project integrates multiple U.S. government datasets to create a consistent state-level view of:

* Retail business activity
* Retail employment
* Retail payroll
* Total state economic output
* Retail industry's contribution to state GDP
* Retail economic output relative to employment and establishments

The analysis evaluates retail markets from three complementary perspectives:

* **Retail GDP Share** — the relative contribution of retail to the state economy
* **Retail Employment** — the scale of the retail workforce
* **Retail GDP per Employee** — retail economic output relative to retail employment

The project intentionally keeps these measures separate rather than combining them into a subjective composite score.

---

## Dashboard Preview

![U.S. Retail Market Intelligence Dashboard](tableau/dashboard_screenshot.png)

The Tableau dashboard presents the 2023 state-level retail-market analysis, including retail GDP, employment, establishments, payroll, GDP share, and geographic distribution.

---

## Project Objective

The objective is to build a reliable, tested, and analytics-ready data platform that transforms public government data into business-facing retail-market intelligence.

The project demonstrates an end-to-end Analytics Engineering workflow:

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
   Analytics CSV
        │
        ▼
 Tableau Dashboard
```

### Key Objectives

* Integrate retail business, employment, payroll, and GDP data from multiple government sources.
* Standardize geographic identifiers and source-specific data structures.
* Transform source data through modular dbt models.
* Maintain clearly defined model grains throughout the pipeline.
* Apply automated data-quality tests to validate transformations.
* Produce a stable analytical dataset for BI consumption.
* Create a Tableau dashboard for state-level retail-market analysis.
* Demonstrate practical Analytics Engineering principles from raw data to business-facing analytics.

---

# Architecture

The project follows a layered Analytics Engineering architecture that separates raw data, source-specific transformations, business logic, curated datasets, and analytical outputs.

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
   Analytics CSV
        │
        ▼
 Tableau Dashboard
```

## Layer Responsibilities

| Layer            | Purpose                                                                                                                      |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| **RAW**          | Stores source data in Snowflake while preserving the original source information.                                            |
| **STAGING**      | Cleans and standardizes source-specific data, including column names, data types, geographic identifiers, and source values. |
| **INTERMEDIATE** | Applies reusable business transformations and integrates related datasets into consistent business concepts.                 |
| **MARTS**        | Produces curated, business-ready datasets at a consistent State × Year grain.                                                |
| **ANALYTICS**    | Creates analysis-ready metrics and rankings used to answer the business question.                                            |
| **Tableau**      | Presents the final analytical results through an interactive business dashboard.                                             |

## Design Principles

The architecture follows several Analytics Engineering principles:

* **Separation of concerns** — source cleaning, business transformations, dimensional modeling, and analytical calculations are handled in separate layers.
* **Modular transformations** — business logic is divided into reusable dbt models rather than implemented in a single large transformation.
* **Consistent grain** — final marts and analytics models use a defined State × Year grain.
* **Source preservation** — raw government data is preserved in Snowflake before transformation.
* **Tested transformations** — dbt tests validate data integrity and business rules throughout the transformation pipeline.
* **BI-ready outputs** — the Analytics layer provides a stable interface for Tableau and other downstream analytical tools.

---

# Data Pipeline

The pipeline moves government source data through controlled transformation layers before delivering the final analytical output to Tableau.

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

## Pipeline Flow

### 1. Government CSV Files

Publicly available datasets from the U.S. Census Bureau and U.S. Bureau of Economic Analysis are downloaded as CSV files.

### 2. Snowflake RAW

The source files are loaded into Snowflake RAW tables.

The raw source information is preserved before transformation, including Census suppression and status codes in the County Business Patterns data.

### 3. dbt STAGING

The staging models clean and standardize the raw data.

This includes:

* Geographic identifier cleaning
* Column standardization
* Data-type conversion
* Source-specific filtering
* Preparation of datasets for downstream transformations

The staging layer remains closely aligned with the original source structure.

### 4. dbt INTERMEDIATE

The intermediate layer applies the core business logic.

Transformations include:

* Aggregating retail industries
* Transforming quarterly GDP observations into annual measures
* Separating Retail Trade GDP from total GDP
* Integrating business and economic datasets
* Creating derived business metrics
* Aligning datasets to the required analytical grain

### 5. dbt MARTS

The marts layer combines the transformed business concepts into curated, business-ready datasets at a consistent State × Year grain.

### 6. dbt ANALYTICS

The analytics layer produces the final analytical model, including:

* Retail GDP share
* Retail employment
* Productivity metrics
* State-level rankings

### 7. Analytics CSV

The final analytics dataset is exported from Snowflake as a CSV for downstream visualization.

### 8. Tableau Dashboard

The analytical output is connected to Tableau to create the Retail Market Intelligence dashboard.

The dashboard presents key retail-market KPIs, geographic distribution, and state rankings for 2023.

---

# Data Sources

This project uses publicly available data from the U.S. Census Bureau and the U.S. Bureau of Economic Analysis (BEA).

| Source                           | Dataset                                                                     | CSV File                                       | Purpose                                        |
| -------------------------------- | --------------------------------------------------------------------------- | ---------------------------------------------- | ---------------------------------------------- |
| U.S. Census Bureau               | American Community Survey (ACS) 2024 5-Year Estimates — Comparison Profiles | `ACS_2024_5Year_State_Comparison_Profiles.csv` | State population and demographic context       |
| U.S. Census Bureau               | County Business Patterns (CBP) 2023 — State File                            | `cbp23st.csv`                                  | Retail establishments, employment, and payroll |
| U.S. Bureau of Economic Analysis | State Quarterly GDP Summary (SQGDP1)                                        | `SQGDP1__ALL_AREAS_2005_2026.csv`              | Total state GDP                                |
| U.S. Bureau of Economic Analysis | GDP by State (SQGDP2)                                                       | `SQGDP2__ALL_AREAS_2005_2026.csv`              | Retail Trade GDP and industry-level GDP        |

### Official Data Sources

* U.S. Census Bureau — American Community Survey
* U.S. Census Bureau — County Business Patterns
* U.S. Bureau of Economic Analysis — Interactive Data

---

# Data Preparation and Cleaning

The source datasets were downloaded from official U.S. government data sources and loaded into Snowflake RAW tables.

The raw data was preserved as closely as possible to the original source data. Cleaning and standardization were performed through dbt transformation layers rather than manually modifying the source files.

Key preparation steps included:

* Standardizing state and geographic identifiers.
* Cleaning quoted and inconsistent FIPS codes.
* Converting source fields to appropriate analytical data types.
* Preserving Census suppression and status codes in CBP data.
* Handling suppressed or unavailable values without treating them as zero.
* Filtering BEA datasets to the required geographic and industry records.
* Reshaping quarterly GDP data into an analytical structure.
* Calculating annual GDP from quarterly observations when all four quarters were available.
* Aligning datasets to a common state and year grain.

---

# Data Transformation

## STAGING

The staging layer provides a clean and standardized representation of the raw Snowflake data.

Staging models were created for:

* ACS
* County Business Patterns
* SQGDP1
* SQGDP2

The staging layer handles:

* Source-specific cleaning
* Naming standardization
* Data-type conversion
* Geographic identifier standardization
* Source-specific filtering

The purpose of staging is to create a reliable representation of each source without introducing the main business logic.

---

## INTERMEDIATE

The intermediate layer transforms cleaned staging data into business-oriented datasets that can be used to build the final retail-market marts.

### Model Grain

Intermediate models use different grains depending on their business purpose.

| Intermediate Model     | Grain                        |
| ---------------------- | ---------------------------- |
| `int_acs_state`        | State × Year                 |
| `int_cbp_retail`       | State × 6-digit NAICS × Year |
| `int_cbp_retail_state` | State × Year                 |
| `int_retail_business`  | State × Year                 |
| `int_sqgdp1_total`     | State × Year                 |
| `int_sqgdp2_retail`    | State × Year                 |
| `int_retail_market`    | State × Year                 |

The `int_cbp_retail` model retains the detailed retail-industry grain of:

```text
State × 6-digit NAICS × Year
```

The other intermediate models primarily operate at:

```text
State × Year
```

### Business Transformations

The intermediate layer performs the core business transformations and integration logic, including:

* Aggregating County Business Patterns data from retail NAICS industries to the state level.
* Calculating state-level retail establishments, employment, and payroll.
* Transforming quarterly BEA GDP data into annual state-level GDP measures.
* Separating total state GDP from Retail Trade GDP.
* Calculating retail industry's share of total state GDP.
* Standardizing geographic identifiers across Census Bureau and BEA datasets.
* Joining retail business activity with state economic data.
* Aligning datasets to a common state and year grain.
* Creating derived productivity metrics such as employment per establishment and payroll per employee.

The intermediate layer converts source-specific data into consistent business concepts while keeping transformations modular and reusable.

---

# MARTS

The marts layer transforms intermediate business logic into curated, business-ready datasets designed for analysis and downstream consumption.

## Grain

The mart models use a consistent:

```text
State × Year
```

grain.

| Mart Model                 | Grain        | Purpose                               |
| -------------------------- | ------------ | ------------------------------------- |
| `mart_retail_state`        | State × Year | State-level retail business activity  |
| `mart_retail_market_state` | State × Year | Integrated retail-market fundamentals |

### Key Measures

The marts contain key measures including:

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

The marts provide a stable, business-friendly interface between transformation models and the Analytics and Tableau layers.

Analysts and BI tools can consume these models without needing to understand the underlying source-specific transformations.

---

# ANALYTICS

The Analytics layer transforms curated mart data into analysis-ready metrics and rankings that directly support the project's business question.

## Grain

The analytics model uses:

```text
State × Year
```

| Analytics Model                 | Grain        | Purpose                                                          |
| ------------------------------- | ------------ | ---------------------------------------------------------------- |
| `analytics_retail_market_state` | State × Year | Compare and rank U.S. states based on retail-market fundamentals |

## Final Analytical Output

The `analytics_retail_market_state` model contains:

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

---

# Ranking Methodology

The analytics model calculates three independent rankings using the SQL `RANK()` window function.

## 1. Retail GDP Share Rank

States are ranked by `RETAIL_GDP_SHARE` in descending order.

```sql
RANK() OVER (
    PARTITION BY YEAR
    ORDER BY RETAIL_GDP_SHARE DESC
)
```

A rank of 1 represents the state with the highest Retail Trade GDP as a percentage of total state GDP.

This measures the relative importance of retail to the state's economy.

---

## 2. Retail Employment Rank

States are ranked by `RETAIL_EMPLOYMENT` in descending order.

```sql
RANK() OVER (
    PARTITION BY YEAR
    ORDER BY RETAIL_EMPLOYMENT DESC
)
```

A rank of 1 represents the state with the largest retail workforce.

This measures retail-market scale in terms of employment.

---

## 3. Retail GDP per Employee Rank

States are ranked by `RETAIL_GDP_PER_RETAIL_EMPLOYEE` in descending order.

```sql
RANK() OVER (
    PARTITION BY YEAR
    ORDER BY RETAIL_GDP_PER_RETAIL_EMPLOYEE DESC
)
```

A rank of 1 represents the state with the highest retail GDP generated per retail employee.

This provides a productivity perspective on retail economic output.

---

## Why Three Rankings?

The three rankings provide complementary perspectives:

| Measure                     | Question                                                   |
| --------------------------- | ---------------------------------------------------------- |
| **Retail GDP Share**        | How important is retail to the state's overall economy?    |
| **Retail Employment**       | How large is the state's retail workforce?                 |
| **Retail GDP per Employee** | How much economic output is generated per retail employee? |

The project intentionally keeps these measures separate rather than combining them into a single composite score.

This avoids introducing subjective weighting assumptions and allows users to evaluate retail-market strength from multiple perspectives.

---

# Annual Data Coverage

The underlying government datasets contain different periods of annual and quarterly data.

The final integrated retail-market analysis is currently limited to **2023** because the County Business Patterns retail business data used in the project is available for 2023, while the BEA GDP datasets contain quarterly observations across multiple years.

The integrated datasets are therefore aligned to a common:

```text
State × Year
```

grain for 2023.

| Data Component           | Source Coverage Used  | Role in Analysis                               |
| ------------------------ | --------------------- | ---------------------------------------------- |
| ACS                      | 2024 5-Year Estimates | State population and demographic context       |
| CBP Retail               | 2023                  | Retail establishments, employment, and payroll |
| Total State GDP          | BEA quarterly data    | Annualized total state GDP for 2023            |
| Retail Trade GDP         | BEA quarterly data    | Annualized Retail Trade GDP for 2023           |
| Integrated Retail Market | 2023                  | Final state-level retail-market analysis       |

### GDP Annualization

For BEA GDP data, annual values are calculated from the four quarterly observations for the calendar year:

```text
Annual GDP = (Q1 + Q2 + Q3 + Q4) / 4
```

An annual GDP value is calculated only when all four quarterly observations are available.

The current analytics output contains **51 state-level records for 2023**, representing the 50 U.S. states plus the District of Columbia.

The multi-year BEA data provides an opportunity for future expansion when comparable annual CBP retail business data is incorporated.

---

# Year Alignment Note

The datasets do not all represent the same source year.

* CBP retail business data used in the integrated analysis is from **2023**.
* BEA GDP measures are calculated for **2023** from quarterly observations.
* ACS uses the **2024 5-Year Estimates**.

The ACS data is therefore treated as demographic context rather than as a directly equivalent 2023 business-year measure.

---

# Data Quality and Testing

Data quality was treated as an integral part of the Analytics Engineering workflow.

dbt tests validate:

* Data integrity
* Model relationships
* Business rules
* Model grain
* Analytical ranking logic

The project includes **68 data tests** across the staging, intermediate, marts, and analytics layers.

## Testing Includes

* **Not-null tests** — required fields contain values.
* **Unique tests** — business keys and identifiers do not contain unexpected duplicates.
* **Accepted-values tests** — fields contain expected values.
* **Relationship tests** — referential integrity is maintained between related models.
* **Business-key validation** — models maintain their intended grain and uniqueness.
* **Analytical ranking validation** — state rankings produce the expected number of distinct ranks.

## Full Project Validation

The complete dbt project was validated using:

```bash
dbt build
```

### Final Validation Results

| Validation             | Result |
| ---------------------- | -----: |
| dbt Models             |     14 |
| Data Tests             |     68 |
| Total Build Operations |     82 |
| Passed                 |     82 |
| Warnings               |      0 |
| Errors                 |      0 |
| Skipped                |      0 |

### Final Result

```text
82 / 82 operations passed successfully
```

This provides confidence that the transformed datasets meet the defined structural, integrity, and business-rule requirements before being consumed by Tableau.

The project also uses:

```bash
dbt docs generate
```

to generate documentation and a data catalog for models, sources, columns, and relationships.

---

# Tableau Dashboard

The dashboard presents U.S. state retail-market fundamentals for 2023.

It includes:

* Retail GDP
* Retail employment
* Retail establishments
* Annual retail payroll
* Retail GDP share
* Geographic distribution
* State-level rankings
* Retail productivity measures

The Tableau output is based on the final analytics dataset rather than directly querying the raw government data.

---

# Key Analytical Insights

The 2023 analysis demonstrates that retail-market strength can be evaluated from multiple complementary perspectives rather than through a single measure.

## 1. Retail is not equally important across state economies

Retail GDP Share measures the contribution of Retail Trade to a state's overall GDP.

This provides a different perspective from simply comparing the absolute size of retail GDP.

## 2. Retail-market scale varies across states

Retail Employment provides an indication of the size of the retail workforce and therefore the scale of retail business activity within each state.

The analysis allows states to be compared based on retail employment rather than relying only on overall state economic size.

## 3. Retail GDP per Employee provides a productivity perspective

Retail GDP per Retail Employee measures retail economic output relative to the size of the retail workforce.

This provides another perspective on retail-market productivity.

## 4. No single metric fully defines retail-market strength

The project intentionally maintains three separate analytical dimensions:

* **Retail GDP Share** — relative importance of retail to the state economy
* **Retail Employment** — retail-market scale
* **Retail GDP per Employee** — retail economic output per employee

Rather than creating a subjective composite score, the project allows users to evaluate state retail markets according to different dimensions.

### Overall Analytical Outcome

Integrating retail establishments, employment, payroll, and GDP measures provides a more complete view of state-level retail-market fundamentals than any individual metric alone.

---

# Limitations

The current project has several analytical limitations that should be considered when interpreting the results:

* The integrated retail-market analysis currently focuses on **2023** because the CBP retail business data used in the project is available for that year.
* ACS demographic context comes from the **2024 5-Year Estimates** and is not treated as a directly equivalent 2023 business-year measure.
* Retail GDP is annualized from quarterly BEA observations.
* Suppressed or unavailable CBP values are not automatically treated as zero.
* The current project does not produce a single composite retail-market score.
* The rankings describe different dimensions of retail-market activity and should not be interpreted as one overall measure of state economic performance.
* Future versions could incorporate comparable multi-year CBP data to support trend analysis.

---

# Technology Stack

| Technology               | Purpose                                                                 |
| ------------------------ | ----------------------------------------------------------------------- |
| **Snowflake**            | Cloud data warehouse for storing project data                           |
| **dbt Core**             | Data transformation, modeling, testing, and documentation               |
| **SQL**                  | Data cleaning, transformation, modeling, and analytical calculations    |
| **Python**               | Supporting data preparation and workflow tasks                          |
| **Tableau**              | Interactive business intelligence and visualization                     |
| **Git / GitHub**         | Version control and portfolio documentation                             |
| **Government Open Data** | Source data from the U.S. Census Bureau and Bureau of Economic Analysis |

## Analytics Engineering Practices Demonstrated

* Layered data modeling using **STAGING → INTERMEDIATE → MARTS → ANALYTICS**
* Separation of raw data from transformed analytical models
* Reusable SQL transformations with dbt
* Automated data-quality testing
* Model and column documentation
* Data lineage through dbt
* Preservation of source suppression/status codes
* Business-oriented analytical modeling
* Defined model grains
* Separation of data transformation from BI visualization
* BI-ready analytical outputs

---

# Quick Start

## Requirements

* Snowflake account
* dbt Core
* Python
* Git
* Tableau Public

## Workflow

### 1. Obtain the source data

Download the required government CSV datasets from the U.S. Census Bureau and U.S. Bureau of Economic Analysis.

### 2. Load the source data

Load the source files into the appropriate Snowflake RAW tables.

### 3. Configure dbt

Configure the dbt profile for the Snowflake environment.

### 4. Install dependencies

Install the required Python and dbt dependencies defined by the project.

### 5. Run the complete dbt project

```bash
dbt build
```

This executes the models and associated tests.

### 6. Generate dbt documentation

```bash
dbt docs generate
```

### 7. Export the analytics model

Export the final analytics model to CSV for downstream visualization.

### 8. Open the Tableau workbook

Open the Tableau workbook in Tableau Public/Desktop and connect it to the exported analytics dataset.

---

# Project Outcome

The project transforms multiple U.S. government datasets into a unified, tested, state-level retail-market analytical model.

The completed workflow demonstrates the ability to:

1. Identify and assess appropriate public data sources.
2. Load raw government datasets into Snowflake.
3. Build a structured dbt transformation pipeline.
4. Create reusable STAGING, INTERMEDIATE, MARTS, and ANALYTICS models.
5. Maintain defined model grains throughout the pipeline.
6. Apply automated data-quality testing.
7. Transform source-specific datasets into reusable business concepts.
8. Produce an analytics-ready state-level dataset.
9. Develop a business-facing Tableau dashboard.
10. Translate data into multiple measurable dimensions of retail-market fundamentals.

The final result is a reproducible Analytics Engineering workflow connecting:

```text
Public Government Data
        ↓
Snowflake
        ↓
dbt
        ↓
Tested Analytical Models
        ↓
Analytics Dataset
        ↓
Tableau
        ↓
Business Insights
```

The project demonstrates practical skills in **SQL, Snowflake, dbt, data modeling, data quality, documentation, Python, and Tableau**, with an emphasis on producing reliable analytical data for business analysis.
