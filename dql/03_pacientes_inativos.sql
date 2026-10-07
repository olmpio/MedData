SELECT
    p.id,
    p.nome,
    p.telefone,
    p.email
FROM paciente p
LEFT JOIN consulta c
       ON c.id_paciente   = p.id
      AND c.data_consulta >= CURRENT_DATE - INTERVAL '6 months'
WHERE c.id IS NULL
ORDER BY p.nome;
