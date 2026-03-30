-- Promedio de factores protectores estandarizados
SELECT
  ROUND(AVG(cumplimiento_pausas_score), 2) AS promedio_cumplimiento_pausas,
  ROUND(AVG(satisfaccion_autoreportada_1a10_score), 2) AS promedio_satisfaccion,
  ROUND(AVG(apoyo_jefatura_1a10_score), 2) AS promedio_apoyo_jefatura
FROM `burnoutindex-490619.burnout_analytics.burnout_analytics`;