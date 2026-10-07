SELECT DISTINCT
    p.id,
    p.nome            AS paciente,
    c.data_consulta,
    c.diagnostico
FROM paciente p
INNER JOIN consulta c ON c.id_paciente = p.id
WHERE c.diagnostico ILIKE ANY (ARRAY[
    '%crônic%', '%cronic%',
    '%diabetes%', '%hipertens%', '%asma%', '%dpoc%',
    '%insuficiência renal%', '%insuficiencia renal%',
    '%artrite%', '%epilepsia%', '%hipotireoid%'
])
ORDER BY paciente, c.data_consulta;
