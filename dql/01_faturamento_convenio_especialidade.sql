SELECT
    COALESCE(cv.nome, 'Particular')  AS convenio,
    e.nome                           AS especialidade,
    COUNT(pg.id)                     AS qtd_pagamentos,
    SUM(pg.valor)                    AS faturamento_bruto
FROM pagamento pg
INNER JOIN consulta      c  ON c.id  = pg.id_consulta
INNER JOIN paciente      p  ON p.id  = c.id_paciente
INNER JOIN medico        m  ON m.id  = c.id_medico
INNER JOIN especialidade e  ON e.id  = m.id_especialidade
LEFT  JOIN convenio      cv ON cv.id = p.id_convenio
GROUP BY COALESCE(cv.nome, 'Particular'), e.nome
ORDER BY convenio, faturamento_bruto DESC;
