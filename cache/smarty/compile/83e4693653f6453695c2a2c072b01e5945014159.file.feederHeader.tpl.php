<?php /* Smarty version Smarty-3.1.8, created on 2013-05-07 13:04:45
         compiled from "/Applications/XAMPP/xamppfiles/htdocs/project/lcdb/modules/feeder/feederHeader.tpl" */ ?>
<?php /*%%SmartyHeaderCode:6381513955188dfcd9dc964-61431940%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '83e4693653f6453695c2a2c072b01e5945014159' => 
    array (
      0 => '/Applications/XAMPP/xamppfiles/htdocs/project/lcdb/modules/feeder/feederHeader.tpl',
      1 => 1361836056,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '6381513955188dfcd9dc964-61431940',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'meta_title' => 0,
    'feedUrl' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.8',
  'unifunc' => 'content_5188dfcd9ff794_81726430',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5188dfcd9ff794_81726430')) {function content_5188dfcd9ff794_81726430($_smarty_tpl) {?><?php if (!is_callable('smarty_modifier_escape')) include '/Applications/XAMPP/xamppfiles/htdocs/project/lcdb/tools/smarty/plugins/modifier.escape.php';
?>

<link rel="alternate" type="application/rss+xml" title="<?php echo smarty_modifier_escape($_smarty_tpl->tpl_vars['meta_title']->value, 'html', 'UTF-8');?>
" href="<?php echo $_smarty_tpl->tpl_vars['feedUrl']->value;?>
" /><?php }} ?>