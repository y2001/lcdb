
<div class="big-bloc colis colis-surprise" itemscope itemtype="http://schema.org/Product">
	<div class="content-title">
		<h1 itemprop="name">{$product->name}</h1>
		{if $product->breeder != null}	
			<p>{$product->breeder}</p>
		{/if}
	</div>
	
	{if isset($confirmation) && $confirmation}
		<p class="confirmation">{$confirmation}</p>
	{/if}
	
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
	
	<div class="price-infos clearfix" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
		<img src="{$base_dir}themes/lcdb_theme/img/asset/img_solo/colis-surprise.png" title="colis surprise"/>
		
		{if $product->description_short != null}	
			<p class="colis-surprise-description">{$product->description_short}</p>
		{/if}
		<div class="price-details">
			
			{if !$priceDisplay || $priceDisplay == 2}
				{assign var='productPrice' value=$product->getPrice(true, $smarty.const.NULL, $priceDisplayPrecision)}
				{assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(false, $smarty.const.NULL)}
			{elseif $priceDisplay == 1}
				{assign var='productPrice' value=$product->getPrice(false, $smarty.const.NULL, $priceDisplayPrecision)}
				{assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(true, $smarty.const.NULL)}
			{/if}
			
			<div class="detailed-price">
				{if $priceDisplay >= 0 && $priceDisplay <= 2}
					<span class="price" itemprop="price" id="our_price_display">{convertPrice price=$productPrice}</span>
				{/if}
			</div>
		</div>
		
	</div><!-- / .price-infos -->

	<div class="add-to-basket-form">
		<form class="form-panier clearfix" action="{$link->getPageLink('cart')}" method="post">
			<!-- hidden -->
			<input type="hidden" name="token" value="{$static_token}" />
			<input type="hidden" name="id_product" value="{$product->id|intval}" id="product_page_product_id" />
			<input type="hidden" name="add" value="1" />
			<input type="hidden" name="id_product_attribute" id="idCombination" value="" />
			<!-- select -->
			<select>
				<option>Label Rouge et Bio</option>
			</select>
			<button type="button" name="minus" class="moreless minus">-</button>
			<input  id="quantity_wanted" class="quantity" type="text" maxlength="2" value="0" name="quantity" disabled>
			<button type="button" name="plus" class="moreless plus">+</button>
			<!-- button -->
			<button type="submit" name="submit" class="ajout-panier green-button gradient">ajouter au panier</button>
		</form>
	</div><!-- / .add-to-basket-form -->
	
	{if isset($HOOK_PRODUCT_ACTIONS) && $HOOK_PRODUCT_ACTIONS}{$HOOK_PRODUCT_ACTIONS}{/if}
	
	<div class="misc-infos clearfix">
		<p class="portions"><span class="img-portions"></span> 10 à 12 <span class="colis-portions">portions</span></p>
		<p class="jours"><span class="img-jours"></span> 7 à 14 <span class="colis-jours">jours</span></p>
	</div>
	<hr />
	{if $product->description != null}	
		<div class="colis-description">{$product->description}</div>
	{/if}
	<hr />
	<div class="colis-exemples">
		<p class="green-title">Quelques exemples de colis surprise</p>
		<ul>
			<li>Côte de Bœuf (Label Rouge - 1,2 kg) et Brochettes de Porc (Bio-1 kg)<hr/></li>
			<li>Côte de Bœuf (Label Rouge - 1,2 kg) et Brochettes de Porc (Bio-1 kg)<hr/></li>
			<li>Côte de Bœuf (Label Rouge - 1,2 kg) et Brochettes de Porc (Bio-1 kg)</li>
		</ul>
	</div>
	<hr />
	<p class="surprise-additional">Chaque semaine, une nouvelle surprise vous attends dans votre colis</p>
</div><!-- / .colis -->


	<pre>
		{$product|print_r}
	</pre>
	