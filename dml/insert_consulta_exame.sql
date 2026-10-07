INSERT INTO consulta_exame (id_consulta, id_exame, data_exame, resultado, status)
SELECT
    gs,
    ((gs - 1) % 8) + 1,
    CURRENT_DATE - ((gs % 20) || ' days')::interval,
    'Resultado do exame referente a consulta ' || gs,
    CASE WHEN gs % 2 = 0 THEN 'Concluido' ELSE 'Pendente' END
FROM generate_series(1, 35) AS gs;
