# 🔥 Workload & Burnout Analytics Dashboard  
### Monitoring Burnout Index, High-Risk Employees, and Workload by Department

This project visualizes and analyzes employee burnout levels across an organization of 600 workers using **Power BI**, **Google Sheets**, and **People Analytics**.  
The dashboard identifies high-risk groups, highlights departmental trends, and supports evidence-based decision-making to improve employee well-being.

---

## 🧠 Methodology

### 1. Data Cleaning & Standardization
- Removal of duplicates and inconsistent records  
- Burnout Index scale adjustment:  
  Original scale **0–60** → Final scale **0–10**  
- Categorization into:
  - **Low**
  - **Medium**
  - **High**

### 2. Power BI Measures (DAX)

```DAX
BurnoutIndex_Final =
DIVIDE(Cargalaboral[BurnoutIndex_NEW], 6)

Total Colaboradores =
COUNTROWS(Cargalaboral)

Colabs Riesgo Alto =
CALCULATE(
    COUNTROWS(Cargalaboral),
    Cargalaboral[Burnout_Categoria] = "Alto"
)

Porcentaje_Riesgo_Alto =
DIVIDE([Colabs Riesgo Alto], [Total Colaboradores])
```

---

## 📌 Key Performance Indicators (KPIs)

- **Average Burnout Score**
- **Total Employees (600)**
- **Employees at High Risk (33)**
- **% of High-Risk Employees (5.5%)**

---

## 📊 Dashboard Visualizations

- Burnout Average by Department  
- Distribution of Low / Medium / High Categories  
- Slicers for Department, Role, and Work Schedule  
- Burnout Risk Pie Chart  
- Top KPI Cards  

### Dashboard Preview

![Dashboard Preview](./images/dashboard_preview.png)

---

## 🧰 Tools & Technologies

- **Power BI**
- **Google Sheets**
- **DAX**
- **GitHub**
- **People Analytics**

---

## 📁 Repository Structure

```
/Burnout-Analytics-Dashboard
    ├── Burnout.pbix               # Power BI dashboard file
    ├── data/                      # Clean and processed dataset
    ├── images/                    # Dashboard screenshots
    └── README.md                  # Project documentation
```

---

## 🚀 How to Use This Project

1. Download the **Burnout.pbix** file  
2. Open it using **Power BI Desktop**  
3. (Optional) Connect your own dataset  
4. Explore insights by department, role, and burnout level  

---

## 💡 Key Insights

- Clinical departments show the highest burnout averages  
- 33 employees fall under **High Risk**  
- 5.5% of the workforce needs immediate intervention  
- Burnout distribution helps guide organizational well-being strategies  

---

## 👩‍💻 Author

**Camila Álvarez**  
Specialist in Physical Activity, Workplace Wellness & People Analytics  
GitHub: https://github.com/Cami2025  

---

## ⭐ Support the Project

If you found this project valuable, feel free to give it a **⭐ star** on GitHub!  
It helps showcase my work and encourages me to continue building powerful analytics solutions.
