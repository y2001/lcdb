		<div class="big-bloc">
			<div class="title_list_product">
				<span class="big_image" id="big_boeuf"></span>
				<h1>
					{strip}
						{$category->name|escape:'htmlall':'UTF-8'}
						{if isset($categoryNameComplement)}
							{$categoryNameComplement|escape:'htmlall':'UTF-8'}
						{/if}
					{/strip}
				</h1>
				{include file="$tpl_dir./errors.tpl"}
				{if isset($category->description)}
					<p>{$category->description}</p>
				{/if}
			</div>
			<div class="block-sort">
				{include file="./product-sort.tpl"}
			</div>
			
			<div class="list-product">
				{if isset($subcategories)}
					{foreach $subcategories as $subcat}
						<div class="grill category">
							<div class="category-title">
								<span id="{$subcat.name|lower|substr:3}"></span>
								<h2>Les viandes de Boeuf {$subcat.name}</h2>
							</div>
							{if $subcat.products}
								{include file="./product-list.tpl" products=$subcat.products}
							{/if}
						</div>
					{/foreach}
				{/if}
				<div class="more-product">
					<p class="blod">Vous chercher un produit particulier que nous ne proposons pas ?</p>
					<p>
						<a href="{$link->getPageLink('contact', true)}" title="Contactez-nous !">Contactez-nous !</a>
						Nos éleveurs ont sûrement ce dont vous avez besoin.
					</p>
				</div>
				
			</div>
		</div>