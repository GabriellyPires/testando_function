CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL
);

CREATE TABLE vendas (
    id SERIAL PRIMARY KEY,
    id_produto INT NOT NULL,
    data_venda TIMESTAMP NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produtos(id)
);

INSERT INTO produtos (nome, preco) VALUES
('Produto A', 10.50),
('Produto B', 20.00),
('Produto C', 15.75);

INSERT INTO vendas (id_produto, data_venda, quantidade) VALUES
(1, '2024-12-01 10:30:00', 5),
(2, '2024-12-01 11:00:00', 2),
(1, '2024-12-02 09:15:00', 3),
(3, '2024-12-02 14:20:00', 4),
(2, '2024-12-02 16:45:00', 1);


CREATE OR REPLACE FUNCTION levantamento_diario()
RETURNS TABLE(data DATE, quantidade_total INTEGER) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        DATE(v.data_venda) AS data, 
        SUM(v.quantidade)::INTEGER AS quantidade_total
    FROM vendas v
    GROUP BY DATE(v.data_venda)
    ORDER BY DATE(v.data_venda);
END;
$$ LANGUAGE plpgsql;

SELECT * FROM levantamento_diario();