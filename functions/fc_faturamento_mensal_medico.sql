-- Retorna o valor bruto faturado por um medico no mes/ano informado,
-- somando consultas e exames prestados.
-- Bruto: considera pagamentos Pagos e Pendentes.
-- Consulta: conta no mes de data_consulta, somente com status Realizada.
-- Exame: conta no mes de data_exame, para o medico da consulta que o solicitou.
--
-- Uso:
--   SELECT fc_faturamento_mensal_medico(3, 10, 2026);
CREATE OR REPLACE FUNCTION fc_faturamento_mensal_medico(
    p_id_medico INT,
    p_mes       INT,
    p_ano       INT
)
RETURNS DECIMAL
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
    v_inicio          DATE;
    v_fim             DATE;
    v_total_consultas DECIMAL;
    v_total_exames    DECIMAL;
BEGIN
    IF p_mes IS NULL OR p_mes NOT BETWEEN 1 AND 12 THEN
        RAISE EXCEPTION 'Mes invalido: %', p_mes;
    END IF;

    IF p_ano IS NULL THEN
        RAISE EXCEPTION 'Ano nao informado';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM medico WHERE id = p_id_medico) THEN
        RAISE EXCEPTION 'Medico % nao encontrado', p_id_medico;
    END IF;

    v_inicio := make_date(p_ano, p_mes, 1);
    v_fim    := (v_inicio + INTERVAL '1 month')::DATE;

    SELECT COALESCE(SUM(pg.valor), 0) INTO v_total_consultas
    FROM pagamento pg
    INNER JOIN consulta c ON c.id = pg.id_consulta
    WHERE c.id_medico = p_id_medico
      AND c.status = 'Realizada'
      AND c.data_consulta >= v_inicio
      AND c.data_consulta <  v_fim;

    SELECT COALESCE(SUM(pe.valor), 0) INTO v_total_exames
    FROM pagamento_exame pe
    INNER JOIN consulta_exame ce ON ce.id = pe.id_consulta_exame
    INNER JOIN consulta       c  ON c.id  = ce.id_consulta
    WHERE c.id_medico = p_id_medico
      AND ce.data_exame >= v_inicio
      AND ce.data_exame <  v_fim;

    RETURN v_total_consultas + v_total_exames;
END;
$$;
