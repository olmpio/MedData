CREATE TABLE consulta_exame (
    id SERIAL PRIMARY KEY,
    id_consulta INT NOT NULL,
    id_exame INT NOT NULL,
    data_exame DATE,
    resultado VARCHAR(500),
    status VARCHAR(30) NOT NULL DEFAULT 'Pendente',
    CONSTRAINT fk_consulta_exame_consulta
        FOREIGN KEY (id_consulta)
        REFERENCES consulta(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_consulta_exame_exame
        FOREIGN KEY (id_exame)
        REFERENCES exame(id)
        ON DELETE RESTRICT,
    CONSTRAINT uq_consulta_exame UNIQUE (id_consulta, id_exame)
);
