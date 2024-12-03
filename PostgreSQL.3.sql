CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    data_cadastro TIMESTAMP NOT NULL
);

INSERT INTO clientes (nome, email, data_cadastro) VALUES
('Adilson silva', 'adilson.silva@email.com', '2024-12-02 08:30:00'),
('Eder Oliveira', 'eder.oliveira@email.com', '2024-12-02 11:45:00'),
('Carlos Almeida', 'carlos.almeida@email.com', '2024-12-03 13:15:00'),
('Francy Meins', 'bruna.meins@email.com', '2024-12-03 15:20:00'),
('Paulo Sergio', 'paulo.sergio@email.com', '2024-12-04 18:50:00');

CREATE OR REPLACE FUNCTION soma_clientes_cadastrados(data_dia DATE)
RETURNS INT AS $$
DECLARE
    total_clientes INT;
BEGIN
    SELECT COUNT(*) INTO total_clientes
    FROM clientes
    WHERE DATE(data_cadastro) = data_dia;

    RETURN total_clientes;
END;
$$ LANGUAGE plpgsql;

SELECT soma_clientes_cadastrados('2024-12-02');