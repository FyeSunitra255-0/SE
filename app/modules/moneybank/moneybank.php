<?php
use PrestaShop\PrestaShop\Core\Payment\PaymentOption;
class Moneybank extends PaymentModule
{

    public function __construct()
    {
        $this->name = 'moneybank';
        $this->author = 'group4';
        $this->version = '1.0.0';
        $this->bootstrap = true;
        parent::__construct();
        $this->displayName = $this->l('Moneybank') ;
        $this->description = $this->l('The fastest way to pay!');
        $this->ps_versions_compliancy = array ('min' => '1.7.0.0','max' => '8.1.3');
    }
    public function install()
    {
        return parent::install()
        && $this->registerHook('header')
        && $this->registerHook('displayPaymentReturn')
        && $this->registerHook('paymentOptions');

    }
    public function uninstall()
    {
        return parent::uninstall();
    }
    public function hookDisplayPaymentReturn()
    {
        $this->context->smarty->assign(array(
            
        ));
        return $this->display(__FILE__,'views/templates/hook/return.tpl');
    }

    public function hookPaymentOptions ()
    {
        $moneybank = new PaymentOption();
        $moneybank->setModuleName($this->name)
            ->setCallToActionText($this->displayName)
            ->setAdditionalInformation('This is additional information')
            ->setAction($this->context->link->getModuleLink($this->name, 'payment'));

        // Load the template file payment.tpl
        $this->context->smarty->assign(array(
            'payment_option' => $moneybank,
            'module_name' => $this->name,
            'path' => $this->_path,
        ));

        return array($moneybank);

    }
}