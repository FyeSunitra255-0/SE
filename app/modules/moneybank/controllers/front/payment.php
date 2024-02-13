<?php
class MoneybankPaymentModuleFontController extends ModuleFrontController{
	public function init()
	{
		parent::init();
        if(!$this->module->active 
        || !$this->context->cart->id_address_delivery
        || !$this->context->cart->id_address_invoice){
            Tools::redirect($this->context->link->getPageLink('order'));
        }
        $customer = $this->context->customer;
        if(!Validate::isLoadedObject($customer)){
            Tools::redirect($this->context->link->getPageLink('order'));
        }
	}
	public function initContent()
	{
		parent::initContent();
		$this->setTemplate('module:moneybank/views/templates/front/payment.tpl');
	}
	public function setMedia()
	{
		parent::setMedia();
	}
    public function postProcess(){
        //Tools::dieObject($_POST);

        parent::postProcess();

        if(Tools::isSubmit('placeorder')){
            $couponcode = Tools::getValue('couponcode');
            $pattern = '/([A-Z]{3}[0-9]{2}){2}/';
            $matches = array();
            preg_match($pattern, $couponcode, $matches);
            //Tools::dieObject($matches);
            if(isset($matches[0]) && $matches[0]){
                $cart = $this->context->cart;
                $total = (float)$cart->getOrderTotal(true, Cart::BOTH);
                $customer = new Customer($cart->id_customer);
                $this->module->validateOrder($cart->id, Configuration::get('PS_OS_PAYMENT'), $total, $this->module->displayName, null, array(), $this->context->currency->id, false, $customer->secure_key);
                Tools::redirect($this->context->link->getPageLink('order-confirmation', Configuration::get('PS_SSL_ENABLED'), $this->context->language->id, 'id_cart='.$cart->id.'&id_module='.$this->module->id.'&id_order='.$this->module->currentOrder.'&key='.$customer->secure_key));
            }
        }
    }
}
