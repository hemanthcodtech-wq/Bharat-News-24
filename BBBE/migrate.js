const pool = require('./db');

async function migrate() {
  try {
    console.log('Running migration...');

    await pool.query(`
      CREATE TABLE IF NOT EXISTS admin_users (
        id SERIAL PRIMARY KEY,
        name VARCHAR(150) NOT NULL,
        email VARCHAR(150) UNIQUE NOT NULL,
        password_hash TEXT NOT NULL,
        role VARCHAR(50) DEFAULT 'admin',
        allowed_categories INTEGER[] DEFAULT '{}',
        reset_code VARCHAR(10),
        reset_code_expires_at TIMESTAMP,
        created_at TIMESTAMP DEFAULT NOW()
      );
    `);

    await pool.query(`
      ALTER TABLE admin_users
      ADD COLUMN IF NOT EXISTS allowed_categories INTEGER[] DEFAULT '{}',
      ADD COLUMN IF NOT EXISTS reset_code VARCHAR(10),
      ADD COLUMN IF NOT EXISTS reset_code_expires_at TIMESTAMP;
    `);
    console.log('✅ Ensured admin_users columns are present');

    await pool.query(`
      ALTER TABLE news
      ADD COLUMN IF NOT EXISTS status VARCHAR(20) DEFAULT 'approved',
      ADD COLUMN IF NOT EXISTS created_by INTEGER REFERENCES admin_users(id) ON DELETE SET NULL;
    `);

    await pool.query(`
      UPDATE news SET status = 'approved' WHERE status IS NULL;
    `);
    console.log('✅ Added status and created_by to news');

    console.log('Migration completed successfully!');
    process.exit(0);
  } catch (err) {
    console.error('❌ Migration failed:', err.message);
    process.exit(1);
  }
}

migrate();
