const fs = require('fs');
const path = require('path');
const https = require('https');

module.exports = async (req, res) => {
  try {
    // Vercel extracts path parameters from the rewrite rule if configured, 
    // or we can parse it from the URL.
    // e.g. /article/some-slug
    const urlParts = req.url.split('/');
    // Assuming the URL is something like /api/article?slug=... or /article/...
    let slug = req.query.slug;
    
    if (!slug) {
      // fallback manual parse
      const match = req.url.match(/\/article\/([^\/?#]+)/);
      if (match) slug = match[1];
    }

    // Read the static index.html built by Vite
    // In Vercel, the output dir for Vite is usually 'dist'
    let htmlPath = path.join(process.cwd(), 'dist', 'index.html');
    if (!fs.existsSync(htmlPath)) {
      // Fallback for local testing or different output dir
      htmlPath = path.join(process.cwd(), 'index.html');
    }
    
    let html = '';
    if (fs.existsSync(htmlPath)) {
      html = fs.readFileSync(htmlPath, 'utf8');
    } else {
      return res.status(500).send('index.html not found');
    }

    if (!slug) {
      return res.setHeader('Content-Type', 'text/html').send(html);
    }

    // Fetch the article from the backend
    const apiUrl = `https://bharat-news-24-nji7.vercel.app/api/news/${encodeURIComponent(slug)}`;
    
    const fetchArticle = () => new Promise((resolve, reject) => {
      https.get(apiUrl, (response) => {
        let data = '';
        response.on('data', chunk => data += chunk);
        response.on('end', () => {
          try { resolve(JSON.parse(data)); }
          catch(e) { resolve(null); }
        });
      }).on('error', reject);
    });

    const article = await fetchArticle();

    if (article && !article.error) {
      const title = article.title ? article.title.replace(/"/g, '&quot;') : 'Bharath 24 News';
      const desc = article.excerpt ? article.excerpt.replace(/"/g, '&quot;') : 'Read the latest news on Bharath 24 News';
      const image = article.image || 'https://www.bharath24news.com/logo.png'; // default fallback
      const url = `https://www.bharath24news.com/article/${slug}`;

      // Inject Meta Tags into the HTML <head>
      const metaTags = `
        <title>${title} - Bharath 24 News</title>
        <meta name="description" content="${desc}" />
        <meta property="og:type" content="article" />
        <meta property="og:title" content="${title}" />
        <meta property="og:description" content="${desc}" />
        <meta property="og:image" content="${image}" />
        <meta property="og:url" content="${url}" />
        <meta name="twitter:card" content="summary_large_image" />
        <meta name="twitter:title" content="${title}" />
        <meta name="twitter:description" content="${desc}" />
        <meta name="twitter:image" content="${image}" />
      `;

      // Replace the default title or just insert before </head>
      // We will insert before </head> to ensure they are added
      html = html.replace('</head>', `${metaTags}</head>`);
      
      // Optionally remove the default title to avoid duplicates
      html = html.replace(/<title>.*?<\/title>/, '');
    }

    res.setHeader('Content-Type', 'text/html');
    res.setHeader('Cache-Control', 's-maxage=60, stale-while-revalidate=300');
    res.send(html);
  } catch (error) {
    console.error('Error generating dynamic HTML:', error);
    // On error, just serve the default index.html without dynamic tags
    try {
      const htmlPath = fs.existsSync(path.join(process.cwd(), 'dist', 'index.html')) 
        ? path.join(process.cwd(), 'dist', 'index.html') 
        : path.join(process.cwd(), 'index.html');
      const html = fs.readFileSync(htmlPath, 'utf8');
      res.setHeader('Content-Type', 'text/html').send(html);
    } catch(e) {
      res.status(500).send('Internal Server Error');
    }
  }
};
