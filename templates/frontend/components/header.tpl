{**
 * lib/pkp/templates/frontend/components/header.tpl
 *
 * Copyright (c) 2018 Vitaliy Bezsheiko
 * Distributed under the GNU GPL v3.
 *
 *}

<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key=$pageTitle}{/capture}{/if}
{include file="frontend/components/headerHead.tpl"}
{if $requestedPage|escape == "article"}
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}">
{else}
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}">
{/if}

{* Primary site navigation *}
{capture assign="homeUrl"}
    {if $currentJournal && $multipleContexts}
        {url page="index" router=$smarty.const.ROUTE_PAGE}
    {else}
        {url context="index" router=$smarty.const.ROUTE_PAGE}
    {/if}
{/capture}
<header class="site-header">
    {* site brand *}
    <!-- rasel edit
    <nav class="user-nav">

        {load_menu name="user" id="navigationUser" ulClass="pkp_navigation_user" liClass="profile"}
    </nav>
-->
    <div class="container-fluid" style="background: #227E85;padding: 40px;">
        <div class="row">
            <div class="col-sm-1">
                {if ($displayPageHeaderLogo || is_array($displayPageHeaderTitle))}
                    <div class="journal-logo" class="img-thumbnail">
                        {if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
                            <a href="{$homeUrl}" class="is_img journal-name navbar-brand">
                                <img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}"
                                     width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}"
                                     {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"
                                     {else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
                            </a>
                        {elseif $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
                            <a href="{$homeUrl}" class="is_text journal-name navbar-brand">{$displayPageHeaderTitle}</a>
                        {elseif $displayPageHeaderTitle && !$displayPageHeaderLogo && is_array($displayPageHeaderTitle)}
                            <a href="{$homeUrl}" class="is_img journal-name navbar-brand">
                                <img src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}"
                                     alt="{$displayPageHeaderTitle.altText|escape}" width="{$displayPageHeaderTitle.width|escape}"
                                     height="{$displayPageHeaderTitle.height|escape}"/>
                            </a>
                        {/if}
                    </div>
                {/if}
                
            </div>
            <div class="col-sm-9">
                
                {if ($displayPageHeaderLogo || is_array($displayPageHeaderTitle))}
                            <a href="{$homeUrl}" class="is_text journal-name navbar-brand">{$displayPageHeaderTitle}</a>
                {/if}
            </div>
            <div class="col-sm-2">
                <img src="http://escienta.com/wp-content/uploads/2018/02/escientia-logo1v4-Full-white-190px.png" alt="University Logo">
            </div>
        
        </div> 
    </div>
<!--
    {if ($displayPageHeaderLogo || is_array($displayPageHeaderTitle)) && $requestedPage|escape != "article"}
        <div class="journal-logo" class="img-thumbnail">
            {if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
                <a href="{$homeUrl}" class="is_img journal-name navbar-brand">
                    <img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}"
                         width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}"
                         {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"
                         {else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
                </a>
            {elseif $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
                <a href="{$homeUrl}" class="is_text journal-name navbar-brand">{$displayPageHeaderTitle}</a>
            {elseif $displayPageHeaderTitle && !$displayPageHeaderLogo && is_array($displayPageHeaderTitle)}
                <a href="{$homeUrl}" class="is_img journal-name navbar-brand">
                    <img src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}"
                         alt="{$displayPageHeaderTitle.altText|escape}" width="{$displayPageHeaderTitle.width|escape}"
                         height="{$displayPageHeaderTitle.height|escape}"/>
                </a>
            {/if}
        </div>
    {/if}
-->
    {* user menu *}
    <nav class="site-navbar-wraper navbar navbar-expand-lg navbar-dark bg-dark">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            {* primary menu *}
            {if $currentContext}
                {* Primary navigation menu for current application *}
                <div class="navbar-nav-scroll ">
                    {load_menu name="primary" id="navigationPrimary" ulClass="pkp_navigation_primary"}
                </div>
            {/if}

        </div>
        
        {load_menu name="user" id="navigationUser" ulClass="pkp_navigation_user" liClass="profile"}
    </nav>
    
        <div class="container-fluid" id="search-bar">
            <div class="row">
                <div class="col-lg-6 offset-lg-3">
                    <form class="input-group" action="{url page="search" op="search"}" method="post" role="search">
                        {csrf}
                        <input type="text" name="query" value="{$searchQuery|escape}" class="search-input-tag form-control"
                               placeholder="{translate key="plugins.gregg.search-text"}" aria-label="Search">
                        <span class="input-group-btn">
                            <button class="btn btn-secondary"
                                    type="submit">{translate key="plugins.gregg.search"}</button>
                        </span>
                    </form>
                </div>
            </div>
        </div>
    
</header>

{* wraper for the page content; end in the footer; we want full-width container on the article's full-text page *}
<div class="site-content container-fluid{if $requestedPage|escape == "article"}{/if}">