SELECT
    p.id,
    p.nome,
    p.cpf,
    p.telefone,
    cv.nome AS convenio
FROM paciente p
INNER JOIN convenio cv ON cv.id = p.id_convenio
WHERE cv.nome = 'Plano Ouro'
ORDER BY p.nome;
