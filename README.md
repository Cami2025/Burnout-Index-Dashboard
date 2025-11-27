# 🔥 Carga Laboral & Burnout Analytics Dashboard  
### Monitoreo del Índice de Burnout, Riesgo Alto y Carga Laboral por Área

Este proyecto visualiza y analiza el nivel de burnout laboral en una organización de 600 colaboradores, utilizando **Power BI**, **Google Sheets** y **People Analytics**.  
El dashboard permite identificar áreas críticas, distribución de riesgo, perfiles más afectados y oportunidades de intervención para mejorar el bienestar laboral.

---

## 📊 Objetivo del Proyecto

El propósito de este dashboard es:

- Medir el **Burnout Index** de cada colaborador.
- Identificar **colaboradores en riesgo alto**.
- Analizar el burnout **por área**, **rol** y **jornada**.
- Mostrar la distribución **Bajo / Medio / Alto**.
- Facilitar decisiones de bienestar basadas en datos (People Analytics).

---

## 🧠 Metodología

### 1. **Limpieza y estandarización del dataset**
- Eliminación de duplicados y registros corruptos.
- Corrección de escalas:  
  El índice original (0–60) se ajustó a una escala estándar (0–10).
- Creación de categorías:
  - **Bajo**
  - **Medio**
  - **Alto**  
  Basado en puntos de corte definidos según literatura de burnout.

### 2. **Cálculos en Power BI (DAX)**
Se construyeron medidas clave:

```DAX
BurnoutIndex_Final = DIVIDE(Cargalaboral[BurnoutIndex_NEW], 6)

Total Colaboradores = COUNTROWS(Cargalaboral)

Colabs Riesgo Alto =
CALCULATE(COUNTROWS(Cargalaboral), Cargalaboral[Burnout_Categoria] = "Alto")

Porcentaje_Riesgo_Alto =
DIVIDE([Colabs Riesgo Alto], [Total Colaboradores])
