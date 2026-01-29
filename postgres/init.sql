CREATE TABLE IF NOT EXISTS pedidos (
    id SERIAL PRIMARY KEY,
    produto VARCHAR(100),
    quantidade INTEGER,
    status VARCHAR(20)
);