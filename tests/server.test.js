const request = require('supertest');
const app = require('../src/server');

describe('Server Health and Routes', () => {
  it('should return 200 on /health', async () => {
    const res = await request(app).get('/health');
    expect(res.statusCode).toEqual(200);
    expect(res.body.status).toEqual('healthy');
  });

  it('should return 200 on /', async () => {
    const res = await request(app).get('/');
    expect(res.statusCode).toEqual(200);
  });
});
