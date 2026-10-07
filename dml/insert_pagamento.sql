INSERT INTO pagamento (id_consulta, valor, data_pagamento, forma_pagamento, status)
SELECT
    gs + 5,
    (80 + (gs % 10) * 15)::numeric(10,2),
    CURRENT_DATE - (gs || ' days')::interval,
    CASE (gs % 4)
        WHEN 0 THEN 'Dinheiro'
        WHEN 1 THEN 'Cartao de Credito'
        WHEN 2 THEN 'Cartao de Debito'
        ELSE 'Pix'
    END,
    CASE WHEN gs % 5 = 0 THEN 'Pendente' ELSE 'Pago' END
FROM generate_series(1, 30) AS gs;
