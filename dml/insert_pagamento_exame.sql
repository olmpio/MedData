-- Metade dos exames ja faturada. Os demais ficam para a procedure quitar.
INSERT INTO pagamento_exame (id_consulta_exame, valor, data_pagamento, forma_pagamento, status)
SELECT
    ce.id,
    COALESCE(tp.valor, ex.valor),
    ce.data_exame,
    CASE (ce.id % 4)
        WHEN 0 THEN 'Dinheiro'
        WHEN 1 THEN 'Cartao de Credito'
        WHEN 2 THEN 'Cartao de Debito'
        ELSE 'Pix'
    END,
    CASE WHEN ce.id % 10 = 0 THEN 'Pendente' ELSE 'Pago' END
FROM consulta_exame ce
INNER JOIN exame    ex ON ex.id = ce.id_exame
INNER JOIN consulta c  ON c.id  = ce.id_consulta
INNER JOIN paciente p  ON p.id  = c.id_paciente
LEFT  JOIN convenio cv ON cv.id = p.id_convenio AND cv.ativo
LEFT  JOIN tabela_preco tp
       ON tp.id_convenio = cv.id
      AND tp.id_exame    = ce.id_exame
WHERE ce.id % 2 = 0
  AND ce.data_exame IS NOT NULL
  AND ce.data_exame <= CURRENT_DATE;
