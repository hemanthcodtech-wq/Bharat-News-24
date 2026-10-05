import fs from 'fs';
import path from 'path';
import https from 'https';

export default async function(req, res) {
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

    const protocol = req.headers['x-forwarded-proto'] || (req.socket.encrypted ? 'https' : 'http');
    const host = req.headers['x-forwarded-host'] || req.headers.host;
    const baseUrl = `${protocol}://${host}`;

    let html = '';
    try {
      const indexRes = await fetch(`${baseUrl}/`);
      html = await indexRes.text();
    } catch (err) {
      console.error('Failed to fetch index.html:', err);
    }
    if (!html) {
      return res.status(500).send('Failed to load index.html');
    }

    if (!slug) {
      res.setHeader('Content-Type', 'text/html');
      return res.status(200).send(html);
    }

    // Fetch the article from the backend
    const apiUrl = `https://bharat-news-24-nji7.vercel.app/api/news/${encodeURIComponent(slug)}`;
    
    const fetchArticle = () => new Promise((resolve, reject) => {
      const reqTimeout = setTimeout(() => {
        resolve(null); // Resolve with null on timeout to fallback to default HTML
      }, 8000); // 8 seconds timeout to prevent Vercel 10s hard timeout

      const req = https.get(apiUrl, (response) => {
        let data = '';
        response.on('data', chunk => data += chunk);
        response.on('end', () => {
          clearTimeout(reqTimeout);
          try { resolve(JSON.parse(data)); }
          catch(e) { resolve(null); }
        });
      }).on('error', (err) => {
        clearTimeout(reqTimeout);
        resolve(null); // Resolve null on error rather than rejecting to serve fallback
      });
      
      // In case the connection takes too long to even start
      req.on('timeout', () => {
        req.destroy();
        clearTimeout(reqTimeout);
        resolve(null);
      });
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
        <meta property="og:image:width" content="1200" />
        <meta property="og:image:height" content="630" />
        <meta property="og:url" content="${url}" />
        <meta name="twitter:card" content="summary_large_image" />
        <meta name="twitter:title" content="${title}" />
        <meta name="twitter:description" content="${desc}" />
        <meta name="twitter:image" content="${image}" />
      `;

      // Remove default meta tags so they don't override the article ones (WhatsApp picks the first og:image it sees)
      html = html.replace(/<meta property="og:[^>]+>/g, '');
      html = html.replace(/<meta name="twitter:[^>]+>/g, '');
      html = html.replace(/<title>.*?<\/title>/, '');

      // Replace the default title or just insert before </head>
      html = html.replace('</head>', `${metaTags}</head>`);
    }

    res.setHeader('Content-Type', 'text/html');
    res.setHeader('Cache-Control', 's-maxage=60, stale-while-revalidate=300');
    res.send(html);
  } catch (error) {
    console.error('Error generating dynamic HTML:', error);
    try {
      res.setHeader('Content-Type', 'text/html');
      res.status(200).send(html || '<!doctype html><html><head><title>Bharath 24</title></head><body><div id="root"></div><script type="module" src="/src/main.jsx"></script></body></html>');
    } catch(e) {
      res.status(500).send('Internal Server Error');
    }
  }
};
