{**
 * templates/frontend/pages/article.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko, MD
 * Distributed under the GNU GPL v3.
 *
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$article->getLocalizedTitle()|escape}

    {if $requestedPage|escape != "article"}
		{if $section}
			{include file="frontend/components/breadcrumbs_article.tpl" currentTitle=$section->getLocalizedTitle()}
		{else}
			{include file="frontend/components/breadcrumbs_article.tpl" currentTitleKey="article.article"}
		{/if}
	{/if}
	
	{* Show article overview articleOnlyAbstract*}
    {if $jatsDocument}
            {include file="frontend/parser/articleMainText.tpl"}
    {else}

            {include file="frontend/objects/articleOnlyAbstract.tpl"}

    {/if}
{include file="frontend/components/footer.tpl"}
<!-- .page -->

