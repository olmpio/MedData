SELECT
    m.id,
    m.nome            AS medico,
    m.crm,
    COUNT(c.id)       AS qtd_canceladas
FROM medico m
LEFT JOIN consulta c
       ON c.id_medico = m.id
      AND c.status    = 'Cancelada'
GROUP BY m.id, m.nome, m.crm
ORDER BY qtd_canceladas DESC, medico;
