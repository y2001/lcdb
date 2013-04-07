<?php

class AdminCustomersController extends AdminCustomersControllerCore
{
	
	public function __construct()
	{
		parent::__construct();
		
		$this->required_database = true;
		$this->required_fields = array('newsletter','optin');
		$this->table = 'customer';
		$this->className = 'Customer';
		$this->lang = false;
		$this->deleted = true;
		$this->explicitSelect = true;

		$this->context = Context::getContext();

		$this->default_form_language = $this->context->language->id;

		$genders = array();
		$genders_icon = array('default' => 'unknown.gif');
		foreach (Gender::getGenders() as $gender)
		{
			$gender_file = 'genders/'.$gender->id.'.jpg';
			if (file_exists(_PS_IMG_DIR_.$gender_file))
				$genders_icon[$gender->id] = '../'.$gender_file;
			else
				$genders_icon[$gender->id] = $gender->name;
			$genders[$gender->id] = $gender->name;
		}

		$this->_select = '
		a.date_add,
		IF (YEAR(`birthday`) = 0, "-", (YEAR(CURRENT_DATE)-YEAR(`birthday`)) - (RIGHT(CURRENT_DATE, 5) < RIGHT(birthday, 5))) AS `age`, (
			SELECT c.date_add FROM '._DB_PREFIX_.'guest g
			LEFT JOIN '._DB_PREFIX_.'connections c ON c.id_guest = g.id_guest
			WHERE g.id_customer = a.id_customer
			ORDER BY c.date_add DESC
			LIMIT 1
		) as connect, (SELECT rp.id_sponsor FROM '._DB_PREFIX_.'referralprogram rp WHERE
		rp.id_sponsor=a.id_customer and rp.id_customer!=0 group by  rp.id_sponsor) as godfather';
		$this->fields_list = array(
			'id_customer' => array(
				'title' => $this->l('ID'),
				'align' => 'center',
				'width' => 20
			),
			'id_gender' => array(
				'title' => $this->l('Titles'),
				'width' => 70,
				'align' => 'center',
				'icon' => $genders_icon,
				'orderby' => false,
				'type' => 'select',
				'list' => $genders,
				'filter_key' => 'a!id_gender',
			),
			'lastname' => array(
				'title' => $this->l('Last Name'),
				'width' => 'auto'
			),
			'firstname' => array(
				'title' => $this->l('First name'),
				'width' => 'auto'
			),
			'email' => array(
				'title' => $this->l('E-mail address'),
				'width' => 140,
			),
			'age' => array(
				'title' => $this->l('Age'),
				'width' => 20,
				'search' => false,
				'align' => 'center'
			),
			'active' => array(
				'title' => $this->l('Enabled'),
				'width' => 70,
				'align' => 'center',
				'active' => 'status',
				'type' => 'bool',
				'orderby' => false,
				'filter_key' => 'a!active',
			),
			'newsletter' => array(
				'title' => $this->l('News.'),
				'width' => 70,
				'align' => 'center',
				'type' => 'bool',
				'callback' => 'printNewsIcon',
				'orderby' => false
			),
			'godfather' => array(
				'title' => $this->l('Godfather'),
				'width' => 70,
				'align' => 'center',
				'type' => 'bool',
				'callback' => 'printOptinIcon',
				'orderby' => false
			),
			'date_add' => array(
				'title' => $this->l('Registration'),
				'width' => 150,
				'type' => 'date',
				'align' => 'right'
			),
			'connect' => array(
				'title' => $this->l('Last visit'),
				'width' => 100,
				'type' => 'datetime',
				'search' => false,
				'havingFilter' => true
			)
		);

	}
	
	public function initContent()
	{
		
		if($_GET['export']==true){
			echo 'oui';
		}
		
		if ($this->action == 'select_delete')
			$this->context->smarty->assign(array(
				'delete_form' => true,
				'url_delete' => htmlentities($_SERVER['REQUEST_URI']),
				'boxes' => $this->boxes,
			));

		if (!$this->can_add_customer && !$this->display)
			$this->informations[] = $this->l('You have to select a shop if you want to create a customer');

		parent::initContent();
	}
	
	public function initToolbar()
	{
		parent::initToolbar();
		if (!$this->can_add_customer)
			unset($this->toolbar_btn['new']);
		else if (!$this->display) //display import button only on listing
		{
			$this->toolbar_btn['import'] = array(
				'href' => $this->context->link->getAdminLink('AdminImport', true).'&import_type='.$this->table,
				'desc' => $this->l('Import')
			);
			$this->toolbar_btn['export'] = array(
				'href' => self::$currentIndex.'&amp;export=true&amp;token='.$this->token,
				'desc' => $this->l('Export')
			);
		}
	}

}

