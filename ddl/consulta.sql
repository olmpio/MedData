CREATE TABLE consulta (
    id SERIAL PRIMARY KEY,
    data_consulta DATE NOT NULL,
    horario TIME NOT NULL,
    motivo VARCHAR(255),
    diagnostico VARCHAR(255),
    observacoes VARCHAR(500),
    status VARCHAR(30) NOT NULL DEFAULT 'Agendada',
    motivo_cancelamento VARCHAR(255),
    data_cancelamento TIMESTAMP,
    valor_taxa_retencao DECIMAL(10,2) DEFAULT 0,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    CONSTRAINT fk_consulta_paciente
        FOREIGN KEY (id_paciente)
        REFERENCES paciente(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_consulta_medico
        FOREIGN KEY (id_medico)
        REFERENCES medico(id)
        ON DELETE RESTRICT
);
