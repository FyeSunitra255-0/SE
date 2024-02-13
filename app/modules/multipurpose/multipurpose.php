<?php
use PrestaShop\Module\FacetedSearch\Hook\Configuration;
class Multipurpose extends Module
{
    public function __construct()
    {
        $this->name = 'multipurpose';
        $this->author = 'Group4';
        $this->version = '1.0.0';
        $this->booststrap = true;
        parent::__construct();
        $this->displayName = $this->l('Multipurpose');
        $this->description = $this->l('This is part of the Prestashop module development');
        $this->ps_versions_compliancy = array('min' => '1.7.0.0', 'max'=>'8.1.3');
    }
    public function install()
    {
        return parent::install() && $this->registerHook('displayHome');
    }
    public function uninstall()
    {
        return parent::uninstall();
    }
    public function hookDisplayHome()
    {
        return $this->display(__FILE__, 'views/templates/hook/home.tpl');
    }
    public function hookHeader()
    {
        $this->context->controller->addCSS(array(
            $this->_path.'views/css/multipurpose.css'
        ));
        $this->context->controller->addJS(array(
            $this->_path.'views/js/multipurpose.js'
        ));
    }
    public function getContent()
    {
        if(Tools::isSubmit('savemultipurposesting'))
        {
            $name = Tools::getValue('print');
            Configuration::updateValue('MULTIPURPOSE_STR', $name);
        }
        $this->context->smarty->assign(array(
            'MULTIPURPOSE_STR' => Configuration::get('MULTIPURPOSE_STR')
        ));
        return $this->display(__FILE__, 'views/templates/admin/configure.tpl');
    }
}