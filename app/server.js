import express from 'express';
import pg from 'pg';

const { Pool } = pg;
const app = express();
const port = Number(process.env.PORT || 3000);

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  max: 10,
  idleTimeoutMillis: 30_000,
});

app.disable('x-powered-by');
app.use(express.json());

app.get('/health', (_req, res) => {
  res.json({
    status: 'ok',
    service: 'rivermarket-api',
    region: process.env.AWS_REGION || process.env.AWS_DEFAULT_REGION || 'unknown',
    timestamp: new Date().toISOString(),
  });
});

app.get('/api/products', async (_req, res) => {
  try {
    const r = await pool.query(
      'SELECT id, sku, title, price_cents, stock FROM products ORDER BY id ASC'
    );
    res.json({ count: r.rows.length, items: r.rows });
  } catch (e) {
    console.error(e);
    res.status(503).json({ error: 'database_unavailable', detail: String(e.message || e) });
  }
});

app.listen(port, '0.0.0.0', () => {
  console.log(`rivermarket-api listening on ${port}`);
});
