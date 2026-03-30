SELECT
  categoria_burnout,
  COUNT(DISTINCT employee_id) AS total_personas
FROM `burnoutindex-490619.burnout_analytics.burnout_analytics`
GROUP BY categoria_burnout
ORDER BY
  CASE
    WHEN categoria_burnout = 'Bajo' THEN 1
    WHEN categoria_burnout = 'Medio' THEN 2
    WHEN categoria_burnout = 'Alto' THEN 3
    ELSE 99
  END;