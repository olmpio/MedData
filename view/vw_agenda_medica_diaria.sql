CREATE OR REPLACE VIEW public.vw_agenda_medica_diaria AS
SELECT 
    c.id AS id_consulta,
    c.data_consulta,
    c.horario,
    m.nome AS medico,
    e.nome AS especialidade,
    p.nome AS paciente,
    COALESCE(cv.nome, 'Particular') AS convenio,
    c.status
FROM public.consulta c
INNER JOIN public.medico m ON m.id = c.id_medico
INNER JOIN public.especialidade e ON e.id = m.id_especialidade
INNER JOIN public.paciente p ON p.id = c.id_paciente
LEFT JOIN public.convenio cv ON cv.id = p.id_convenio
WHERE c.data_consulta = CURRENT_DATE
ORDER BY m.nome ASC, c.horario ASC;
