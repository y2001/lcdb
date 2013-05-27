<div class="content clearfix">
	{$HOOK_HOME}
	<div class="content-infos-site">
		<div class="infos-measure">
			<h2>Notre démarche</h2>
			<span class="illustration"></span>
			<ul>
				<li class="eleveurs">Nos éleveurs <span class="color">en Auvergne</span><span class="illustration"></span></li>
				<li class="commande"><span class="illustration"></span>Votre <span class="color">commande</span></li>
				<li class="livraison">Votre <span class="color">livraison</span><span class="illustration"></span></li>
			</ul>
			<div class="clearfix"></div>
			<a href="{$link->getCMSLink(13)}" title="En savoir plus sur notre démarche">
				&rarr;<span> En savoir plus sur notre démarche</span>
			</a>
		</div>
		<div class="entries-and-blog">
			<div class="entries">
				<h2>Livre d'or</h2>
				{foreach from=$messages item=content}
					<p><span>&laquo;</span>{$content.message}<span>&raquo;</span></p>
					<p class="signature">{$content.firstname} {$content.lastname}, {$content.city}</p>
					{break}
				{/foreach}
				<a href="{$link->getPageLink('guestbook')}" title="Voir tous les commentaires">
					&rarr;<span> Voir tous les commentaires</span>
				</a>
				<a href="{$link->getPageLink('guestbook')}#button-witness" title="Laisser un commentaire">
					&rarr;<span> Laisser un commentaire</span>
				</a>
			</div>
			<div class="blog">
				<h2>En direct du blog</h2>
				<article>
					<a href="#" title="Accéder au blog">
						<img src="{$base_dir}themes/lcdb_theme/img/photos/vache.jpg" alt="une vache dans un près" />
					</a>
					<div class="subject">
						<h3>
							<a href="#" title="Accéder au blog">
								Une vache dans le près
							</a>
						</h3>
						<p>
							<a href="#" title="Accéder au blog">
								Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum quam mi. 
								Vestibulum quam mi.
							</a>
						</p>
					</div>
				</article>
				<a href="#" title="Accéder au blog">&rarr;<span> Accéder au blog</span></a>
			</div>	
		</div>
	</div>
</div>