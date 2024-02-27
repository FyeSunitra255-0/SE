import { test, expect } from '@playwright/test';

test('Add_Delete', async ({ page }) => {
  await page.goto('http://localhost:8000/en/');
  await page.getByRole('link', { name: 'Voucher 1000฿' }).first().click();
  await page.getByRole('button', { name: ' Add to cart' }).click();
  await page.getByRole('link', { name: ' Proceed to checkout' }).click();
  await page.getByRole('link', { name: 'chevron_left Continue shopping' }).click();
  await page.getByLabel('Shopping cart link containing').click();
  await page.getByRole('link', { name: 'delete' }).click();
});