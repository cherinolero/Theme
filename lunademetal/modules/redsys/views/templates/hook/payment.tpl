<div class="row">
	<div class="col-xs-12 col-md-6">
		<p class="payment_module">
			<a href="javascript:$('#redsys_form').submit();" title="{l s='Conectar con el TPV' mod='redsys'}" style="padding-left:17px;">
				<img src="{$module_dir}views/img/tarjetas.png" alt="{l s='Conectar con el TPV' mod='redsys'}"/>
				{l s='Pago con tarjeta.(Conexión segura con Redsys)' mod='redsys'}
		        {if number_format($fee_redsys,2)!='0.00'}
				<br/><br/>
				{l s='Este método de pago lleva asociado un recargo de %s' sprintf={convertPrice price=$fee_redsys} mod='redsys'}.{l s='El recargo se sumará a los gastos de envío' mod='redsys'}
			{/if}
			</a>
		</p>
    </div>
</div>
<form action="{$urltpv}" method="post" id="redsys_form" class="hidden" accept-charset = "ISO-8859-15">
	<input type="hidden" name="Ds_SignatureVersion" value="{$Ds_SignatureVersion}" />
	<input type="hidden" name="Ds_MerchantParameters" value="{$Ds_MerchantParameters}" />
	<input type="hidden" name="Ds_Signature" value="{$Ds_Signature}" />
</form>
{if $iupay>0}
<div class="row">
	<div class="col-xs-12 col-md-6">
		<p class="payment_module">
			<a href="javascript:$('#iupay_form').submit();" title="{l s='Conectar con IUPAY!' mod='redsys'}">
				<img src="{$module_dir}views/img/Iupay.png" alt="{l s='Conectar con el IUPAY!' mod='redsys'}"/>
				{l s='Pago con tarjeta.(Conexión segura con IUPAY!)' mod='redsys'}
		        {if number_format($fee_redsys,2)!='0.00'}
				<br/><br/>
				{l s='Este método de pago lleva asociado un recargo de %s' sprintf={convertPrice price=$fee_redsys} mod='redsys'}.{l s='El recargo se sumará a los gastos de envío' mod='redsys'}
			{/if}
			</a>
		</p>
    </div>
</div>
<form action="{$urltpv}" method="post" id="iupay_form" class="hidden" accept-charset = "ISO-8859-15">
	<input type="hidden" name="Ds_SignatureVersion" value="{$Ds_SignatureVersion}" />
	<input type="hidden" name="Ds_MerchantParameters" value="{$IUPAY_MerchantParameters}" />
	<input type="hidden" name="Ds_Signature" value="{$IUPAY_Signature}" />
</form>
{/if}