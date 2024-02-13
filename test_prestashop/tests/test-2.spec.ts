import { test, expect } from '@playwright/test';

test('test_voucherInvoice', async ({ page }) => {
  await page.goto('http://localhost:8000/en/');
  await page.getByRole('link', { name: 'Voucher 1000฿' }).first().click();
  await page.getByRole('button', { name: ' Add to cart' }).click();
  await page.getByRole('link', { name: ' Proceed to checkout' }).click();
  await page.getByRole('link', { name: 'Proceed to checkout' }).click();
  await page.getByText('Bank Transfer').click();
  await page.getByLabel('Kasikorn Bank0761585584Sunitra').check();
  await page.getByLabel('Yes').check();
  await page.getByLabel('Name:').click();
  await page.getByLabel('Name:').fill('praweena wongsa');
  await page.getByLabel('Address:').click();
  await page.getByLabel('Address:').fill('3321 m2 chaiyaphum');
  await page.getByLabel('Tel:').click();
  await page.getByLabel('Tel:').fill('0811111111');
  await page.getByLabel('Tax ID:').fill('Th6430200');
  await page.getByLabel('Upload Slip:').click();
  await page.getByLabel('Upload Slip:').setInputFiles('qr.jpg');
  await page.getByRole('button', { name: 'Submit' }).click();

  const confirmationTitle = await page.textContent('h1');
  expect(confirmationTitle).toBe('Order Confirmation');

});