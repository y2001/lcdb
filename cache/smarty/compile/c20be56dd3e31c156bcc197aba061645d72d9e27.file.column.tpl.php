<?php /* Smarty version Smarty-3.1.8, created on 2013-05-07 13:04:47
         compiled from "/Applications/XAMPP/xamppfiles/htdocs/project/lcdb/modules/paypal/views/templates/hook/column.tpl" */ ?>
<?php /*%%SmartyHeaderCode:17007159255188dfcf033c73-12656447%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'c20be56dd3e31c156bcc197aba061645d72d9e27' => 
    array (
      0 => '/Applications/XAMPP/xamppfiles/htdocs/project/lcdb/modules/paypal/views/templates/hook/column.tpl',
      1 => 1367500679,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '17007159255188dfcf033c73-12656447',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'base_dir_ssl' => 0,
    'logo' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.8',
  'unifunc' => 'content_5188dfcf04fdf1_70795501',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5188dfcf04fdf1_70795501')) {function content_5188dfcf04fdf1_70795501($_smarty_tpl) {?>

<div id="paypal-column-block">
	<p><a href="<?php echo $_smarty_tpl->tpl_vars['base_dir_ssl']->value;?>
modules/paypal/about.php" rel="nofollow"><img src="<?php echo $_smarty_tpl->tpl_vars['logo']->value;?>
" alt="PayPal" title="<?php echo smartyTranslate(array('s'=>'Pay with PayPal','mod'=>'paypal'),$_smarty_tpl);?>
" style="max-width: 100%" /></a></p>
</div>
<?php }} ?>