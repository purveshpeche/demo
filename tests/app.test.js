const request = require('supertest');
const app = require('../index');

describe('Sample App Tests', () => {
  describe('GET /', () => {
    it('should return hello message', async () => {
      const response = await request(app)
        .get('/')
        .expect(200);
      
      expect(response.text).toBe('Hello from sample-app');
    });
  });

  describe('GET /error', () => {
    it('should return error status 500', async () => {
      const response = await request(app)
        .get('/error')
        .expect(500);
      
      expect(response.text).toBe('simulated error');
    });
  });

  describe('Server Health', () => {
    it('should start server without errors', () => {
      expect(app).toBeDefined();
    });
  });
});

