const { Client } = require('pg');
const client = new Client({ connectionString: 'postgresql://neondb_owner:npg_dOLSRi2a6TxX@ep-dawn-frost-b5mf1z2a-pooler.c-7.us-east-2.aws.neon.tech/neondb?sslmode=require&channel_binding=require' });

client.connect().then(async () => {
  const res = await client.query("SELECT id, slug FROM news WHERE slug LIKE '% %' OR slug LIKE '%‌%'");
  console.log('Found rows:', res.rows.length);
  
  for (let row of res.rows) {
    let newSlug = row.slug.toLowerCase().trim().replace(/\s+/g, '-').replace(/[^\p{L}\p{N}\p{M}-]/gu, '');
    console.log(`Updating ${row.id}: ${row.slug} -> ${newSlug}`);
    await client.query("UPDATE news SET slug = $1 WHERE id = $2", [newSlug, row.id]);
  }
  
  console.log("Done");
  client.end();
}).catch(console.error);
