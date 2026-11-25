CREATE OR REPLACE FUNCTION public.fn_impedir_agendamento_horario_ocupado()
RETURNS trigger
LANGUAGE plpgsql
AS $function$
BEGIN
    IF NEW.status <> 'Cancelada' THEN
        IF NEW.horario >= TIME '12:00:00' AND NEW.horario < TIME '14:00:00' THEN
            RAISE EXCEPTION 'Horário indisponível: o médico encontra-se em horário de descanso (12:00 às 14:00).';
        END IF;

        IF EXISTS (
            SELECT 1
              FROM public.consulta c
             WHERE c.id_medico = NEW.id_medico
               AND c.data_consulta = NEW.data_consulta
               AND c.horario = NEW.horario
               AND c.status <> 'Cancelada'
               AND c.id IS DISTINCT FROM NEW.id
        ) THEN
            RAISE EXCEPTION 'Conflito de agenda: o médico ID % já possui atendimento marcado nesta data e horário.', NEW.id_medico;
        END IF;
    END IF;

    RETURN NEW;
END;
$function$;

DROP TRIGGER IF EXISTS tg_impedir_agendamento_horario_ocupado ON public.consulta;
CREATE TRIGGER tg_impedir_agendamento_horario_ocupado
BEFORE INSERT OR UPDATE ON public.consulta
FOR EACH ROW
EXECUTE FUNCTION public.fn_impedir_agendamento_horario_ocupado();
