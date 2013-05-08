
{assign var="back_order_page" value="order.php"}

{* Will be deleted for 1.5 version and more *}
{if !isset($formatedAddressFieldsValuesList)}
	{$ignoreList.0 = "id_address"}
	{$ignoreList.1 = "id_country"}
	{$ignoreList.2 = "id_state"}
	{$ignoreList.3 = "id_customer"}
	{$ignoreList.4 = "id_manufacturer"}
	{$ignoreList.5 = "id_supplier"}
	{$ignoreList.6 = "date_add"}
	{$ignoreList.7 = "date_upd"}
	{$ignoreList.8 = "active"}
	{$ignoreList.9 = "deleted"}

	{* PrestaShop 1.4.0.17 compatibility *}
	{if isset($addresses)}
		{foreach from=$addresses key=k item=address}
			{counter start=0 skip=1 assign=address_key_number}
			{$id_address = $address.id_address}
			{foreach from=$address key=address_key item=address_content}
				{if !in_array($address_key, $ignoreList)}
					{$formatedAddressFieldsValuesList.$id_address.ordered_fields.$address_key_number = $address_key}
					{$formatedAddressFieldsValuesList.$id_address.formated_fields_values.$address_key = $address_content}
					{counter}
				{/if}
			{/foreach}
		{/foreach}
	{/if}
{/if}

<script type="text/javascript">
// <![CDATA[
	{if !$opc}
	var orderProcess = 'order';
	var currencySign = '{$currencySign|html_entity_decode:2:"UTF-8"}';
	var currencyRate = '{$currencyRate|floatval}';
	var currencyFormat = '{$currencyFormat|intval}';
	var currencyBlank = '{$currencyBlank|intval}';
	var txtProduct = "{l s='product' js=1}";
	var txtProducts = "{l s='products' js=1}";
	{/if}

	var addressMultishippingUrl = "{$link->getPageLink('address', true, NULL, "back={$back_order_page}?step=1{'&multi-shipping=1'|urlencode}{if $back}&mod={$back|urlencode}{/if}")}";
	var addressUrl = "{$link->getPageLink('address', true, NULL, "back={$back_order_page}?step=1{if $back}&mod={$back}{/if}")}";

	var formatedAddressFieldsValuesList = new Array();

	{foreach from=$formatedAddressFieldsValuesList key=id_address item=type}
		formatedAddressFieldsValuesList[{$id_address}] =
		{ldelim}
			'ordered_fields':[
				{foreach from=$type.ordered_fields key=num_field item=field_name name=inv_loop}
					{if !$smarty.foreach.inv_loop.first},{/if}"{$field_name}"
				{/foreach}
			],
			'formated_fields_values':{ldelim}
					{foreach from=$type.formated_fields_values key=pattern_name item=field_name name=inv_loop}
						{if !$smarty.foreach.inv_loop.first},{/if}"{$pattern_name}":"{$field_name}"
					{/foreach}
				{rdelim}
		{rdelim}
	{/foreach}

	function getAddressesTitles()
	{
		return {
						'invoice': "{l s='Your billing address' js=1}",
						'delivery': "{l s='Your delivery address' js=1}"
			};

	}


	function buildAddressBlock(id_address, address_type, dest_comp)
	{
		var adr_titles_vals = getAddressesTitles();
		var li_content = formatedAddressFieldsValuesList[id_address]['formated_fields_values'];
		var ordered_fields_name = ['title'];

		ordered_fields_name = ordered_fields_name.concat(formatedAddressFieldsValuesList[id_address]['ordered_fields']);
		ordered_fields_name = ordered_fields_name.concat(['update']);

		dest_comp.html('');

		li_content['title'] = adr_titles_vals[address_type];
		li_content['update'] = '<a href="{$link->getPageLink('address', true, NULL, "id_address")}'+id_address+'&amp;back={$back_order_page}?step=1{if $back}&mod={$back}{/if}" title="{l s='Update' js=1}">&raquo; {l s='Update' js=1}</a>';

		appendAddressList(dest_comp, li_content, ordered_fields_name);
	}

	function appendAddressList(dest_comp, values, fields_name)
	{
		for (var item in fields_name)
		{
			var name = fields_name[item];
			var value = getFieldValue(name, values);
			if (value != "")
			{
				var new_li = document.createElement('li');
				new_li.className = 'address_'+ name;
				new_li.innerHTML = getFieldValue(name, values);
				dest_comp.append(new_li);
			}
		}
	}

	function getFieldValue(field_name, values)
	{
		var reg=new RegExp("[ ]+", "g");

		var items = field_name.split(reg);
		var vals = new Array();

		for (var field_item in items)
		{
			items[field_item] = items[field_item].replace(",", "");
			vals.push(values[items[field_item]]);
		}
		return vals.join(" ");
	}

