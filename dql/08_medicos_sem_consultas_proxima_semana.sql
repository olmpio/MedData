SELECT
    m.id,
    m.nome      AS medico,
    m.crm,
    e.nome      AS especialidade
FROM medico m
INNER JOIN especialidade e ON e.id = m.id_especialidade
LEFT  JOIN consulta c
        ON c.id_medico      = m.id
       AND c.status         = 'Agendada'
       AND c.data_consulta BETWEEN DATE_TRUNC('week', CURRENT_DATE)::date + 7
                               AND DATE_TRUNC('week', CURRENT_DATE)::date + 13
WHERE m.ativo = TRUE
  AND c.id IS NULL
ORDER BY medico;
