-- Tabela particular de consultas
INSERT INTO tabela_preco (id_convenio, id_especialidade, valor)
SELECT
    NULL,
    e.id,
    CASE e.nome
        WHEN 'Cardiologia'  THEN 350.00
        WHEN 'Dermatologia' THEN 280.00
        WHEN 'Ortopedia'    THEN 300.00
        WHEN 'Pediatria'    THEN 250.00
        WHEN 'Ginecologia'  THEN 290.00
        ELSE 380.00
    END
FROM especialidade e;

-- Consultas por convenio
INSERT INTO tabela_preco (id_convenio, id_especialidade, valor)
SELECT
    cv.id,
    tp.id_especialidade,
    ROUND(tp.valor * CASE cv.nome
        WHEN 'Unimed'         THEN 0.60
        WHEN 'Bradesco Saude' THEN 0.65
        WHEN 'SulAmerica'     THEN 0.70
        WHEN 'Amil'           THEN 0.55
        ELSE 0.50
    END, 2)
FROM convenio cv
CROSS JOIN tabela_preco tp
WHERE tp.id_convenio IS NULL
  AND tp.id_especialidade IS NOT NULL;

-- Exames por convenio
INSERT INTO tabela_preco (id_convenio, id_exame, valor)
SELECT
    cv.id,
    ex.id,
    ROUND(ex.valor * CASE cv.nome
        WHEN 'Unimed'         THEN 0.60
        WHEN 'Bradesco Saude' THEN 0.65
        WHEN 'SulAmerica'     THEN 0.70
        WHEN 'Amil'           THEN 0.55
        ELSE 0.50
    END, 2)
FROM convenio cv
CROSS JOIN exame ex;
