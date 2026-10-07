SELECT
    m.id,
    m.nome          AS medico,
    COUNT(c.id)     AS qtd_atendimentos
FROM medico m
LEFT JOIN consulta c
       ON c.id_medico     = m.id
      AND c.status        = 'Realizada'
      AND c.data_consulta >= DATE_TRUNC('month', CURRENT_DATE)
      AND c.data_consulta <  DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month'
GROUP BY m.id, m.nome
ORDER BY qtd_atendimentos DESC, medico;
