SELECT
  categoria_burnout,
  COUNT(DISTINCT employee_id) AS total_personas,
  ROUND(
    COUNT(DISTINCT employee_id) * 100.0
    / SUM(COUNT(DISTINCT employee_id)) OVER (),
    2
  ) AS porcentaje
FROM `burnoutindex-490619.burnout_analytics.burnout_analytics`
GROUP BY categoria_burnout
ORDER BY
  CASE
    WHEN categoria_burnout = 'Bajo' THEN 1
    WHEN categoria_burnout = 'Medio' THEN 2
    WHEN categoria_burnout = 'Alto' THEN 3
    ELSE 99
  END;
