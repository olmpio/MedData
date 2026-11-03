-- Valores praticados pela clinica.
--   id_convenio NULL     -> tabela particular
--   id_especialidade     -> valor da consulta naquela especialidade
--   id_exame             -> valor do exame no convenio
-- O valor particular do exame continua em exame.valor.
CREATE TABLE tabela_preco (
    id SERIAL PRIMARY KEY,
    id_convenio INT,
    id_especialidade INT,
    id_exame INT,
    valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),
    CONSTRAINT fk_tabela_preco_convenio
        FOREIGN KEY (id_convenio)
        REFERENCES convenio(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_tabela_preco_especialidade
        FOREIGN KEY (id_especialidade)
        REFERENCES especialidade(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_tabela_preco_exame
        FOREIGN KEY (id_exame)
        REFERENCES exame(id)
        ON DELETE CASCADE,
    CONSTRAINT ck_tabela_preco_item
        CHECK (num_nonnulls(id_especialidade, id_exame) = 1),
    CONSTRAINT ck_tabela_preco_exame_convenio
        CHECK (id_exame IS NULL OR id_convenio IS NOT NULL)
);

CREATE UNIQUE INDEX uq_tabela_preco_item ON tabela_preco (
    COALESCE(id_convenio, 0),
    COALESCE(id_especialidade, 0),
    COALESCE(id_exame, 0)
);
