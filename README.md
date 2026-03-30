# Burnout Index Dashboard

Analytics project focused on building a burnout index based on risk variables and protective factors. The project included data cleaning and transformation in Python, dashboard development in Power BI, and metric validation using SQL in BigQuery.

## Project Objective

Develop a comprehensive burnout analysis that would allow:

- building a composite burnout index
- classifying employees into risk categories
- analyzing burnout distribution by area
- identifying associated risk and protective factors

## Tools Used

- **Python**: data cleaning, transformation, and burnout index construction
- **SQL (BigQuery)**: metric validation and analytical queries
- **Power BI**: dashboard development and data visualization
- **DAX**: KPI and visualization logic in Power BI

## Project Flow

The project was developed in three complementary layers:

**Python → Power BI**  
**BigQuery / SQL → analytical validation of results**

### 1. Python
Python was the main tool used for the ETL process and burnout index construction. This stage included:

- loading and exploring the dataset
- checking duplicates
- creating the `cumplimiento_pausas` variable
- selecting risk and protective variables
- min-max scaling to a common 0–10 range
- inverting protective variables
- calculating the `indice_burnout`
- classifying records into `Low`, `Medium`, and `High`

### Example Python transformation
![Burnout-Index-Dashboard](01_assets/python_trasformation.png)

### 2. Power BI
Power BI was used to build the dashboard, create KPIs, and visualize the results. The dashboard includes:

- total employees evaluated
- average burnout index
- burnout distribution by area
- overall burnout distribution
- risk factors
- protective factors

### 3. SQL in BigQuery
BigQuery was used as an analytical validation layer. The final table was uploaded to BigQuery in order to validate the results obtained in Power BI through SQL queries, especially for metrics such as:

- total employees evaluated
- average burnout index
- burnout category distribution
- burnout distribution by area
- average risk factors
- average protective factors

## Main Metrics Analyzed

- **Total employees evaluated**
- **Average burnout index**
- **Overall burnout distribution**
- **Burnout distribution by area**
- **Risk factors**
- **Protective factors**

## Repository Structure

```text
burnout-index-dashboard/
│
├── README.md
├── requirements.txt
│
├── python/
│   └── 01_etl_burnout_limpio.py
│
├── sql/
│   ├── 01_validacion_total_personas.sql
│   ├── 02_validacion_promedio_indice.sql
│   ├── 03_distribucion_categoria_burnout.sql
│   ├── 04_distribucion_burnout_por_area.sql
│   ├── 05_promedio_factores_riesgo.sql
│   └── 06_promedio_factores_protectores.sql
│
├── powerbi/
│   ├── dashboard_indice_burnout.pbix
│   └── medidas_dax.md
│
├── assets/
│   └── dashboard_general.png
│
└── data/
```

### Python ETL

The ETL process transformed the original variables into an analytical dataset ready for visualization and validation. Key transformations included:

- creating cumplimiento_pausas
- standardizing variables to a 0–10 scale
- converting protective factors into risk-oriented logic
- building the final index as the average of six dimensions
- categorizing the index into burnout levels

### Featured SQL Queries

### Validation query — Total employees evaluated
```sql
SELECT COUNT(DISTINCT employee_id) AS total_employees
FROM `burnoutindex-490619.burnout_analytics.burnout_analytics`;
```
### Validation of average burnout index
```sql
SELECT ROUND(AVG(indice_burnout), 2) AS average_burnout_index
FROM `burnoutindex-490619.burnout_analytics.burnout_analytics`;
```
### Burnout distribution by area
```sql
SELECT
  area,
  categoria_burnout,
  COUNT(DISTINCT employee_id) AS total_employees,
  ROUND(
    COUNT(DISTINCT employee_id) * 100.0
    / SUM(COUNT(DISTINCT employee_id)) OVER (PARTITION BY area),
    2
  ) AS percentage_within_area
FROM `burnoutindex-490619.burnout_analytics.burnout_analytics`
GROUP BY area, categoria_burnout
ORDER BY
  area,
  CASE
    WHEN categoria_burnout = 'Bajo' THEN 1
    WHEN categoria_burnout = 'Medio' THEN 2
    WHEN categoria_burnout = 'Alto' THEN 3
    ELSE 99
  END;
```
### Documented DAX Logic
Inside the powerbi/ folder, the repository includes a medidas_dax.md file with the main expressions used to document the dashboard logic, including:

- total employees evaluated
- average burnout index
- protective factors
- risk factors
- Dashboard

### Example DAX measure
```
Total Employees Evaluated = DISTINCTCOUNT('burnout_analytics'[employee_id])
```
### Dashboard
The dashboard was designed in Power BI to provide an executive-level view of the data, allowing users to analyze:

- overall burnout level
- burnout distribution by area
- category composition
- factors that may increase or reduce the index

![Burnout Index Dashboard](assets/dashboard_general.png)

### General Insights
- The index summarizes multiple risk and protective dimensions into a single metric.
- Category distribution helps identify groups that may require closer monitoring.
- Area-level analysis makes it possible to compare risk profiles across teams or units.
- Visualizing risk and protective factors improves the interpretation of the final burnout score.
- Methodology Note

This project did not use BigQuery as the main analytical pipeline source. The burnout index was built in Python, and the dashboard was developed in Power BI. SQL in BigQuery was used as a validation methodology to ensure that DAX results matched direct SQL queries on the uploaded table.

### Considerations
For a public repository, identifiers should be anonymized and sensitive personal data should not be shared.

### Author

### Camila Alvarez
Project developed as part of a data analytics / People Analytics portfolio.

