SELECT
    COUNT(ce.id)                                            AS qtd_exames_considerados,
    ROUND(AVG(ce.data_exame - c.data_consulta), 1)          AS tempo_medio_dias
FROM consulta_exame ce
INNER JOIN consulta c ON c.id = ce.id_consulta
WHERE ce.data_exame IS NOT NULL
  AND ce.data_exame <= CURRENT_DATE;
