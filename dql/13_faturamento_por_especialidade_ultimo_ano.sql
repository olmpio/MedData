SELECT
    e.nome                       AS especialidade,
    COUNT(f.id_pagamento)        AS qtd_pagamentos,
    COALESCE(SUM(f.valor), 0)    AS total_faturado
FROM (
    SELECT pg.id AS id_pagamento, pg.valor, m.id_especialidade
    FROM pagamento pg
    INNER JOIN consulta c ON c.id = pg.id_consulta
    INNER JOIN medico   m ON m.id = c.id_medico
    WHERE c.data_consulta >= CURRENT_DATE - INTERVAL '1 year'
) AS f
RIGHT JOIN especialidade e ON e.id = f.id_especialidade
GROUP BY e.nome
ORDER BY total_faturado DESC, especialidade;
