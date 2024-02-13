import { test, expect } from '@playwright/test';

test('test_order_confirmation_page', async ({ page }) => {
  // ทำการสั่งซื้อสินค้า
  await page.goto('http://localhost:8000/en/');
  await page.getByRole('link', { name: 'Voucher 100฿' }).first().click();
  await page.getByRole('button', { name: '' }).click();
  await page.getByRole('button', { name: '' }).click();
  await page.getByRole('button', { name: '' }).click();
  await page.getByRole('button', { name: ' Add to cart' }).click();
  await page.getByRole('link', { name: ' Proceed to checkout' }).click();
  await page.getByRole('link', { name: 'Proceed to checkout' }).click();

  // ทำการชำระเงิน
  await page.getByLabel('Bank Transfer').check();
  await page.getByLabel('Kasikorn Bank0761585584Sunitra').check();
  await page.getByLabel('No').check();
  await page.getByLabel('Upload Slip:').click();
  await page.getByLabel('Upload Slip:').setInputFiles('qr.jpg');

  // ตรวจสอบหน้าสุดท้ายหลังชำระเงิน
  await page.goto('http://localhost:8000/en/drder_confirmation.tpl');

  // ตรวจสอบว่าหน้าที่โหลดขึ้นมีส่วนที่คาดหวังหรือไม่
  const confirmationTitle = await page.textContent('h1');
  expect(confirmationTitle).toBe('Order Confirmation');

  // ตรวจสอบข้อมูลการสั่งซื้อ
  const orderDetails = await page.textContent('.order-details');
  expect(orderDetails).toContain('Order ID');
  expect(orderDetails).toContain('Total Amount');
  expect(orderDetails).toContain('Payment Method');

  // ตรวจสอบรายละเอียดการชำระเงิน
  const paymentDetails = await page.textContent('.payment-details');
  expect(paymentDetails).toContain('Bank Transfer');
  expect(paymentDetails).toContain('Account Number');
  expect(paymentDetails).toContain('Transaction Reference');

  // ตรวจสอบรูปภาพที่อัพโหลด
  const uploadedImage = await page.getAttribute('.uploaded-image', 'src');
  expect(uploadedImage).toBe('qr.jpg');
});