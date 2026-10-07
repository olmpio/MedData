SELECT
    p.nome                                   AS paciente,
    m.nome                                   AS medico,
    c.data_consulta,
    c.status                                 AS status_consulta,
    pg.valor,
    COALESCE(pg.status, 'Sem pagamento')     AS status_pagamento
FROM consulta c
INNER JOIN paciente  p  ON p.id          = c.id_paciente
INNER JOIN medico    m  ON m.id          = c.id_medico
LEFT  JOIN pagamento pg ON pg.id_consulta = c.id
ORDER BY c.data_consulta DESC, paciente;
