SELECT
    cv.nome          AS convenio,
    COUNT(pg.id)     AS qtd_pagamentos,
    SUM(pg.valor)    AS receita_total
FROM pagamento pg
INNER JOIN consulta c  ON c.id  = pg.id_consulta
INNER JOIN paciente p  ON p.id  = c.id_paciente
INNER JOIN convenio cv ON cv.id = p.id_convenio
WHERE pg.status = 'Pago'
GROUP BY cv.nome
ORDER BY receita_total DESC
LIMIT 3;
