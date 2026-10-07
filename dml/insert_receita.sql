INSERT INTO receita (id_consulta, data_receita, instrucoes)
SELECT
    gs,
    CURRENT_DATE - (gs || ' days')::interval,
    'Tomar conforme prescricao medica - receita ' || gs
FROM generate_series(1, 30) AS gs;
