import https from 'https';

export default async function handler(req, res) {
  try {
    const staticUrls = [
      { loc: 'https://bharath24news.com/', changefreq: 'always', priority: '1.0' },
      { loc: 'https://bharath24news.com/flip', changefreq: 'hourly', priority: '0.9' },
      { loc: 'https://bharath24news.com/trending', changefreq: 'hourly', priority: '0.9' },
      { loc: 'https://bharath24news.com/epaper', changefreq: 'daily', priority: '0.9' },
      { loc: 'https://bharath24news.com/category/telangana', changefreq: 'hourly', priority: '0.8' },
      { loc: 'https://bharath24news.com/category/andhra', changefreq: 'hourly', priority: '0.8' },
      { loc: 'https://bharath24news.com/category/politics', changefreq: 'hourly', priority: '0.8' },
      { loc: 'https://bharath24news.com/category/national', changefreq: 'hourly', priority: '0.8' },
      { loc: 'https://bharath24news.com/category/international', changefreq: 'hourly', priority: '0.8' },
      { loc: 'https://bharath24news.com/category/entertainment', changefreq: 'hourly', priority: '0.8' },
      { loc: 'https://bharath24news.com/category/sports', changefreq: 'hourly', priority: '0.8' },
      { loc: 'https://bharath24news.com/category/crime', changefreq: 'hourly', priority: '0.8' },
      { loc: 'https://bharath24news.com/about', changefreq: 'monthly', priority: '0.5' },
      { loc: 'https://bharath24news.com/contact', changefreq: 'monthly', priority: '0.5' },
      { loc: 'https://bharath24news.com/privacy', changefreq: 'monthly', priority: '0.5' },
      { loc: 'https://bharath24news.com/advertise', changefreq: 'monthly', priority: '0.5' },
      { loc: 'https://bharath24news.com/terms', changefreq: 'monthly', priority: '0.5' }
    ];

    const apiUrl = 'https://bharat-news-24-94ag.vercel.app/api/news?limit=250';
    const fetchNews = () => new Promise((resolve) => {
      const timeout = setTimeout(() => resolve([]), 5000);
      const request = https.get(apiUrl, (response) => {
        let data = '';
        response.on('data', chunk => data += chunk);
        response.on('end', () => {
          clearTimeout(timeout);
          try {
            const parsed = JSON.parse(data);
            resolve(Array.isArray(parsed) ? parsed : []);
          } catch (e) {
            resolve([]);
          }
        });
      });
      request.on('error', () => {
        clearTimeout(timeout);
        resolve([]);
      });
      request.on('timeout', () => {
        request.destroy();
        clearTimeout(timeout);
        resolve([]);
      });
    });

    const articles = await fetchNews();

    let xml = `<?xml version="1.0" encoding="UTF-8"?>\n`;
    xml += `<?xml-stylesheet type="text/xsl" href="/sitemap.xsl"?>\n`;
    xml += `<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n`;

    for (const u of staticUrls) {
      xml += `  <url>\n    <loc>${u.loc}</loc>\n    <changefreq>${u.changefreq}</changefreq>\n    <priority>${u.priority}</priority>\n  </url>\n`;
    }

    const seenSlugs = new Set();
    for (const a of articles) {
      if (!a.slug || seenSlugs.has(a.slug)) continue;
      seenSlugs.add(a.slug);
      
      let lastmodStr;
      try {
        lastmodStr = new Date(a.updated_at || a.created_at || Date.now()).toISOString();
      } catch (_) {
        lastmodStr = new Date().toISOString();
      }

      xml += `  <url>\n`;
      xml += `    <loc>https://bharath24news.com/article/${encodeURIComponent(a.slug)}</loc>\n`;
      xml += `    <lastmod>${lastmodStr}</lastmod>\n`;
      xml += `    <changefreq>weekly</changefreq>\n`;
      xml += `    <priority>0.8</priority>\n`;
      xml += `  </url>\n`;
    }

    xml += `</urlset>`;

    res.setHeader('Content-Type', 'application/xml; charset=utf-8');
    res.setHeader('Cache-Control', 's-maxage=600, stale-while-revalidate=1800');
    return res.status(200).send(xml);
  } catch (err) {
    console.error('Error generating dynamic sitemap:', err);
    res.status(500).send('Error generating sitemap');
  }
}
