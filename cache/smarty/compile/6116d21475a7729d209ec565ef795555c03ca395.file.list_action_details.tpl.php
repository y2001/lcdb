<?php /* Smarty version Smarty-3.1.8, created on 2013-05-07 12:50:31
         compiled from "/Applications/XAMPP/xamppfiles/htdocs/project/lcdb/administration/themes/default/template/helpers/list/list_action_details.tpl" */ ?>
<?php /*%%SmartyHeaderCode:18402748255188dc77b2f201-83077837%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '6116d21475a7729d209ec565ef795555c03ca395' => 
    array (
      0 => '/Applications/XAMPP/xamppfiles/htdocs/project/lcdb/administration/themes/default/template/helpers/list/list_action_details.tpl',
      1 => 1361836056,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '18402748255188dc77b2f201-83077837',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'params' => 0,
    'id' => 0,
    'action' => 0,
    'controller' => 0,
    'token' => 0,
    'json_params' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.8',
  'unifunc' => 'content_5188dc77b827e3_98529411',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5188dc77b827e3_98529411')) {function content_5188dc77b827e3_98529411($_smarty_tpl) {?>

<a class="pointer" id="details_<?php echo $_smarty_tpl->tpl_vars['params']->value['action'];?>
_<?php echo $_smarty_tpl->tpl_vars['id']->value;?>
" title="<?php echo $_smarty_tpl->tpl_vars['action']->value;?>
" onclick="display_action_details('<?php echo $_smarty_tpl->tpl_vars['id']->value;?>
', '<?php echo $_smarty_tpl->tpl_vars['controller']->value;?>
', '<?php echo $_smarty_tpl->tpl_vars['token']->value;?>
', '<?php echo $_smarty_tpl->tpl_vars['params']->value['action'];?>
', <?php echo htmlspecialchars($_smarty_tpl->tpl_vars['json_params']->value, ENT_QUOTES, 'UTF-8');?>
); return false">
	<img src="../img/admin/more.png" alt="<?php echo $_smarty_tpl->tpl_vars['action']->value;?>
" />
</a>
<?php }} ?>