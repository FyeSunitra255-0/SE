{extends file='page.tpl'}
{block name="content"}
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <div class="container mt-4">
    <form action="{$payment_option->getAction()} method="POST" action="process_payment.php">
      <!-- Payment Method -->
      <!-- Payment Method -->
      <div class="form-group">
        <label for="paymentMethod">Choose Payment Method:</label>
        <div class="form-check">
          <input
            type="radio"
            class="form-check-input"
            id="bankTransfer"
            name="paymentMethod"
            value="bankTransfer"
          />
          <label class="form-check-label" for="bankTransfer"
            >Bank Transfer</label
          >
        </div>
        <div class="form-check">
          <input
            type="radio"
            class="form-check-input"
            id="qrPayment"
            name="paymentMethod"
            value="qrPayment"
          />
          <label class="form-check-label" for="qrPayment">QR Payment</label>
        </div>
      </div>

      <!-- Display Bank Information or QR Code based on selected payment method -->
      <div class="form-group" id="bankInfo" style="display: none">
        <label for="bankInfo">Bank Information:</label>
        <div class="form-check">
          <input
            type="radio"
            class="form-check-input"
            id="kasikornBank"
            name="bankInfo"
            value="kasikornBank"
          />
          <label class="form-check-label" for="kasikornBank"
            >Kasikorn Bank<br />0761585584<br />Sunitra</label
          >
        </div>
      </div>
      <div class="form-group" id="qrCode" style="display: none">
        <img src="qr.jpg" alt="QR Code" style="width: 50%; height: 50%" />
      </div>

      <!-- Tax Invoice -->
      <div class="form-group">
        <label for="taxInvoice">Do you need a tax invoice?</label>
        <div class="form-check">
          <input
            type="radio"
            class="form-check-input"
            id="yesTax"
            name="taxInvoice"
            value="yes"
          />
          <label class="form-check-label" for="yesTax">Yes</label>
        </div>
        <div class="form-check">
          <input
            type="radio"
            class="form-check-input"
            id="noTax"
            name="taxInvoice"
            value="no"
          />
          <label class="form-check-label" for="noTax">No</label>
        </div>
      </div>

      <!-- Tax Invoice Information (displayed only if "Yes" is selected) -->
      <div class="form-group" id="taxInvoiceInfo" style="display: none">
        <label for="name">Name:</label>
        <input type="text" class="form-control" id="name" name="name" />
        <label for="address">Address:</label>
        <input type="text" class="form-control" id="address" name="address" />
        <label for="tel">Tel:</label>
        <input type="text" class="form-control" id="tel" name="tel" />
        <label for="tax">Tax ID:</label>
        <input type="text" class="form-control" id="tax" name="tax" />
      </div>

      <!-- เพิ่มฟอร์มอัพสลิป -->
      <div class="form-group">
        <label for="paymentProof">Upload Slip:</label>
        <input
          type="file"
          class="form-control-file"
          id="paymentProof"
          name="paymentProof"
          required
        />
        <small class="form-text text-muted"
          >Please upload an image as proof of payment.</small
        >
      </div>

      <!-- Submit Button -->
      <button type="submit" class="btn btn-primary">Submit</button>
    </form>
  </div>

  <!-- Link to Bootstrap JS and Popper.js -->
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <script>
    $(document).ready(function () {
      // Show/Hide Bank Information or QR Code based on selected payment method
      $('input[name="paymentMethod"]').change(function () {
        if (this.value === "bankTransfer") {
          $("#bankInfo").show();
          $("#qrCode").hide();
        } else if (this.value === "qrPayment") {
          $("#bankInfo").hide();
          $("#qrCode").show();
        }
      });

      // Show/Hide Tax Invoice Information based on selected tax invoice option
      $('input[name="taxInvoice"]').change(function () {
        if (this.value === "yes") {
          $("#taxInvoiceInfo").show();
        } else if (this.value === "no") {
          $("#taxInvoiceInfo").hide();
        }
      });

      // Disable submit button if file input is empty
      $("#submitButton").prop("disabled", true);

      // Enable submit button when a file is selected
      $("#paymentProof").change(function () {
        if ($(this).val()) {
          $("#submitButton").prop("disabled", false);
        } else {
          $("#submitButton").prop("disabled", true);
        }
      });
    });
  </script>
{/block}