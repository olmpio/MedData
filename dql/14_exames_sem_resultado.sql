SELECT
    ce.id           AS id_consulta_exame,
    ex.nome         AS exame,
    p.nome          AS paciente,
    ce.data_exame,
    ce.status
FROM consulta_exame ce
INNER JOIN exame    ex ON ex.id = ce.id_exame
INNER JOIN consulta c  ON c.id  = ce.id_consulta
INNER JOIN paciente p  ON p.id  = c.id_paciente
WHERE ce.data_exame IS NOT NULL
  AND ce.data_exame <= CURRENT_DATE
  AND (ce.resultado IS NULL OR TRIM(ce.resultado) = '')
ORDER BY ce.data_exame;
