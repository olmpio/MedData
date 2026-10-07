SELECT
    r.id            AS id_receita,
    r.data_receita,
    r.id_consulta,
    r.instrucoes
FROM receita_medicamento rm
RIGHT JOIN receita r ON r.id = rm.id_receita
WHERE rm.id IS NULL
ORDER BY r.data_receita DESC;
