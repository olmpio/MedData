SELECT
    faixa_etaria,
    COUNT(*) AS qtd_pacientes
FROM (
    SELECT
        CASE
            WHEN idade <= 12 THEN '1. Criança (0-12)'
            WHEN idade <= 17 THEN '2. Adolescente (13-17)'
            WHEN idade <= 29 THEN '3. Jovem adulto (18-29)'
            WHEN idade <= 59 THEN '4. Adulto (30-59)'
            ELSE                  '5. Idoso (60+)'
        END AS faixa_etaria
    FROM (
        SELECT EXTRACT(YEAR FROM AGE(CURRENT_DATE, data_nascimento))::int AS idade
        FROM paciente
    ) AS idades
) AS faixas
GROUP BY faixa_etaria
ORDER BY faixa_etaria;
