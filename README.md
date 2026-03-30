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

Python ETL

The ETL process transformed the original variables into an analytical dataset ready for visualization and validation. Key transformations included:

creating cumplimiento_pausas
standardizing variables to a 0–10 scale
converting protective factors into risk-oriented logic
building the final index as the average of six dimensions
categorizing the index into burnout levels

Featured SQL Queries
Validation of total employees evaluated

SELECT COUNT(DISTINCT employee_id) AS total_personas
FROM `burnoutindex-490619.burnout_analytics.burnout_analytics`;
