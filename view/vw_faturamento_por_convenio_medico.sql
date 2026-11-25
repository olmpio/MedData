CREATE OR REPLACE VIEW public.vw_faturamento_por_convenio_medico AS
SELECT 
    EXTRACT(YEAR FROM pg.data_pagamento)::INT AS ano,
    EXTRACT(MONTH FROM pg.data_pagamento)::INT AS mes,
    COALESCE(cv.nome, 'Particular') AS convenio,
    m.nome AS medico,
    COUNT(pg.id) AS qtd_atendimentos_pagos,
    SUM(pg.valor) AS faturamento_total
FROM public.pagamento pg
INNER JOIN public.consulta c ON c.id = pg.id_consulta
INNER JOIN public.medico m ON m.id = c.id_medico
INNER JOIN public.paciente p ON p.id = c.id_paciente
LEFT JOIN public.convenio cv ON cv.id = p.id_convenio
WHERE pg.status = 'Pago'
GROUP BY 
    EXTRACT(YEAR FROM pg.data_pagamento),
    EXTRACT(MONTH FROM pg.data_pagamento),
    COALESCE(cv.nome, 'Particular'),
    m.nome
ORDER BY ano DESC, mes DESC, faturamento_total DESC;
