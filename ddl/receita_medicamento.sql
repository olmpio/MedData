CREATE TABLE receita_medicamento (
    id SERIAL PRIMARY KEY,
    id_receita INT NOT NULL,
    id_medicamento INT NOT NULL,
    dosagem VARCHAR(50),
    frequencia VARCHAR(50),
    duracao VARCHAR(50),
    CONSTRAINT fk_receita_medicamento_receita
        FOREIGN KEY (id_receita)
        REFERENCES receita(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_receita_medicamento_medicamento
        FOREIGN KEY (id_medicamento)
        REFERENCES medicamento(id)
        ON DELETE RESTRICT,
    CONSTRAINT uq_receita_medicamento UNIQUE (id_receita, id_medicamento)
);
