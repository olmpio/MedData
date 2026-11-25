CREATE OR REPLACE FUNCTION public.fn_impedir_cancelamento_consulta_retroativa()
RETURNS trigger
LANGUAGE plpgsql
AS $function$
BEGIN
    IF OLD.data_consulta < CURRENT_DATE AND (NEW.status IS DISTINCT FROM OLD.status) THEN
        RAISE EXCEPTION 'Operação bloqueada: não é permitido alterar o status ou cancelar consultas retroativas (data: %).', OLD.data_consulta;
    END IF;

    RETURN NEW;
END;
$function$;

DROP TRIGGER IF EXISTS tg_impedir_cancelamento_consulta_retroativa ON public.consulta;
CREATE TRIGGER tg_impedir_cancelamento_consulta_retroativa
BEFORE UPDATE ON public.consulta
FOR EACH ROW
EXECUTE FUNCTION public.fn_impedir_cancelamento_consulta_retroativa();
