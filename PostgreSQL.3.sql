CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    data_cadastro TIMESTAMP NOT NULL
);

INSERT INTO clientes (nome, email, data_cadastro) VALUES
('João Silva', 'joao.silva@email.com', '2024-12-01 09:30:00'),
('Maria Oliveira', 'maria.oliveira@email.com', '2024-12-01 10:45:00'),
('Carlos Santos', 'carlos.santos@email.com', '2024-12-02 11:15:00'),
('Ana Costa', 'ana.costa@email.com', '2024-12-02 14:20:00'),
('Paulo Souza', 'paulo.souza@email.com', '2024-12-03 16:50:00');

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

SELECT soma_clientes_cadastrados('2024-12-01');