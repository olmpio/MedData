CREATE OR REPLACE FUNCTION public.fn_atualizar_status_consulta_conclusao()
RETURNS trigger
LANGUAGE plpgsql
AS $function$
DECLARE
    v_valor_consulta numeric(10,2);
    v_id_convenio INT;
BEGIN
    IF NEW.diagnostico IS NOT NULL AND OLD.diagnostico IS NULL THEN
        NEW.status := 'Concluida';

        SELECT p.id_convenio INTO v_id_convenio
          FROM public.paciente p
         WHERE p.id = NEW.id_paciente;

        SELECT COALESCE(tp.valor, 200.00) INTO v_valor_consulta
          FROM public.tabela_preco tp
         WHERE tp.id_convenio = v_id_convenio
           AND tp.id_exame IS NULL
         LIMIT 1;

        IF NOT EXISTS (SELECT 1 FROM public.pagamento WHERE id_consulta = NEW.id) THEN
            INSERT INTO public.pagamento (id_consulta, valor, data_pagamento, forma_pagamento, status)
            VALUES (NEW.id, COALESCE(v_valor_consulta, 200.00), NULL, 'Pendente', 'Pendente');
        END IF;
    END IF;

    RETURN NEW;
END;
$function$;

DROP TRIGGER IF EXISTS tg_atualizar_status_consulta_conclusao ON public.consulta;
CREATE TRIGGER tg_atualizar_status_consulta_conclusao
BEFORE UPDATE ON public.consulta
FOR EACH ROW
EXECUTE FUNCTION public.fn_atualizar_status_consulta_conclusao();
