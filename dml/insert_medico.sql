INSERT INTO medico (nome, crm, telefone, email, ativo, id_especialidade)
SELECT
    'Dr(a). Medico ' || gs,
    'CRM/BA ' || LPAD(gs::text, 5, '0'),
    '(75) 9' || LPAD((10000000 + gs)::text, 8, '0'),
    'medico' || gs || '@meddata.com',
    TRUE,
    ((gs - 1) % 6) + 1
FROM generate_series(1, 30) AS gs;
