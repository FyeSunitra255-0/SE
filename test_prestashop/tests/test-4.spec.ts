import { test, expect } from '@playwright/test';

test('test_PreOderInvoice', async ({ page }) => {
  await page.goto('http://localhost:8000/en/');
  await page.getByRole('link', { name: 'Jacket' }).first().click();
  await page.getByLabel('Size').selectOption('3');
  await page.getByRole('button', { name: ' Add to cart' }).click();
  await page.getByRole('link', { name: 'Proceed to checkout' }).click();
  await page.getByLabel('QR Payment').check();
  await page.getByLabel('Yes').check();
  await page.getByLabel('Name:').click();
  await page.getByLabel('Name:').fill('praweena');
  await page.getByLabel('Address:').click();
  await page.getByLabel('Address:').fill('12345');
  await page.getByLabel('Tel:').click();
  await page.getByLabel('Tel:').fill('0987654321');
  await page.getByLabel('Tax ID:').click();
  await page.getByLabel('Tax ID:').fill('Th123456');
  await page.getByLabel('Upload Slip:').click();
  await page.getByLabel('Upload Slip:').setInputFiles('qr.jpg');
  await page.getByRole('button', { name: 'Submit' }).click();
  const confirmationTitle = await page.textContent('h1');
  expect(confirmationTitle).toBe('Order Confirmation');
});