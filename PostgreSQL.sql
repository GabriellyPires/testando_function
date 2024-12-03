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
('Produto A', 12.99),
('Produto B', 20.99),
('Produto C', 15.99);

INSERT INTO vendas (id_produto, data_venda, quantidade) VALUES
(1, '2024-12-03 10:50:00', 6),
(2, '2024-12-03 13:00:00', 4),
(1, '2024-12-04 08:15:00', 4),
(3, '2024-12-04 15:20:00', 3),
(2, '2024-12-04 17:35:00', 2);


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