SELECT
    COALESCE(cv.nome, 'Particular')  AS convenio,
    COUNT(pg.id)                     AS qtd_consultas_pendentes,
    SUM(pg.valor)                    AS valor_glosa_estimada
FROM pagamento pg
INNER JOIN consulta c  ON c.id  = pg.id_consulta
INNER JOIN paciente p  ON p.id  = c.id_paciente
LEFT  JOIN convenio cv ON cv.id = p.id_convenio
WHERE c.status  = 'Realizada'
  AND pg.status = 'Pendente'
GROUP BY COALESCE(cv.nome, 'Particular')
ORDER BY valor_glosa_estimada DESC;
