const func = require('./api/article.js');
const res = {
  status: (code) => { console.log('STATUS:', code); return res; },
  send: (data) => { console.log('SEND:', data.substring(0, 20) + '...'); return res; },
  setHeader: (k, v) => { console.log('SET HEADER:', k, v); return res; }
};
const req = {
  url: '/article/%E0%B0%B0%E0%B1%87%E0%B0%B5%E0%B0%82%E0%B0%A4%E0%B1%8D',
  query: { slug: 'రేవంత్' }
};
func(req, res).catch(console.error);
