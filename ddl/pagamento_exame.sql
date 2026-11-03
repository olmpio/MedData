CREATE TABLE pagamento_exame (
    id SERIAL PRIMARY KEY,
    id_consulta_exame INT NOT NULL UNIQUE,
    valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),
    data_pagamento DATE NOT NULL,
    forma_pagamento VARCHAR(30) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'Pendente',
    CONSTRAINT fk_pagamento_exame_consulta_exame
        FOREIGN KEY (id_consulta_exame)
        REFERENCES consulta_exame(id)
        ON DELETE CASCADE
);
