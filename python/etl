# =========================================
# ETL ÍNDICE DE BURNOUT
# Versión limpia y ordenada
# =========================================

import pandas as pd

# =========================================
# CONFIGURACIÓN
# =========================================

pd.set_option("display.max_columns", None)
pd.set_option("display.width", None)

archivo_entrada = "Indice_Burnout.csv"

# =========================================
# PASO 1
# CARGAR Y EXPLORAR EL DATASET
# =========================================

df = pd.read_csv(archivo_entrada, sep=";")

print("Dimensiones del dataset:", df.shape)

print("\nColumnas del dataset:")
for col in df.columns:
    print("-", col)

print("\nPrimeras 5 filas del dataset:")
print(df.head().to_string())

print("\nInformación general del dataset:")
df.info()

print("\nCantidad de filas duplicadas:")
print(df.duplicated().sum())

print("\nResumen estadístico de variables numéricas:")
print(df.describe().T.to_string())

# Exportar CSV del paso 1
df.to_csv("paso_1_base_original.csv", index=False, sep=";")
print("\nArchivo CSV guardado correctamente como: paso_1_base_original.csv")


# =========================================
# PASO 2
# CREAR VARIABLE DE CUMPLIMIENTO DE PAUSAS
# =========================================

df["cumplimiento_pausas"] = (
    df["pausas_realizadas_mes"] / df["pausas_recomendadas_mes"]
)

print("\nPrimeras 5 filas con la variable cumplimiento_pausas:")
print(
    df[
        [
            "pausas_recomendadas_mes",
            "pausas_realizadas_mes",
            "cumplimiento_pausas",
        ]
    ].head().to_string()
)

print("\nResumen estadístico de cumplimiento_pausas:")
print(df["cumplimiento_pausas"].describe())

# Exportar CSV del paso 2
df.to_csv("paso_2_cumplimiento_pausas.csv", index=False, sep=";")
print("\nArchivo CSV guardado correctamente como: paso_2_cumplimiento_pausas.csv")


# =========================================
# PASO 3
# SELECCIÓN DE VARIABLES PARA EL ÍNDICE
# =========================================

variables_riesgo = [
    "horas_extra_mes",
    "turnos_nocturnos_mes",
    "estres_autoreportado_1a10",
]

variables_protectoras = [
    "cumplimiento_pausas",
    "satisfaccion_autoreportada_1a10",
    "apoyo_jefatura_1a10",
]

print("\nVariables de riesgo seleccionadas:")
for var in variables_riesgo:
    print("-", var)

print("\nVariables protectoras seleccionadas:")
for var in variables_protectoras:
    print("-", var)

print("\nVariable excluida del índice principal por cautela interpretativa:")
print("- dias_ausentes_mes")

tabla_variables_indice = df[variables_riesgo + variables_protectoras]

print("\nPrimeras 5 filas de las variables seleccionadas para el índice:")
print(tabla_variables_indice.head().to_string())

resumen_variables = pd.DataFrame(
    {
        "variable": variables_riesgo + variables_protectoras,
        "tipo": ["riesgo"] * len(variables_riesgo)
        + ["protectora"] * len(variables_protectoras),
    }
)

print("\nResumen conceptual de variables del índice:")
print(resumen_variables.to_string(index=False))

# Exportar CSV del paso 3
df.to_csv("paso_3_variables_seleccionadas.csv", index=False, sep=";")
tabla_variables_indice.to_csv(
    "paso_3_tabla_variables_indice.csv", index=False, sep=";"
)
resumen_variables.to_csv(
    "paso_3_resumen_variables_indice.csv", index=False, sep=";"
)

print("\nArchivos CSV guardados correctamente:")
print("- paso_3_variables_seleccionadas.csv")
print("- paso_3_tabla_variables_indice.csv")
print("- paso_3_resumen_variables_indice.csv")


# =========================================
# PASO 4
# ESCALAR VARIABLES A UNA ESCALA COMÚN 0-10
# =========================================

def escalar_minmax_0_10(serie: pd.Series) -> pd.Series:
    minimo = serie.min()
    maximo = serie.max()

    if maximo == minimo:
        return pd.Series([0] * len(serie), index=serie.index)

    return (((serie - minimo) / (maximo - minimo)) * 10).round(2)


# Escalar variables de riesgo
for col in variables_riesgo:
    df[f"{col}_score"] = escalar_minmax_0_10(df[col])

# Escalar variables protectoras
for col in variables_protectoras:
    df[f"{col}_score"] = escalar_minmax_0_10(df[col])

print("\nPrimeras 5 filas de variables escaladas:")

