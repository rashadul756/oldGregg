{**
 * plugins/generic/jatsParser/templates/articleMainText.tpl
 *
 * Copyright (c) 2017 Vitaliy Bezsheiko, MD, Department of Psychosomatic Medicine and Psychotherapy, Bogomolets National Medical University, Kyiv, Ukraine
 * Distributed under the GNU GPL v3.
 *
 * A base template for displaying parsed article's JATS XML
 *}

{* intra-article navigation *}

<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
    <p><strong></strong></p>
    <div style="float:left; color:#3173b0; font-family: 'Play', sans-serif;">
        <strong>
         {$section->getLocalizedTitle()|escape}
        </strong>
    </div>
    <strong></strong>
    <strong>
        <div style="float:right;">
            {if $primaryGalleys}
                {foreach from=$primaryGalleys item=galley}
                    {include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley purchaseFee=$currentJournal->getSetting('purchaseArticleFee') purchaseCurrency=$currentJournal->getSetting('currency')}
                {/foreach}
            {/if}
            {if $supplementaryGalleys}
                {foreach from=$supplementaryGalleys item=galley}
                    {include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley isSupplementary="1"}
                {/foreach}
            {/if}
        </div>
    </strong>
    <p></p>     
</div>

<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="overflow: hidden;">
    <h1 class="article_title" style="color: #5a5a5a; text-align:left;">
        <div class="article-slider" style="float:right;">
        <div id="contentv">
            <div class="A" id="none" data-panel_type="none">
                <p>HTML<br><i class="glyphicon glyphicon-eye-open"></i><br>{$article->getViews()}</p>
            </div>
            <div class="B" id="none" data-panel_type="none">
                <p>Total<br><i class="glyphicon glyphicon-download-alt"></i><br>
                670
                </p>
            </div>
            <div class="C" id="none" data-panel_type="none">
                <p><a href="https://scholar.google.co.in/scholar?q=Impact of Improved Cooking Stove on Maternal Health in Rural Bangladesh: A Quasi-Experimental Study" style="color:white;">Citations<br><br><i class="fa fa-quote-left" aria-hidden="true"></i></a></p>
            </div>
            <div class="D" id="none" data-panel_type="none">
            </div>
            <div class="E" id="none" data-panel_type="none">
            <a href="#review" style="color:white;" data-toggle="popover" data-trigger="hover" data-placement="bottom" data-content="*Open peer review for articles published after 8th Oct, 2017" data-content-style="black" data-original-title="" title="">Peer Review*</a>
            </div>
            </div>
        </div>
    
        {$article->getLocalizedTitle()|escape}
    </h1>
    {if $article->getLocalizedSubtitle()}
        <h2 class="subtitle text-muted">
            {$article->getLocalizedSubtitle()|escape}
        </h2>
    {/if}
    {if $article->getAuthors()}
        <ol class="item authors">
            {foreach from=$article->getAuthors() item=author key=i}
                <li class="author">
                        <span class="name">
                            <a class="author-link" data-container="body" data-toggle="popover" data-placement="top" data-content="{if $author->getLocalizedAffiliation()}{$author->getLocalizedAffiliation()|escape}{/if}">
                                {$author->getFullName()|escape}
                            </a>
                        </span>
                    <span class="comma">
                            {if $i < $article->getAuthors()|@count - 1},{/if}
                        </span>
                </li>
            {/foreach}
        </ol>
    {/if}
    
        <div class="article-dates">
            <p class="meta-item date-received">
                <span>{translate key="submissions.submitted"}:</span> {$article->getDateSubmitted()|date_format} ||
            
                <span>{translate key="submissions.published"}:</span> {$article->getDatePublished()|date_format} ||
            
        
            
                <span>{$issue->getIssueIdentification()}</span>
            </p>

            {foreach from=$pubIdPlugins item=pubIdPlugin}
                {if $pubIdPlugin->getPubIdType() != 'doi'}
                    {php}continue;{/php}
                {/if}
                {if $issue->getPublished()}
                    {assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
                {else}
                    {assign var=pubId value=$pubIdPlugin->getPubId($article)}{* Preview pubId *}
                {/if}
                {if $pubId}
                    {assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
                    <p class="meta-item doi"> {translate key="plugins.pubIds.doi.readerDisplayName"} <a href="{$doiUrl}">{$doiUrl|regex_replace:"/https:\/\/.*org\//":" "}</a></p>
                {/if}
            {/foreach} 
        </div>   
</div>

<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
<div id="pkp_content_main" style="float: left;" class="pkp_structure_main col-lg-9 col-md-9 col-sm-12 col-xs-12" role="main">
    <nav class="article-menu nav nav-tabs" id="myTab" role="tablist">
        <a class="nav-item nav-link" id="nav-article-tab" data-toggle="tab" href="#nav-article" role="tab"
               aria-controls="nav-article" aria-selected="true">
            <i class="fas fa-sticky-note fa-lg"></i>
            <span class="tab-title">
                {translate key="plugins.gregg.article"}
            </span>
        </a>
        
        <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-references" role="tab" aria-controls="nav-references" aria-selected="false">
            <i class="fas fa-quote-left fa-lg"></i>
            <span class="tab-title">
                {translate key="plugins.gregg.references"}
            </span>
        </a>
        
        <a class="nav-item nav-link" id="nav-details-tab" data-toggle="tab" href="#nav-details" role="tab" aria-controls="nav-details" aria-selected="false">
            <i class="fas fa-info-circle fa-lg"></i>
            <span class="tab-title">
                {translate key="plugins.gregg.details"}
            </span>
        </a>
        {*Add Statistics tab in right sided navigation in article detail page*}
        <a class="nav-item nav-link" id="usage-statistics" data-toggle="tab" href="#nav-statistics" role="tab"
           aria-controls="nav-statics" aria-selected="false">
            <i class="fas fa-chart-bar fa-lg"></i>
            <span class="tab-title">
                {translate key="plugins.gregg.statistics"}
            </span>
        </a>
    </nav>
    <div class="tab-content" id="nav-tabContent">
    <div class="tab-pane fade" id="nav-references" role="tabpanel" aria-labelledby="nav-references-tab">
        {* References *}
        {if $article->getCitations()}
            <div class="references">
                <div class="value">
                    {if $article->getCitations()}
                        {$article->getCitations()|nl2br}
                    {/if}
                </div>
            </div>
        {/if}
    </div>
    <div class="tab-pane fade" id="nav-download" role="tabpanel" aria-labelledby="nav-download-tab">
        {if $primaryGalleys}
            <div class="galleys">
                <ul class="galley-links">
                    {foreach from=$primaryGalleys item=galley}
                        <li class="galley-links-items">
                            {include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley purchaseFee=$currentJournal->getSetting('purchaseArticleFee') purchaseCurrency=$currentJournal->getSetting('currency')}
                        </li>
                    {/foreach}
                </ul>
            </div>
        {/if}
    </div>
    {*Adding Statistics info to the right sided navigation of article detail page*}
    <div class="tab-pane fade" id="nav-statistics" role="tabpanel" aria-labelledby="nav-details-tab">
        <ul class="article-views list-group">
            <li class="item-views list-group-item">
                <span>{translate key="article.abstract"} {translate key="plugins.gregg.viewed"}</span> - <b>{$article->getViews()}</b>
                {translate key="plugins.gregg.times"}
            </li>
            {if is_a($article, 'PublishedArticle')}{assign var=galleys value=$article->getGalleys()}{/if}
            {if $galleys}
                {foreach from=$galleys item=galley name=galleyList}
                    <li class="item-views list-group-item">
                        <span>{$galley->getGalleyLabel()} {translate key="plugins.gregg.downloaded"}</span> - <b>{$galley->getViews()}</b>
                        {translate key="plugins.gregg.times"}
                    </li>
                {/foreach} 
            {/if}
        </ul>
        
    </div>
    <div class="tab-pane fade" id="nav-details" role="tabpanel" aria-labelledby="nav-details-tab">
        {if $licenseUrl}
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">{translate key="submission.license"}</h3>
                </div>
                <div class="card-body">
                    <div class="item copyright">
                        {if $ccLicenseBadge}
                            {$ccLicenseBadge}
                        {else}
                            <a href="{$licenseUrl|escape}" class="copyright">
                                {translate key="submission.license"}
                            </a>
                        {/if}
                    </div>
                </div>
            </div>
        {/if}
        {if $copyright}
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">{translate key="plugins.gregg.copyright"}</h3>
            </div>
            <div class="card-body">
                <p class="card-text">&#169; {$article->getCopyrightHolder($article->getLocale())}, {$article->getCopyrightYear()}</p>
            </div>
        </div>
        {/if}


        <div class="card article-affiliations" id="article-affiliations">
            <div class="card-header article-html-views">
                <h3 class="card-title">{translate key="plugins.gregg.affiliations"}</h3>
            </div>
            <div class="card-body">
                {if $article->getAuthors()}
                    {foreach from=$article->getAuthors() item=author key=y}
                        <p class="card-text">
                            <i>{$author->getFullName()|escape}</i><br/>
                            {if $author->getLocalizedAffiliation()}{$author->getLocalizedAffiliation()|escape}{else}{translate key="plugins.gregg.no-affiliation"}{/if}
                        </p>
                    {/foreach}
                {/if}
            </div>
        </div>

        {* How to cite *}
        {if $citation}
            <div class="item citation card-group">
                <div class="sub_item citation_display card">
                    <div class="label card-header">
                        <h3 class="card-title">
                            {translate key="submission.howToCite"}
                        </h3>
                    </div>
                    <div class="value card-body">
                        <div id="citationOutput" role="region" aria-live="polite">
                            {$citation}
                        </div>
                        <div class="citation_formats dropdown">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                {translate key="submission.howToCite.citationFormats"}
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton" id="dropdown-cit">
                                {foreach from=$citationStyles item="citationStyle"}
                                    <a
                                            class="dropdown-cite-link dropdown-item"
                                            aria-controls="citationOutput"
                                            href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgs}"
                                            data-load-citation
                                            data-json-href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgsJson}"
                                    >
                                        {$citationStyle.title|escape}
                                    </a>
                                {/foreach}
                                {if count($citationDownloads)}
                                    <div class="dropdown-divider"></div>
                                    <h4 class="download-cite">
                                        {translate key="submission.howToCite.downloadCitation"}
                                    </h4>
                                    {foreach from=$citationDownloads item="citationDownload"}
                                        <a class="dropdown-item" href="{url page="citationstylelanguage" op="download" path=$citationDownload.id params=$citationArgs}">
                                            <span class="fa fa-download"></span>
                                            {$citationDownload.title|escape}
                                        </a>
                                    {/foreach}
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        {/if}
        {call_hook name="Templates::Article::Details"}
        {call_hook name="Templates::Article::Footer::PageFooter"}
    </div>
    <div class="tab-pane fade show active" id="nav-article" role="tabpanel" aria-labelledby="nav-article-tab">
    
        <div class="article-text">
        {** get abstract *}
        {if $article->getLocalizedAbstract()}
            {include file="frontend/parser/abstract.tpl"}
        {/if}
        {if !empty($keywords[$currentLocale])}
        <div class="item keywords">
            <span class="label">
                {capture assign=translatedKeywords}{translate key="article.subject"}{/capture}
                {translate key="semicolon" label=$translatedKeywords}
            </span>
            <span class="value">
                {foreach from=$keywords item=keyword}
                    {foreach name=keywords from=$keyword item=keywordItem}
                        {$keywordItem|escape}{if !$smarty.foreach.keywords.last}, {/if}
                    {/foreach}
                {/foreach}
            </span>
        </div>
        {/if}
        </div>
            
    </div>
</div>
   
</div>

<div style="float: right;" class="fornav col-lg-3 col-md-3" role="complementary" id="navwrap">
    <nav class="bs-docs-sidebar  affix" role="complementary" id="myAffix">
    <div class="item published">
    <div class="panel panel-default">
    <div class="panel-heading">
    <i class="glyphicon glyphicon-th-list"></i> Table of Contents
    </div>
    <div class="panel-body">
    <div class="tab-pane fade show active" id="nav-article" role="tabpanel" aria-labelledby="nav-article-tab">
                <nav id="navbar-article-links" class="nav nav-pills flex-column">
                    {if $article->getLocalizedAbstract()}
                        <a class="intranav nav-link" href="#sec-0">{translate key="article.abstract"}</a>
                    {/if}
                   
                </nav>
    </div>
    </div>
    <br>
    <br>
    </nav>
    
    
</div>
</div>
</div>
</div>
</div>
<div style="clear: both;"></div>