//]]>
</script>

{capture name=path}{l s='Addresses'}{/capture}
{assign var='current_step' value='address'}

<div id="columns" class="content clearfix">
	<div class="bloc-checkout">
		{include file="./order-steps.tpl"}
		{include file="$tpl_dir./errors.tpl"}
		<form action="{$link->getPageLink($back_order_page, true)}" method="post">
			
			<div id="content-wrapper" class="clearfix">
				<div class="bloc content-address-invoice">
					<h2>Adresse de facturation</h2>
					<select>
						<option>Adresse Principale</option>
						<option>Adresse Secondaire</option>
					</select>
					<ul id="saved-address-invoice">
						<li>Pierre DURAN</li>
						<li>3, rue du chêne</li>
						<li>BAT A, appt 23, code : 4738</li>
						<li>75003</li>
						<li>Paris</li>
						<li>0616186327</li>
					</ul>
					<div id="form-address-invoice" class="hidden">
						<label for="nom-invoice">Nom</label>
						<input type="text" id="nom-invoice" value="DURAND"/>
						<label for="prenom-invoice">Prénom</label>
						<input type="text" id="prenom-invoice" value="Pierre"/>
						<label for="adresse-1-invoice">Adresse</label>
						<input type="text" id="adresse-1-invoice" value="3, rue du chêne"/>
						<label for="adresse-2-invoice">Adresse compl&eacute;mentaire</label>
						<input type="text" id="adresse-2-invoice" value="BAT A, appt 23, code : 4738"/>
						<label for="code-postal-invoice">Code Postal</label>
						<input type="text" id="code-postal-invoice" value="75003"/>
						<label for="ville-invoice">Ville</label>
						<input type="text" id="ville-invoice" value="Paris"/>
						<label for="telephone-invoice">T&eacute;l&eacute;phone</label>
						<input type="text" id="telephone-invoice" value="0616186327"/>
						<input type="submit" class="red-button gradient" value="ENREGISTRER" id="adress-submit-invoice" />
					</div>
					<a href="#" title="annuler" id="cancel-address-invoice" class="hidden">Annuler</a>
					<a href="#" title="modifier votre adresse de livraison" id="modify-address-invoice">&rarr;&nbsp;<span>Modifier cette adresse</span></a>
				</div>
				<div class="bloc content-address-delivery">
					<h2>Adresse de livraison</h2>
					<div id="delivery-address">
						<select>
							<option>Adresse Principale</option>
							<option>Adresse Secondaire</option>
						</select>
						<ul id="saved-address-delivery">
							<li>Pierre DURAN</li>
							<li>3, rue du chêne</li>
							<li>BAT A, appt 23, code : 4738</li>
							<li><span class="postal-code">75003</span></li>
							<li>Paris</li>
							<li>0616186327</li>
						</ul>
						<div id="form-address-delivery" class="hidden">
							<label for="nom">Nom</label>
							<input type="text" id="nom" value="DURAND"/>
							<label for="prenom">Prénom</label>
							<input type="text" id="prenom" value="Pierre"/>
							<label for="adresse-1">Adresse</label>
							<input type="text" id="adresse-1" value="3, rue du chêne"/>
							<label for="adresse-2">Adresse compl&eacute;mentaire</label>
							<input type="text" id="adresse-2" value="BAT A, appt 23, code : 4738"/>
							<label for="code-postal">Code Postal</label>
							<input type="text" id="code-postal" value="75003"/>
							<label for="ville">Ville</label>
							<input type="text" id="ville" value="Paris"/>
							<label for="telephone">T&eacute;l&eacute;phone</label>
							<input type="text" id="telephone" value="0616186327"/>
							<input type="submit" class="red-button gradient" value="ENREGISTRER" id="address-submit-delivery" />
						</div>
						<div id="form-add-address-delivery" class="hidden">
							<label for="new-title">Libellé de l'adresse</label>
							<input type="text" id="new-title" value="" />
							<label for="new-company">Raison sociale (optionnel)</label>
							<input type="text" id="new-company"/>
							<label for="new-address-1">Adresse</label>
							<input type="text" id="new-address-1"/>
							<label for="new-address-2">Adresse compl&eacute;mentaire</label>
							<input type="text" id="new-address-2"/>
							<label for="new-code-postal">Code Postal</label>
							<input type="text" id="new-code-postal"/>
							<label for="new-ville">Ville</label>
							<input type="text" id="new-ville"/>
							<label for="new-telephone">T&eacute;l&eacute;phone</label>
							<input type="text" id="new-telephone"/>
							<input type="submit" class="red-button gradient" value="ENREGISTRER" id="add-address-submit-delivery" />
						</div>
						<div><a href="#" title="annuler" id="cancel-address-delivery" class="hidden">Annuler</a></div>
						<div><a href="#" title="modifier votre adresse de livraison" id="modify-address-delivery">&rarr;&nbsp;<span>Modifier cette adresse</span></a></div>
						<div><a href="{$link->getPageLink('address', true, NULL, "back={$back_order_page}?step=1{if $back}&mod={$back}{/if}")}" title="ajouter une nouvelle adresse" id="add-address-delivery">&rarr;&nbsp;<span>Ajouter une nouvelle adresse</span></a></div>
					</div>
					<div id="delivery-relay" class="hidden">
						<p>Adresse Point Relais</p>
						<ul id="saved-address-relay">
							<li>Bio Prestige</li>
							<li>3, rue du chêne</li>
							<li><span class="postal-code">75003</span> Paris</li>
						</ul>
						<div><a href="#" title="afficher la carte des points relais" id="show-map">&rarr;&nbsp;<span>afficher la carte des points relais</span></a></div>
						<div id="relays">
							<div class="popin">
								<a href="#" title="Fermer" class="popin-close"></a>
								<p>Choisissez votre point relais</p>
								<div class="clearfix">
									<div id="left-side">
										<ul id="relay-list">
										</ul>
									</div>
									<div id="right-side">
										<div id="map"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="bloc content-delivery-mode">
					<h2>Modes de livraison</h2>
					<ul>
						<li>
							<p>
								<label class="radio" for="home-office"><input type="radio" name="delivery" id="home-office" checked/><span class="bold">Livraison à domicile ou au bureau</span> Livraison offerte</label>
							</p>
							<p class="description">En choisissant ce mode de livraison, vous pourrez nous indiquer à la prochaine étape le créneau horaire durant lequel vous souhaitez être livré.</p>
						</li>
						<li>
							<p>
								<label class="radio" for="relay"><input type="radio" name="delivery" id="relay" /><span class="bold">Livraison en point relais</span> Livraison offerte</label>
							</p>
							<p class="description">Avec la livraison en Point Relais vous avez l'avantage de disposer d'horaires beaucoup plus souples. Vous récupérez votre Colis quand cela vous arrange dans la journée, chez l'un de vos commerçants de proximité (presse, fleuriste, pressing...) du réseau Point Relais des Colis du Boucher.</p>
						</li>
					</ul>
					<hr class="dashed" />
					<div id="colis-cadeau-wrapper">
						<label for="colis-cadeau" id="colis-cadeau-toggle" class="checkbox"><input type="checkbox" id="colis-cadeau"/> Je souhaite que ma commande soit envoyée par <a href="#">colis cadeau</a> <span class="price">+ 1,60 &euro;</span></label>
						<textarea placeholder="Saisissez le message qui sera joint au cadeau" id="colis-cadeau-message" class="hidden" disabled="disabled"></textarea>
					</div>
					<hr class="dashed" />
					<p id="total-price">Le montant TTC de votre commande est de <span class="price"><span id="final-price">64,20</span> &euro;</span></p>
					<input type="hidden" class="hidden" name="step" value="2" />
					<input type="hidden" name="back" value="{$back}" />
					<input type="submit" value="valider" id="submit-address" class="disabled-button gradient" disabled />
				</div>
			</div>
			<div>
				<a href="#" title="Continuer mes achats">&rarr;&nbsp;<span>Continuer mes achats</span></a>
			</div>
			
			<div class="addresses clearfix">
				<p class="address_delivery select">
					<label for="id_address_delivery">{if $cart->isVirtualCart()}{l s='Choose a billing address:'}{else}{l s='Choose a delivery address:'}{/if}</label>
					<select name="id_address_delivery" id="id_address_delivery" class="address_select" onchange="updateAddressesDisplay();{if $opc}updateAddressSelection();{/if}">

					{foreach from=$addresses key=k item=address}
						<option value="{$address.id_address|intval}" {if $address.id_address == $cart->id_address_delivery}selected="selected"{/if}>{$address.alias|escape:'htmlall':'UTF-8'}</option>
					{/foreach}

					</select>
				</p>
				<p class="checkbox addressesAreEquals" {if $cart->isVirtualCart()}style="display:none;"{/if}>
					<input type="checkbox" name="same" id="addressesAreEquals" value="1" onclick="updateAddressesDisplay();{if $opc}updateAddressSelection();{/if}" {if $cart->id_address_invoice == $cart->id_address_delivery || $addresses|@count == 1}checked="checked"{/if} />
					<label for="addressesAreEquals">{l s='Use the delivery address as the billing address.'}</label>
				</p>

				<p id="address_invoice_form" class="select" {if $cart->id_address_invoice == $cart->id_address_delivery}style="display: none;"{/if}>

				{if $addresses|@count > 1}
					<label for="id_address_invoice" class="strong">{l s='Choose a billing address:'}</label>
					<select name="id_address_invoice" id="id_address_invoice" class="address_select" onchange="updateAddressesDisplay();{if $opc}updateAddressSelection();{/if}">
					{section loop=$addresses step=-1 name=address}
						<option value="{$addresses[address].id_address|intval}" {if $addresses[address].id_address == $cart->id_address_invoice && $cart->id_address_delivery != $cart->id_address_invoice}selected="selected"{/if}>{$addresses[address].alias|escape:'htmlall':'UTF-8'}</option>
					{/section}
					</select>
					{else}
						<a style="margin-left: 221px;" href="{$link->getPageLink('address', true, NULL, "back={$back_order_page}?step=1&select_address=1{if $back}&mod={$back}{/if}")}" title="{l s='Add'}" class="button_large">{l s='Add a new address'}</a>
					{/if}
				</p>
				<div class="clearfix">
					<ul class="address item" id="address_delivery" {if $cart->isVirtualCart()}style="display:none;"{/if}>
					</ul>
					<ul class="address alternate_item {if $cart->isVirtualCart()}full_width{/if}" id="address_invoice">
					</ul>
				</div>
			</div>
			<input type="submit" value="etape suivante" />
		</form>
	</div>
</div>