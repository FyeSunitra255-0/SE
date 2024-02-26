{extends file='page.tpl'}

{** upload slip **}
{block name="content"}
    <section id="main" style="margin-bottom: 1.563rem;">
        <div class="row product-container js-product-container">
            <div class="col-md-6">
                {if $QR_GENERATE }
                    <img src="{$QR_GENERATE}" style="width: 100%;" />
                {else}
                    <div style="background: #fff; display: flex; justify-content: center; align-items: center; width: 100%; aspect-ratio: 1/1;">
                        Wrong Promptpay ID!
                    </div>
                {/if}
            </div>
            <div class="col-md-6">
                <div style="display: flex; justify-content: space-between; margin-top: 30px;">
                    <h1>
                        Total
                    </h1>
                    <h1 style="display: flex; justify-content: end;">
                        {$PRICE} THB
                    </h1>
                </div>
                <hr>
                <form method="post" enctype="multipart/form-data">
                    <section class="form-fields">
                        <div class="form-group row" style="margin-bottom: 0;">
                            <div class="col-md-12 col-md-offset-3" style="margin: 15px 0;">
                                <h3>Upload a slip</h3>
                            </div>
                            <div class="form-group row">
                                <div class="col-md-12" style="padding: 0 30px;">
                                    <input id="file-upload" type="file" name="slip_upload" class="filestyle" data-buttontext="Choose file" tabindex="-1" style="position: absolute; clip: rect(0px, 0px, 0px, 0px);">
                                </div>
                            </div>
                        </div>

                        <div class="form-group row" style="margin-bottom: 0;">
                            <label class="col-md-12 col-form-label" style="margin: 0; text-align: left;">
                                Do you need a tax invoice?
                            </label>
                            <div class="col-md-12">
                                <div class="form-check form-check-inline" style="margin-right: 5px;">
                                    <input class="form-check-input" type="radio" name="tax_invoice" id="tax_invoice_yes" value="yes">
                                    <label class="form-check-label" for="tax_invoice_yes">Yes</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="tax_invoice" id="tax_invoice_no" value="no" checked>
                                    <label class="form-check-label" for="tax_invoice_no">No</label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group row" id="tax_invoice_form" style="display: none;">
                            <label for="inputName" class="col-md-12 col-form-label" style="text-align: left;">Name</label>
                            <div class="col-md-12">
                                <input type="text" class="form-control" id="inputName" name="inputName">
                            </div>

                            <label for="inputName" class="col-md-12 col-form-label" style="text-align: left;">Address</label>
                            <div class="col-md-12">
                                <input type="text" class="form-control" id="inputAddress" name="inputAddress">
                            </div>

                            <label for="inputPhone" class="col-md-12 col-form-label" style="text-align: left;">Phone</label>
                            <div class="col-md-12">
                                <input type="number" class="form-control" id="inputPhone" name="inputPhone">
                            </div>

                            <label for="inputTax" class="col-md-12 col-form-label" style="text-align: left;">Tax ID</label>
                            <div class="col-md-12">
                                <input type="number" class="form-control" id="inputTax" name="inputTax">
                            </div>
                        </div>
                    </section>

                    <footer class="form-footer">
                        <button class="btn btn-primary" type="submit" name="placeorder" style="width: 100%;">
                            Upload
                        </button>
                    </footer>
                </form>
            </div>
        </div>
    </section>

    <!-- Add this script to the end of your template -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const taxInvoiceRadio = document.querySelector('input[name="tax_invoice"]');
        const taxInvoiceForm = document.getElementById('tax_invoice_form');
        const inputPhone = document.getElementById('inputPhone');
        const inputTax = document.getElementById('inputTax');
        const form = document.querySelector('form');

        taxInvoiceRadio.addEventListener('change', function () {
            taxInvoiceForm.style.display = this.value === 'yes' ? 'block' : 'none';
        });

        form.addEventListener('submit', function (event) {
            if (taxInvoiceRadio.value === 'yes') {
                if (!validatePhoneNumber(inputPhone.value)) {
                    alert('Please enter a valid phone number with 10 digits.');
                    event.preventDefault();
                    return;
                }

                if (!validateTaxID(inputTax.value)) {
                    alert('Please enter a valid tax ID with 13 digits.');
                    event.preventDefault();
                    return;
                }
            }

            // Capture form data
            const formData = new FormData(form);
            const formDataObject = {};
            formData.forEach((value, key) => {
                formDataObject[key] = value;
            });

            // Display popup with captured data
            const popupContent = JSON.stringify(formDataObject, null, 2);
            const popup = window.open('', '_blank', 'width=600,height=400');
            popup.document.write('<pre>' + popupContent + '</pre>');
            popup.document.write('<button onclick="window.close()">Close</button>');
            popup.document.close();
        });

        function validatePhoneNumber(phone) {
            const phoneRegex = /^\d{10}$/;
            return phoneRegex.test(phone);
        }

        function validateTaxID(taxID) {
            const taxIDRegex = /^\d{13}$/;
            return taxIDRegex.test(taxID);
        }
    });
</script>


{/block}
