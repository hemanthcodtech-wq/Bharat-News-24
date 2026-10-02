const { createClient } = require('redis');

const redisClient = createClient({
  url: process.env.REDIS_URL || 'redis://127.0.0.1:6379'
});

redisClient.on('error', (err) => console.log('Redis Client Error:', err.message));

// Connect automatically but don't crash if it fails
redisClient.connect().catch((err) => console.log('Redis Connection Failed:', err.message));

// Create safe wrapper methods so the app doesn't crash if Redis is unavailable (e.g. on Vercel)
const safeCache = {
  get: async (key) => {
    if (!redisClient.isReady) return null;
    try { return await redisClient.get(key); } catch (e) { return null; }
  },
  setEx: async (key, seconds, value) => {
    if (!redisClient.isReady) return;
    try { await redisClient.setEx(key, seconds, value); } catch (e) { console.error('Redis SetEx Error:', e.message); }
  },
  flushDb: async () => {
    if (!redisClient.isReady) return;
    try { await redisClient.flushDb(); } catch (e) { console.error('Redis FlushDb Error:', e.message); }
  }
};

module.exports = safeCache;
