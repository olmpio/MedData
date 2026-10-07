SELECT
    p.id,
    p.nome                       AS paciente,
    COUNT(ce.id)                 AS qtd_exames,
    ROUND(AVG(ex.valor), 2)      AS valor_medio
FROM paciente p
INNER JOIN consulta       c  ON c.id_paciente  = p.id
INNER JOIN consulta_exame ce ON ce.id_consulta = c.id
INNER JOIN exame          ex ON ex.id          = ce.id_exame
WHERE ce.data_exame IS NOT NULL
  AND ce.data_exame <= CURRENT_DATE
GROUP BY p.id, p.nome
ORDER BY valor_medio DESC, paciente;
