SELECT
    m.nome                                               AS medico,
    COUNT(DISTINCT m.id_especialidade)                   AS qtd_especialidades,
    STRING_AGG(DISTINCT e.nome, ', ' ORDER BY e.nome)    AS especialidades
FROM medico m
INNER JOIN especialidade e ON e.id = m.id_especialidade
GROUP BY m.nome
HAVING COUNT(DISTINCT m.id_especialidade) > 1
ORDER BY qtd_especialidades DESC, medico;
