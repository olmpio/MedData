SELECT
    e.nome            AS especialidade,
    md.nome           AS medicamento,
    COUNT(rm.id)      AS qtd_prescricoes
FROM receita_medicamento rm
INNER JOIN medicamento   md ON md.id = rm.id_medicamento
INNER JOIN receita       r  ON r.id  = rm.id_receita
INNER JOIN consulta      c  ON c.id  = r.id_consulta
INNER JOIN medico        m  ON m.id  = c.id_medico
INNER JOIN especialidade e  ON e.id  = m.id_especialidade
GROUP BY e.nome, md.nome
ORDER BY especialidade, qtd_prescricoes DESC, medicamento;
