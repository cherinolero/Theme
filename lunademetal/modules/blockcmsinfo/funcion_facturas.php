<?php
function refundInvoicePayment($transid, $amount, $sendtogateway, $addascredit = "", $sendemail = true, $refundtransid = "") {
	$result = select_query("tblaccounts", "", array("id" => $transid));
	$data = mysql_fetch_array($result);
	$transid = $data['id'];

	if (!$transid) {
		return "amounterror";
	}

	$userid = $data['userid'];
	$invoiceid = $data['invoiceid'];
	$gateway = $data['gateway'];
	$fullamount = $data['amountin'];
	$fees = $data['fees'];
	$gatewaytransid = $data['transid'];
	$rate = $data['rate'];
	$gateway = WHMCS_Gateways::makesafename($gateway);
	$result = select_query("tblaccounts", "SUM(amountout),SUM(fees)", array("refundid" => $transid));
	$data = mysql_fetch_array($result);
	$alreadyrefunded = $data[0];
	$alreadyrefundedfees = $data[1];
	$fullamount -= $alreadyrefunded;
	$fees -= $alreadyrefundedfees * (0 - 1);

	if ($fees <= 0) {
		$fees = 0;
	}

	$result = select_query("tblaccounts", "SUM(amountin),SUM(amountout)", array("invoiceid" => $invoiceid));
	$data = mysql_fetch_array($result);
	$invoicetotalpaid = $data[0];
	$invoicetotalrefunded = $data[1];

	if (!$amount) {
		$amount = $fullamount;
	}


	if (!$amount || $fullamount < $amount) {
		return "amounterror";
	}

	$amount = format_as_currency($amount);

	if ($addascredit) {
		addTransaction($userid, 0, "Refund of Transaction ID " . $gatewaytransid . " to Credit Balance", 0, $fees * (0 - 1), $amount, "", "", $invoiceid, "", $transid, $rate);
		addTransaction($userid, 0, "Credit from Refund of Invoice ID " . $invoiceid, $amount, $fees, 0, "", "", "", "", "", "");
		logActivity("Refunded Invoice Payment to Credit Balance - Invoice ID: " . $invoiceid, $userid);
		insert_query("tblcredit", array("clientid" => $userid, "date" => "now()", "description" => "Credit from Refund of Invoice ID " . $invoiceid, "amount" => $amount));
		$query = "UPDATE tblclients SET credit=credit+" . mysql_real_escape_string($amount) . " WHERE id='" . mysql_real_escape_string($userid) . "'";
		full_query($query);

		if ($invoicetotalpaid - $invoicetotalrefunded - $amount <= 0) {
			update_query("tblinvoices", array("status" => "Refunded"), array("id" => $invoiceid));
			run_hook("InvoiceRefunded", array("invoiceid" => $invoiceid));
		}


		if ($sendemail) {
			sendMessage("Invoice Refund Confirmation", $invoiceid, array("invoice_refund_type" => "credit"));
		}

		return "creditsuccess";
	}

	$result = select_query("tblpaymentgateways", "value", array("gateway" => $gateway, "setting" => "convertto"));
	$data = mysql_fetch_array($result);
	$convertto = $data['value'];

	if ($convertto) {
		$result = select_query("tblclients", "currency", array("id" => $userid));
		$data = mysql_fetch_array($result);
		$fromcurrencyid = $data['currency'];
		$convertedamount = convertCurrency($amount, $fromcurrencyid, $convertto, $rate);
	}


	if ($gateway) {
		$params = getCCVariables($invoiceid);
	}


	if ($sendtogateway && function_exists($gateway . "_refund")) {
		$params['amount'] = ($convertedamount ? $convertedamount : $amount);
		$params['transid'] = $gatewaytransid;
		$params['paymentmethod'] = $gateway;
		$gatewayresult = call_user_func($gateway . "_refund", $params);
		$refundtransid = $gatewayresult['transid'];
		$rawdata = $gatewayresult['rawdata'];

		if (isset($gatewayresult['fees'])) {
			$fees = $gatewayresult['fees'];
		}

		$gatewayresult = $gatewayresult['status'];
		$result = select_query("tblpaymentgateways", "value", array("gateway" => $gateway, "setting" => "name"));
		$data = mysql_fetch_array($result);
		$gatewayname = $data['value'];
		logTransaction($gatewayname . " Refund", $rawdata, ucfirst($gatewayresult));
	}
	else {
		$gatewayresult = "manual";
		run_hook("ManualRefund", array("transid" => $transid, "amount" => $amount));
	}


	if ($gatewayresult == "success" || $gatewayresult == "manual") {
		addTransaction($userid, 0, "Refund of Transaction ID " . $gatewaytransid, 0, $fees * (0 - 1), $amount, $gateway, $refundtransid, $invoiceid, "", $transid, $rate);
		logActivity("Refunded Invoice Payment - Invoice ID: " . $invoiceid . " - Transaction ID: " . $transid, $userid);
		$result = select_query("tblinvoices", "total", array("id" => $invoiceid));
		$data = mysql_fetch_array($result);
		$invoicetotal = $data[0];

		if ($invoicetotalpaid - $invoicetotalrefunded - $amount <= 0) {
			update_query("tblinvoices", array("status" => "Refunded"), array("id" => $invoiceid));
			run_hook("InvoiceRefunded", array("invoiceid" => $invoiceid));
		}


		if ($sendemail) {
			sendMessage("Invoice Refund Confirmation", $invoiceid, array("invoice_refund_type" => "gateway"));
		}
	}

	return $gatewayresult;
}
?>