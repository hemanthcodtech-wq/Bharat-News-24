const { Pool } = require('pg');
require('dotenv').config();
const crypto = require('crypto');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: {
    rejectUnauthorized: false
  }
});

const categories = ['national', 'telangana', 'andhra', 'business', 'sports', 'entertainment', 'technology'];
const authors = ['K.SUSHMA REKHA', 'News Desk', 'Tech Correspondent', 'Sports Editor', 'Business Analyst'];
const imagePool = [
  "https://images.unsplash.com/photo-1541185933-ef5d8ed016c2?w=800&q=80",
  "https://images.unsplash.com/photo-1596443686812-2f45229eebc3?w=800&q=80",
  "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800&q=80",
  "https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800&q=80",
  "https://images.unsplash.com/photo-1495020689067-958852a7765e?w=800&q=80",
  "https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=800&q=80",
  "https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=800&q=80",
  "https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&q=80"
];

const sampleTitles = [
  "Government announces new initiative",
  "Tech companies see record profits",
  "Local sports team wins championship",
  "New breakthrough in medical research",
  "Global markets react to recent events",
  "Upcoming movie sets box office records",
  "New regulations affect local businesses",
  "Startups drive innovation in the sector"
];

async function seedData() {
  try {
    await pool.query('SET search_path TO public;');
    
    // Ensure categories exist
    const categoryIds = {};
    for (const cat of categories) {
      const res = await pool.query(`
        INSERT INTO public.categories (name, slug) 
        VALUES ($1, $2) 
        ON CONFLICT (slug) DO UPDATE SET name = EXCLUDED.name
        RETURNING id
      `, [cat.charAt(0).toUpperCase() + cat.slice(1), cat]);
      categoryIds[cat] = res.rows[0].id;
    }

    console.log("Categories ready. Inserting 100 articles...");

    let count = 0;
    for (let i = 0; i < 100; i++) {
      const randomCat = categories[Math.floor(Math.random() * categories.length)];
      const randomAuthor = authors[Math.floor(Math.random() * authors.length)];
      const randomImg = imagePool[Math.floor(Math.random() * imagePool.length)];
      const randomTitleBase = sampleTitles[Math.floor(Math.random() * sampleTitles.length)];
      
      const uuid = crypto.randomUUID().substring(0, 8);
      const title = `${randomTitleBase} - Part ${i + 1} (${uuid})`;
      const slug = `article-${uuid}-${i}`;
      const content = `<p>This is a detailed report on ${title}. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel risus nec nulla ullamcorper sodales. Mauris sit amet fermentum orci.</p><p>Phasellus auctor tellus eget massa volutpat, vitae viverra erat condimentum. Nulla facilisi. Proin id est vel quam cursus eleifend.</p>`;
      const excerpt = `A brief look into ${title}. Discover the full details in our comprehensive report.`;
      const is_trending = Math.random() > 0.8; // 20% chance of being trending

      await pool.query(`
        INSERT INTO public.news (title, slug, content, excerpt, image, author, category_id, is_trending, is_published, status)
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8, true, 'approved')
        ON CONFLICT (slug) DO NOTHING
      `, [title, slug, content, excerpt, randomImg, randomAuthor, categoryIds[randomCat], is_trending]);
      count++;
      if (count % 10 === 0) console.log(`Inserted ${count} articles...`);
    }
    
    console.log("✅ Successfully inserted 100 news articles!");
  } catch (e) {
    console.error("❌ Error inserting data:", e);
  } finally {
    pool.end();
  }
}

seedData();