tabla_paso_4 = df[
    [
        "horas_extra_mes_score",
        "turnos_nocturnos_mes_score",
        "estres_autoreportado_1a10_score",
        "cumplimiento_pausas_score",
        "satisfaccion_autoreportada_1a10_score",
        "apoyo_jefatura_1a10_score",
    ]
].head()

print(tabla_paso_4.to_string())

# Exportar CSV del paso 4
df.to_csv("paso_4_variables_escaladas.csv", index=False, sep=";")
tabla_paso_4.to_csv("paso_4_tabla_variables_escaladas.csv", index=False, sep=";")

print("\nArchivos CSV guardados correctamente:")
print("- paso_4_variables_escaladas.csv")
print("- paso_4_tabla_variables_escaladas.csv")


# =========================================
# PASO 5
# INVERTIR VARIABLES PROTECTORAS
# Objetivo: que en todas las variables
# un valor más alto signifique más riesgo
# =========================================

df["cumplimiento_pausas_riesgo"] = 10 - df["cumplimiento_pausas_score"]
df["satisfaccion_riesgo"] = 10 - df["satisfaccion_autoreportada_1a10_score"]
df["apoyo_jefatura_riesgo"] = 10 - df["apoyo_jefatura_1a10_score"]

print("\nPrimeras 5 filas de variables protectoras invertidas:")

tabla_paso_5 = df[
    [
        "cumplimiento_pausas_score",
        "cumplimiento_pausas_riesgo",
        "satisfaccion_autoreportada_1a10_score",
        "satisfaccion_riesgo",
        "apoyo_jefatura_1a10_score",
        "apoyo_jefatura_riesgo",
    ]
].head().round(2)

print(tabla_paso_5.to_string())

# Exportar CSV del paso 5
df.to_csv("paso_5_variables_invertidas.csv", index=False, sep=";")
tabla_paso_5.to_csv("paso_5_tabla_variables_invertidas.csv", index=False, sep=";")

print("\nArchivos CSV guardados correctamente:")
print("- paso_5_variables_invertidas.csv")
print("- paso_5_tabla_variables_invertidas.csv")


# =========================================
# PASO 6
# CONSTRUIR ÍNDICE FINAL DE BURNOUT
# =========================================

componentes_indice = [
    "horas_extra_mes_score",
    "turnos_nocturnos_mes_score",
    "estres_autoreportado_1a10_score",
    "cumplimiento_pausas_riesgo",
    "satisfaccion_riesgo",
    "apoyo_jefatura_riesgo",
]

df["indice_burnout"] = df[componentes_indice].mean(axis=1).round(2)

print("\nPrimeras 5 filas del índice final de burnout:")
print(df[componentes_indice + ["indice_burnout"]].head().to_string())

print("\nResumen estadístico del índice de burnout:")
print(df["indice_burnout"].describe().round(2))

# Exportar CSV del paso 6
df.to_csv("paso_6_indice_burnout_final.csv", index=False, sep=";")

tabla_paso_6 = df[componentes_indice + ["indice_burnout"]]
tabla_paso_6.to_csv("paso_6_tabla_indice_burnout.csv", index=False, sep=";")

print("\nArchivos CSV guardados correctamente:")
print("- paso_6_indice_burnout_final.csv")
print("- paso_6_tabla_indice_burnout.csv")


# =========================================
# PASO 7
# CLASIFICAR EL ÍNDICE EN CATEGORÍAS
# =========================================

def clasificar_burnout(valor: float) -> str:
    if valor <= 3.33:
        return "Bajo"
    elif valor <= 6.66:
        return "Medio"
    else:
        return "Alto"


df["categoria_burnout"] = df["indice_burnout"].apply(clasificar_burnout)

print("\nPrimeras 10 filas con índice y categoría:")
print(df[["indice_burnout", "categoria_burnout"]].head(10).to_string())

print("\nFrecuencia de categorías de burnout:")
print(df["categoria_burnout"].value_counts())

# Exportar CSV del paso 7
df.to_csv("paso_7_indice_burnout_categorizado.csv", index=False, sep=";")

tabla_paso_7 = df[["indice_burnout", "categoria_burnout"]]
tabla_paso_7.to_csv("paso_7_tabla_categoria_burnout.csv", index=False, sep=";")

print("\nArchivos CSV guardados correctamente:")
print("- paso_7_indice_burnout_categorizado.csv")
print("- paso_7_tabla_categoria_burnout.csv")


# =========================================
# EXPORTACIÓN FINAL PARA BIGQUERY / POWER BI
# =========================================

df.to_csv("base_final_burnout_analytics.csv", index=False, sep=";")
print("\nBase final exportada correctamente como: base_final_burnout_analytics.csv")
