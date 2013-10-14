
<div class="big-bloc">
	<a href="javascript:history.back();" title="Retourner aux produits">&lt; Retourner aux produits</a>
	
	{if isset($adminActionDisplay) && $adminActionDisplay}
	<div id="admin-action">
		<p>{l s='This product is not visible to your customers.'}
		<input type="hidden" id="admin-action-product-id" value="{$product->id}" />
		<input type="submit" value="{l s='Publish'}" class="exclusive" onclick="submitPublishProduct('{$base_dir}{$smarty.get.ad|escape:'htmlall':'UTF-8'}', 0, '{$smarty.get.adtoken|escape:'htmlall':'UTF-8'}')"/>
		<input type="submit" value="{l s='Back'}" class="exclusive" onclick="submitPublishProduct('{$base_dir}{$smarty.get.ad|escape:'htmlall':'UTF-8'}', 1, '{$smarty.get.adtoken|escape:'htmlall':'UTF-8'}')"/>
		</p>
		<p id="admin-action-result"></p>
		</p>
	</div>
	{/if}

	{if isset($confirmation) && $confirmation}
	<p class="confirmation">
		{$confirmation}
	</p>
	{/if}
	
	<div id="item" itemscope itemtype="http://schema.org/Product">
		<div class="clearfix">
			<div id="product-image">
				<img src="{$base_dir}themes/lcdb_theme/img/asset/img_solo/product_boeuf.png" alt="Pavé (Rumsteak ou tende de tranche)" />
			</div>
			<div id="main-product-infos">
				<h1 itemprop="name">{$product->name|escape:'htmlall':'UTF-8'}</h1>
				{if isset($product->description_short)}
					<div itemprop="description">{$product->description_short}</div>
				{/if}
				{if isset($product->description)}
					<div class="full-description">{$product->description}</div>
				{/if}
			</div>
		</div>
		<div class="clearfix price-info">

			{if isset($groups)}
				{foreach from=$groups key=id_attribute_group item=group}
					{if $group.attributes|@count}
						<div class="choix-race">
							<p>{$group.name|escape:'htmlall':'UTF-8'} :</p>
							{assign var="groupName" value="group_$id_attribute_group"}
							{if ($group.group_type == 'select')}
								<select name="{$groupName}" id="group_{$id_attribute_group|intval}" class="attribute_select meat-race" onchange="findCombination();getProductAttribute();">
									{foreach from=$group.attributes key=id_attribute item=group_attribute}
										<option value="{$id_attribute|intval}"{if (isset($smarty.get.$groupName) && $smarty.get.$groupName|intval == $id_attribute) || $group.default == $id_attribute} selected="selected"{/if} title="{$group_attribute|escape:'htmlall':'UTF-8'}">{$group_attribute|escape:'htmlall':'UTF-8'}</option>
									{/foreach}
								</select>
							{/if}
						</div>
					{/if}
				{/foreach}
			{/if}

			<div class="add-to-basket-form">
				<div class="clearfix">
					<div class="label">
						{foreach from=$features item=feature}
							{if $feature.id_feature == 11 && $feature.value == "Oui" }
								<img class="bio" src="{$base_dir}/themes/lcdb_theme/img/asset/img_solo/agriculture-biologique.jpg" alt="Agriculture biologique"/>
							{/if}
							{if $feature.id_feature == 12 && $feature.value == "Oui" }
								 <img class="bio" src="{$base_dir}/themes/lcdb_theme/img/asset/img_solo/product_labelrouge.png" alt="Label Rouge"/>
							{/if}
						{/foreach}
                    </div>
					<div class="detailed-price">
						<p class="price our_price_display" itemprop="price">
						{if $priceDisplay >= 0 && $priceDisplay <= 2}
							<span id="our_price_display">{convertPrice price=$productPrice}</span>
							<!--{if $tax_enabled  && ((isset($display_tax_label) && $display_tax_label == 1) OR !isset($display_tax_label))}
								{if $priceDisplay == 1}{l s='tax excl.'}{else}{l s='tax incl.'}{/if}
							{/if}-->
						{/if}
						</p>
						{if !empty($product->unity) && $product->unit_price_ratio > 0.000000}
							 {math equation="pprice / punit_price"  pprice=$productPrice  punit_price=$product->unit_price_ratio assign=unit_price}
							<p class="unit-price">{convertPrice price=$unit_price}/{$product->unity|escape:'htmlall':'UTF-8'}</p>
						{/if}
					</div>
				</div>
				<div>
					<form class="form-panier clearfix" action="{$link->getPageLink('cart')}" method="post">
						<button type="button" name="minus" class="moreless minus">-</button>
						<input class="quantity" type="text" maxlength="2" value="{if isset($quantityBackup)}{$quantityBackup|intval}{else}{if $product->minimal_quantity > 1}{$product->minimal_quantity}{else}1{/if}{/if}" id="quantity_wanted" name="qty" disabled {if $product->minimal_quantity > 1}onkeyup="checkMinimalQuantity({$product->minimal_quantity});"{/if} />
						<button type="button" name="plus" class="moreless plus">+</button>
						<button type="submit" name="submit" class="ajout-panier green-button gradient">ajouter au panier</button>

						<!-- hidden datas -->
						<p class="hidden">
							<input type="hidden" name="token" value="{$static_token}" />
							<input type="hidden" name="id_product" value="{$product->id|intval}" id="product_page_product_id" />
							<input type="hidden" name="add" value="1" />
							<input type="hidden" name="id_product_attribute" id="idCombination" value="" />
						</p>

						<!-- availability -->
						<!-- <p id="availability_statut"{if ($product->quantity <= 0 && !$product->available_later && $allow_oosp) OR ($product->quantity > 0 && !$product->available_now) OR !$product->available_for_order OR $PS_CATALOG_MODE} style="display: none;"{/if}>
							<span id="availability_label">{l s='Availability:'}</span>
							<span id="availability_value"{if $product->quantity <= 0} class="warning_inline"{/if}>
							{if $product->quantity <= 0}{if $allow_oosp}{$product->available_later}{else}{l s='This product is no longer in stock'}{/if}{else}{$product->available_now}{/if}
							</span>
						</p> -->

						<p class="warning_inline" id="last_quantities"{if ($product->quantity > $last_qties OR $product->quantity <= 0) OR $allow_oosp OR !$product->available_for_order OR $PS_CATALOG_MODE} style="display: none"{/if} >{l s='Warning: Last items in stock!'}</p>

						{if $product->show_price AND !isset($restricted_country_mode) AND !$PS_CATALOG_MODE}

							{if !$priceDisplay || $priceDisplay == 2}
								{assign var='productPrice' value=$product->getPrice(true, $smarty.const.NULL, $priceDisplayPrecision)}
								{assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(false, $smarty.const.NULL)}
							{elseif $priceDisplay == 1}
								{assign var='productPrice' value=$product->getPrice(false, $smarty.const.NULL, $priceDisplayPrecision)}
								{assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(true, $smarty.const.NULL)}
							{/if}

							

							{if $priceDisplay == 2}
								<br />
								<span id="pretaxe_price"><span id="pretaxe_price_display">{convertPrice price=$product->getPrice(false, $smarty.const.NULL)}</span>&nbsp;{l s='tax excl.'}</span>
							{/if}

						<p id="reduction_percent" {if !$product->specificPrice OR $product->specificPrice.reduction_type != 'percentage'} style="display:none;"{/if}><span id="reduction_percent_display">{if $product->specificPrice AND $product->specificPrice.reduction_type == 'percentage'}-{$product->specificPrice.reduction*100}%{/if}</span></p>

						<p id="reduction_amount" {if !$product->specificPrice OR $product->specificPrice.reduction_type != 'amount' && $product->specificPrice.reduction|intval ==0} style="display:none"{/if}><span id="reduction_amount_display">{if $product->specificPrice AND $product->specificPrice.reduction_type == 'amount' && $product->specificPrice.reduction|intval !=0}-{convertPrice price=$product->specificPrice.reduction|floatval}{/if}</span></p>

						{if $product->specificPrice AND $product->specificPrice.reduction}
							<p id="old_price"><span class="bold">
							{if $priceDisplay >= 0 && $priceDisplay <= 2}
								{if $productPriceWithoutReduction > $productPrice}
									<span id="old_price_display">{convertPrice price=$productPriceWithoutReduction}</span>
									<!-- {if $tax_enabled && $display_tax_label == 1}
										{if $priceDisplay == 1}{l s='tax excl.'}{else}{l s='tax incl.'}{/if}
									{/if} -->
								{/if}
							{/if}
							</span>
							</p>
						{/if}

						{if $packItems|@count && $productPrice < $product->getNoPackPrice()}
							<p class="pack_price">{l s='instead of'} <span style="text-decoration: line-through;">{convertPrice price=$product->getNoPackPrice()}</span></p>
							<br class="clear" />
						{/if}

						{if $product->ecotax != 0}
							<p class="price-ecotax">{l s='include'} <span id="ecotax_price_display">{if $priceDisplay == 2}{$ecotax_tax_exc|convertAndFormatPrice}{else}{$ecotax_tax_inc|convertAndFormatPrice}{/if}</span> {l s='for green tax'}
								{if $product->specificPrice AND $product->specificPrice.reduction}
								<br />{l s='(not impacted by the discount)'}
								{/if}
							</p>
						{/if}

						{/if}

						{if isset($HOOK_PRODUCT_ACTIONS) && $HOOK_PRODUCT_ACTIONS}{$HOOK_PRODUCT_ACTIONS}{/if}

						{if isset($HOOK_PRODUCT_FOOTER) && $HOOK_PRODUCT_FOOTER}{$HOOK_PRODUCT_FOOTER}{/if}

					</form>

				</div>
			</div><!-- / .add-to-basket-form -->
		</div>
		
		<hr />
		<div class="misc-infos clearfix">
			{foreach from=$features item=feature}
				{if $feature.id_feature == 7 }
					<p class="portions"><span class="img-portions"></span> {$feature.value} <span class="colis-portions">portions</span></p>
				{/if}
				{if $feature.id_feature == 8 }
					<p class="jours"><span class="img-jours"></span> {$feature.value} <span class="colis-jours">jours</span></p>
				{/if}
				{if $feature.id_feature == 10 }
					<p class="cuisson"><span class="img-cuisson"></span> <span class="mode-cuisson">{$feature.value}</span></p>
				{/if}
			{/foreach}
		</div>
		
		{if isset($product->tricks) && ($product->tricks != null)}
			<hr />
			<div id="trucs-et-astuces">
				<h2><span class="img-trucs-astuces"></span>Trucs et astuces des Colis du Boucher</h2>
				<div>{$product->tricks}</div>
			</div>
		{/if}
		
		{if isset($product->breeder) && ($product->breeder != null)}
			<hr />
			<div id="mot-eleveur">
				<h2><span class="img-mot-eleveur"></span>Le mot de l'éleveur</h2>
				<div>{$product->breeder}</div>
			</div>
		{/if}

		{if isset($recipes) && ($recipes != null)}
			<hr />
			<div id="idees-recettes">
				<h2><span class="img-idees-recettes"></span>Idées recettes</h2>
				<ul>
					{foreach from=$recipes item=recipe}
						<li itemscope itemtype="http://schema.org/Recipe">
							<a href="#" title="voir la recette" class="recipe-link">voir la recette</a>
							<h3 itemprop="name">{$recipe.title}</h3>
							<p class="clearfix"><span class="intitule">difficulté</span> <span class="difficulte_level difficulte_{$recipe.difficulty}">{$recipe.difficulty}/5</span></p>
							<div class="recipe-details hidden">
								<h4>Ingrédients :</h4>
								<div class="ingredients clearfix">
									{$recipe.ingredients_content}
								</div>
								<h4>Recette :</h4>
								<div class="recette">
									{$recipe.recipe_content}
								</div>
							</div>
							<hr class="dashed" />
						</li>
					{/foreach}
				</ul>
			</div>
		{/if}
		
	</div>
</div>

