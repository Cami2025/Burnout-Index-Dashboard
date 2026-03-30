-- Promedio de factores de riesgo estandarizados
SELECT
  ROUND(AVG(estres_autoreportado_1a10_score), 2) AS promedio_estres_score,
  ROUND(AVG(horas_extra_mes_score), 2) AS promedio_horas_extra_score,
  ROUND(AVG(turnos_nocturnos_mes_score), 2) AS promedio_turnos_nocturnos_score
FROM `burnoutindex-490619.burnout_analytics.burnout_analytics`;