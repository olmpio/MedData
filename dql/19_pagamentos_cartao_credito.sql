SELECT
    pg.forma_pagamento,
    COUNT(pg.id)        AS qtd_pagamentos,
    SUM(pg.valor)       AS valor_total
FROM pagamento pg
WHERE pg.forma_pagamento = 'Cartao de Credito'
  AND pg.status          = 'Pago'
GROUP BY pg.forma_pagamento;
