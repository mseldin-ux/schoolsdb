const { defineConfig } = require('@playwright/test');

module.exports = defineConfig({
  testDir: './tests/browser',
  workers: 1,
  use: { baseURL: process.env.ADMIN_TEST_URL, headless: true },
  reporter: 'list',
});
