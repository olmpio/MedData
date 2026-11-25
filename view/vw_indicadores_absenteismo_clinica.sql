CREATE OR REPLACE VIEW public.vw_indicadores_absenteismo_clinica AS
SELECT 
    e.nome AS especialidade,
    m.nome AS medico,
    COUNT(c.id) AS total_consultas,
    COUNT(CASE WHEN c.status IN ('Cancelada', 'Faltou') THEN 1 END) AS total_ausencias,
    ROUND(
        (COUNT(CASE WHEN c.status IN ('Cancelada', 'Faltou') THEN 1 END)::numeric / NULLIF(COUNT(c.id), 0)::numeric) * 100,
        2
    ) AS taxa_absenteismo_percentual
FROM public.medico m
INNER JOIN public.especialidade e ON e.id = m.id_especialidade
LEFT JOIN public.consulta c ON c.id_medico = m.id
GROUP BY e.nome, m.nome
ORDER BY taxa_absenteismo_percentual DESC NULLS LAST;
