-- Quita uma consulta ou um exame, usando o valor da tabela do convenio do paciente
-- ou a tabela particular, e registra a forma de pagamento no financeiro.
-- Paciente sem convenio, ou com convenio inativo, paga pela tabela particular.
--
-- Uso:
--   CALL sp_processar_faturamento_consulta(3, 'Pix');        -- consulta 3
--   CALL sp_processar_faturamento_consulta(3, 'Pix', 3);     -- exame 3 da consulta 3
CREATE OR REPLACE PROCEDURE sp_processar_faturamento_consulta(
    p_id_consulta     INT,
    p_forma_pagamento VARCHAR,
    p_id_exame        INT  DEFAULT NULL,
    p_data_pagamento  DATE DEFAULT CURRENT_DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_status_consulta   consulta.status%TYPE;
    v_id_especialidade  medico.id_especialidade%TYPE;
    v_id_convenio       convenio.id%TYPE;
    v_id_consulta_exame consulta_exame.id%TYPE;
    v_data_exame        consulta_exame.data_exame%TYPE;
    v_status_pagamento  pagamento.status%TYPE;
    v_valor             pagamento.valor%TYPE;
BEGIN
    IF p_forma_pagamento IS NULL OR p_forma_pagamento NOT IN
        ('Dinheiro', 'Cartao de Credito', 'Cartao de Debito', 'Pix', 'Convenio') THEN
        RAISE EXCEPTION 'Forma de pagamento invalida: %', p_forma_pagamento;
    END IF;

    SELECT c.status, m.id_especialidade, cv.id
      INTO v_status_consulta, v_id_especialidade, v_id_convenio
    FROM consulta c
    INNER JOIN medico   m  ON m.id  = c.id_medico
    INNER JOIN paciente p  ON p.id  = c.id_paciente
    LEFT  JOIN convenio cv ON cv.id = p.id_convenio AND cv.ativo
    WHERE c.id = p_id_consulta
    FOR UPDATE OF c;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Consulta % nao encontrada', p_id_consulta;
    END IF;

    IF p_forma_pagamento = 'Convenio' AND v_id_convenio IS NULL THEN
        RAISE EXCEPTION 'Consulta % nao tem convenio ativo para esta forma de pagamento', p_id_consulta;
    END IF;

    IF p_id_exame IS NOT NULL THEN
        SELECT ce.id, ce.data_exame INTO v_id_consulta_exame, v_data_exame
        FROM consulta_exame ce
        WHERE ce.id_consulta = p_id_consulta
          AND ce.id_exame    = p_id_exame
        FOR UPDATE;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Exame % nao pertence a consulta %', p_id_exame, p_id_consulta;
        END IF;

        IF v_data_exame IS NULL OR v_data_exame > CURRENT_DATE THEN
            RAISE EXCEPTION 'Exame % da consulta % ainda nao foi realizado', p_id_exame, p_id_consulta;
        END IF;

        IF v_id_convenio IS NULL THEN
            SELECT ex.valor INTO v_valor
            FROM exame ex
            WHERE ex.id = p_id_exame;
        ELSE
            SELECT tp.valor INTO v_valor
            FROM tabela_preco tp
            WHERE tp.id_convenio = v_id_convenio
              AND tp.id_exame    = p_id_exame;
        END IF;

        IF v_valor IS NULL THEN
            RAISE EXCEPTION 'Sem valor do exame % na tabela do convenio %', p_id_exame, v_id_convenio;
        END IF;

        SELECT status INTO v_status_pagamento
        FROM pagamento_exame
        WHERE id_consulta_exame = v_id_consulta_exame;

        IF v_status_pagamento = 'Pago' THEN
            RAISE EXCEPTION 'Exame % da consulta % ja esta quitado', p_id_exame, p_id_consulta;
        END IF;

        INSERT INTO pagamento_exame (id_consulta_exame, valor, data_pagamento, forma_pagamento, status)
        VALUES (v_id_consulta_exame, v_valor, p_data_pagamento, p_forma_pagamento, 'Pago')
        ON CONFLICT (id_consulta_exame) DO UPDATE
        SET valor           = EXCLUDED.valor,
            data_pagamento  = EXCLUDED.data_pagamento,
            forma_pagamento = EXCLUDED.forma_pagamento,
            status          = EXCLUDED.status;

        RAISE NOTICE 'Exame % da consulta % quitado: R$ %', p_id_exame, p_id_consulta, v_valor;
        RETURN;
    END IF;

    IF v_status_consulta <> 'Realizada' THEN
        RAISE EXCEPTION 'Consulta % esta com status % e nao pode ser faturada', p_id_consulta, v_status_consulta;
    END IF;

    SELECT tp.valor INTO v_valor
    FROM tabela_preco tp
    WHERE tp.id_especialidade = v_id_especialidade
      AND tp.id_convenio IS NOT DISTINCT FROM v_id_convenio;

    IF v_valor IS NULL THEN
        RAISE EXCEPTION 'Sem valor de consulta na tabela para a consulta %', p_id_consulta;
    END IF;

    SELECT status INTO v_status_pagamento
    FROM pagamento
    WHERE id_consulta = p_id_consulta;

    IF v_status_pagamento = 'Pago' THEN
        RAISE EXCEPTION 'Consulta % ja esta quitada', p_id_consulta;
    END IF;

    INSERT INTO pagamento (id_consulta, valor, data_pagamento, forma_pagamento, status)
    VALUES (p_id_consulta, v_valor, p_data_pagamento, p_forma_pagamento, 'Pago')
    ON CONFLICT (id_consulta) DO UPDATE
    SET valor           = EXCLUDED.valor,
        data_pagamento  = EXCLUDED.data_pagamento,
        forma_pagamento = EXCLUDED.forma_pagamento,
        status          = EXCLUDED.status;

    RAISE NOTICE 'Consulta % quitada: R$ %', p_id_consulta, v_valor;
END;
$$;
