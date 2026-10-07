SELECT
    ex.nome            AS exame,
    COUNT(ce.id)       AS qtd_solicitacoes
FROM consulta_exame ce
INNER JOIN exame    ex ON ex.id = ce.id_exame
INNER JOIN consulta c  ON c.id  = ce.id_consulta
WHERE c.data_consulta BETWEEN CURRENT_DATE - INTERVAL '30 days' AND CURRENT_DATE
GROUP BY ex.nome
ORDER BY qtd_solicitacoes DESC, exame;
