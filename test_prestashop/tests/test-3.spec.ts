import { test, expect } from '@playwright/test';

test('test_PreOder', async ({ page }) => {
  await page.goto('http://localhost:8000/en/');
  await page.getByRole('link', { name: 'Jacket' }).first().click();
  await page.getByLabel('Size').selectOption('2');
  await page.getByRole('button', { name: '' }).click();
  await page.getByRole('button', { name: '' }).click();
  await page.getByRole('button', { name: ' Add to cart' }).click();
  await page.getByRole('link', { name: ' Proceed to checkout' }).click();
  await page.getByRole('link', { name: 'Proceed to checkout' }).click();
  await page.getByLabel('QR Payment').check();
  await page.locator('#content #content-wrapper div').filter({ hasText: 'No' }).nth(2).click();
  await page.getByLabel('No').check();
  await page.getByLabel('Upload Slip:').click();
  await page.getByLabel('Upload Slip:').setInputFiles('qr.jpg');
  await page.getByRole('button', { name: 'Submit' }).click();
  const confirmationTitle = await page.textContent('h1');
  expect(confirmationTitle).toBe('Order Confirmation');

});