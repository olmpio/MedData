INSERT INTO consulta (data_consulta, horario, motivo, diagnostico, observacoes, status, id_paciente, id_medico)
SELECT
    CURRENT_DATE - (gs || ' days')::interval,
    (TIME '08:00' + ((gs % 8) || ' hours')::interval),
    'Consulta de rotina ' || gs,
    CASE WHEN gs % 4 = 0 THEN NULL ELSE 'Diagnostico ' || gs END,
    'Observacoes da consulta ' || gs,
    CASE (gs % 3)
        WHEN 0 THEN 'Realizada'
        WHEN 1 THEN 'Agendada'
        ELSE 'Cancelada'
    END,
    ((gs - 1) % 30) + 1,
    ((gs - 1) % 30) + 1
FROM generate_series(1, 40) AS gs;
