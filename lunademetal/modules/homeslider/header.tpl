{if isset($homeslider)}
    {addJsDef homeslider_loop=$homeslider.loop|intval}
    {addJsDef homeslider_width=$homeslider.width|intval}
    {addJsDef homeslider_speed=$homeslider.speed|intval}
    {addJsDef homeslider_pause=$homeslider.pause|intval}
	{addJsDefL name=min_item}{l s='Please select at least one product' js=1}{/addJsDefL}
	{addJsDefL name=max_item}{l s='You cannot add more than %d product(s) to the product comparison' sprintf=$comparator_max_item js=1}{/addJsDefL}
	{addJsDef comparator_max_item=$comparator_max_item}
	{addJsDef comparedProductsIds=$compared_products}
{/if}