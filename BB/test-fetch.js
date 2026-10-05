import https from 'https';

async function getHtml() {
  const url = 'https://www.bharath24news.com/';
  return new Promise((resolve, reject) => {
    https.get(url, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => resolve(data));
    }).on('error', reject);
  });
}

getHtml().then(html => console.log(html.substring(0, 200))).catch(console.error);
