import { test, expect } from '@playwright/test';

test('Voucher_notInvoice', async ({ page }) => {
  await page.goto('http://localhost:8000/en/');
  await page.getByRole('link', { name: 'Voucher 500฿' }).first().click();
  await page.getByRole('button', { name: '' }).click();
  await page.getByRole('button', { name: ' Add to cart' }).click();
  await page.getByRole('link', { name: ' Proceed to checkout' }).click();
  await page.getByRole('link', { name: 'Proceed to checkout' }).click();
  await page.getByLabel('Counter Service').check();
  
  await page.getByRole('textbox').setInputFiles('s1.jpg');
  await page.getByRole('button', { name: 'Upload Slip' }).click();
  await expect(page).toHaveURL('http://localhost:8000/en/checkout'); 
  await expect(page).toHaveSelector('.confirmation-message');
});