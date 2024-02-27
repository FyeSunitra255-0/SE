import { test, expect } from '@playwright/test';

test('test_', async ({ page }) => {
  // Navigate to the initial page
  await page.goto('http://localhost:8000/en/');

  // Click on the voucher link
  await page.getByRole('link', { name: 'Voucher 1000฿' }).first().click();

  // Right-click on the 'Add to cart' button
  await page.getByRole('button', { name: ' Add to cart' }).click({ button: 'right' });

  // Left-click on the 'Add to cart' button again
  await page.getByRole('button', { name: ' Add to cart' }).click();

  // Proceed to checkout
  await page.getByRole('link', { name: ' Proceed to checkout' }).click();
  await page.getByRole('link', { name: 'Proceed to checkout' }).click();

  // Check 'Bank Transfer' option
  await page.getByLabel('Bank Transfer').check();

  // Upload a file
  await page.getByRole('textbox').setInputFiles('s1.jpg');
  await page.getByRole('button', { name: 'Upload Slip' }).click();

  // Assertions to check if the expected elements are present or if the page has changed as expected
  await expect(page).toHaveURL('http://localhost:8000/en/checkout'); // Example URL check
  await expect(page).toHaveSelector('.confirmation-message'); // Example check for a confirmation message

  // Add more assertions as needed based on your expected page structure and content
});
