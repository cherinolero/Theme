{*
* 2007-2014 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2014 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
<!DOCTYPE HTML>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7 " lang="{$lang_iso}"><![endif]-->
<!--[if IE 7]><html class="no-js lt-ie9 lt-ie8 ie7" lang="{$lang_iso}"><![endif]-->
<!--[if IE 8]><html class="no-js lt-ie9 ie8" lang="{$lang_iso}"><![endif]-->
<!--[if gt IE 8]> <html class="no-js ie9" lang="{$lang_iso}"><![endif]-->
<html lang="{$lang_iso}">
	<head>
		<meta charset="utf-8" />
		<title>{$meta_title|escape:'html':'UTF-8'}</title>
{if isset($meta_description) AND $meta_description}
		<meta name="description" content="{$meta_description|escape:'html':'UTF-8'}" />
{/if}
{if isset($meta_keywords) AND $meta_keywords}
		<meta name="keywords" content="{$meta_keywords|escape:'html':'UTF-8'}" />
{/if}
		<meta name="generator" content="PrestaShop" />
		<meta name="robots" content="{if isset($nobots)}no{/if}index,{if isset($nofollow) && $nofollow}no{/if}follow" />
		<meta name="viewport" content="width=device-width, minimum-scale=0.25, maximum-scale=1.6, initial-scale=1.0" /> 
		<meta name="apple-mobile-web-app-capable" content="yes" /> 
		<link rel="icon" type="image/vnd.microsoft.icon" href="{$favicon_url}?{$img_update_time}" />
		<link rel="shortcut icon" type="image/x-icon" href="{$favicon_url}?{$img_update_time}" />
{if isset($css_files)}
	{foreach from=$css_files key=css_uri item=media}
		<link rel="stylesheet" href="{$css_uri|escape:'html':'UTF-8'}" type="text/css" media="{$media|escape:'html':'UTF-8'}" />
	{/foreach}
{/if}
{if isset($js_defer) && !$js_defer && isset($js_files) && isset($js_def)}
	{$js_def}
	{foreach from=$js_files item=js_uri}
	<script type="text/javascript" src="{$js_uri|escape:'html':'UTF-8'}"></script>
	{/foreach}
{/if}
                <link href="{$css_dir}ptmfix.css" rel="stylesheet" type="text/css" media="screen" />
                <link href="{$css_dir}custommaker.css" rel="stylesheet" type="text/css" media="screen" />
                <link href="{$css_dir}customuser.css" rel="stylesheet" type="text/css" media="screen" />
		{$HOOK_HEADER}
		<link rel="stylesheet" href="http{if Tools::usingSecureMode()}s{/if}://fonts.googleapis.com/css?family=Open+Sans:300,600" type="text/css" media="all" />
		<!--[if IE 8]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
		<![endif]-->
    <link href='http://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet' type='text/css'>

{literal}
<script type="text/javascript">
	// create our transition as a plugin
	$.fn.crossfade = function () {
	  return this.each(function () { 
		// cache the copy of jQuery(this) - the start image
		var $$ = $(this);
	
		// get the target from the backgroundImage + regexp
		var target = $$.css('backgroundImage').replace(/^url|[\(\)]/g, '');
		var target = target.replace(/"/g, '');
	
		// nice long chain: wrap img element in span
		$$.wrap('<span></span>')
		  // change selector to parent - i.e. newly created span
		  .parent()
		  // prepend a new image inside the span
		  .prepend('<img>')
		  // change the selector to the newly created image
		  .find(':first-child')
		  // set the image to the target
		  .attr('src', target);
	
		// position the original image
		$$.css({
		  'position' : 'absolute', 
		  'left' : 0, 
		  // this.offsetTop aligns the image correctly inside the span
		  'top' : 0
		});
	
		// note: the above CSS change requires different handling for Opera and Safari,
		// <a href="http://jqueryfordesigners.com/downloads/jquery.crossfade.js">see the full plugin for this</a>.
	
		// similar effect as single image technique, except using .animate 
		// which will handle the fading up from the right opacity for us
		$$.hover(function () {
		  $$.stop().animate({
			  opacity: 0
		  }, 0);
		}, function () {
		  $$.stop().animate({
			  opacity: 1
		  }, 0);
		});
	  });
	};
	
	// Not only when the DOM is ready, but when the images have finished loading,
	// important, but subtle difference to $(document).ready();
	$(window).bind('load', function () {
	  // run the cross fade plugin against selector
	  $('img.fade').crossfade();
	});
</script>
{/literal}
    
                    </head>
	<body{if isset($page_name)} id="{$page_name|escape:'html':'UTF-8'}"{/if} class="{if isset($page_name)}{$page_name|escape:'html':'UTF-8'}{/if}{if isset($body_classes) && $body_classes|@count} {implode value=$body_classes separator=' '}{/if}{if $hide_left_column} hide-left-column{/if}{if $hide_right_column} hide-right-column{/if}{if isset($content_only) && $content_only} content_only{/if} lang_{$lang_iso}">
	{if !isset($content_only) || !$content_only}
		{if isset($restricted_country_mode) && $restricted_country_mode}
			<div id="restricted-country">
				<p>{l s='You cannot place a new order from your country.'} <span class="bold">{$geolocation_country|escape:'html':'UTF-8'}</span></p>
			</div>
		{/if}
		<div id="page">
			<div class="header-container">
				<header id="header">

					<div id="header_logo">
						<a href="{$base_dir}" title="{$shop_name|escape:'html':'UTF-8'}">
							<img class="logo img-responsive" src="{$logo_url}" alt="{$shop_name|escape:'html':'UTF-8'}"{if isset($logo_image_width) && $logo_image_width} width="{$logo_image_width}"{/if}{if isset($logo_image_height) && $logo_image_height} height="{$logo_image_height}"{/if}/>
						</a>
					</div>

					<div>
						<div class="container">
							<div class="row">
								{if isset($HOOK_TOP)}{$HOOK_TOP}{/if}
							</div>
						</div>
					</div>

					<div class="nav">
						<div class="container">
							<div class="row">
								<nav>{hook h="displayNav"}</nav>
							</div>
						</div>
					</div>
				</header>
			</div>
			<div class="columns-container">
				<div id="columns" class="container">
					{if $page_name =='category' && $category->id_image}
	                    <div class="cabecera_categoria" style="background:url({$link->getCatImageLink($category->link_rewrite, $category->id_image, 'category_default')|escape:'html':'UTF-8'}) 0 top no-repeat; background-size:contain; min-height:{$categorySize.height}px;" >
	                            <div class="cat_desc">
	                            <span class="category-name">
	                                {strip}
	                                    {$category->name|escape:'html':'UTF-8'}
	                                    {if isset($categoryNameComplement)}
	                                        {$categoryNameComplement|escape:'html':'UTF-8'}
	                                    {/if}
	                                {/strip}
	                            </span>
                                <div class="rte migapan">
									<a class="home" href="{$base_dir}" title="{l s='Return to Home'}"><i class="icon-home"></i></a>
									{if isset($path) AND $path}
										<span class="navigation-pipe" {if isset($category) && isset($category->id_category) && $category->id_category == 1}style="display:none;"{/if}>></span>
										{if !$path|strpos:'span'}
											<span class="navigation_page">{$path}</span>
										{else}
											{$path}
										{/if}
									{/if}
                                </div>
	                            </div>
	                     </div>
					{/if}					
					{if $page_name !='index' && $page_name !='pagenotfound' && ($page_name !='category' || ($page_name =='category' && $category->id_image == false))}
						{include file="$tpl_dir./breadcrumb.tpl"}
					{/if}
					<div id="slider_row" class="row">
						<div id="top_column" class="center_column col-xs-12 col-sm-12">{hook h="displayTopColumn"}</div>
					</div>
					{if $page_name !='index'}
					<div class="row interior">
					{else}
					<div class="row">
					{/if}
						{if isset($left_column_size) && !empty($left_column_size)}
						<div id="left_column" class="column col-xs-12 col-sm-{$left_column_size|intval}">{$HOOK_LEFT_COLUMN}</div>
						{/if}
						{if isset($left_column_size) && isset($right_column_size)}{assign var='cols' value=(12 - $left_column_size - $right_column_size)}{else}{assign var='cols' value=12}{/if}
						<div id="center_column" class="center_column col-xs-12 col-sm-{$cols|intval}">
	{/if}