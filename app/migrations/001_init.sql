-- Run after RDS is available (Query Editor, psql via bastion, or one-off ECS task)
CREATE TABLE IF NOT EXISTS products (
  id SERIAL PRIMARY KEY,
  sku VARCHAR(64) NOT NULL UNIQUE,
  title VARCHAR(255) NOT NULL,
  price_cents INTEGER NOT NULL CHECK (price_cents >= 0),
  stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0)
);

INSERT INTO products (sku, title, price_cents, stock) VALUES
  ('RM-SKU-001', 'Organic Trail Mix 2kg', 1299, 400),
  ('RM-SKU-002', 'Cold Brew Concentrate 6-pack', 1899, 220)
ON CONFLICT (sku) DO NOTHING;
