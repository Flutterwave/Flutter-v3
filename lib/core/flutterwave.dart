import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/requests/standard_request.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:flutterwave_standard/models/subaccount.dart';
import 'package:flutterwave_standard/utils.dart';
import 'package:flutterwave_standard/view/flutterwave_style.dart';
import 'package:flutterwave_standard/view/payment_widget.dart';

class Flutterwave {
  BuildContext context;
  String txRef;
  String amount;
  Customization customization;
  Customer customer;
  bool isTestMode;
  String publicKey;
  String paymentOptions;
  String? currency;
  String? paymentPlanId;
  String redirectUrl;
  List<SubAccount>? subAccounts;
  Map<dynamic, dynamic>? meta;
  FlutterwaveStyle? style;

  Flutterwave(
      {required this.context,
      required this.publicKey,
      required this.txRef,
      required this.amount,
      required this.customer,
      required this.paymentOptions,
      required this.customization,
      required this.isTestMode,
      this.currency,
      this.paymentPlanId,
      required this.redirectUrl,
      this.subAccounts,
      this.meta,
      this.style});


  /// Starts Standard Transaction
  Future<ChargeResponse?> charge() async {
    final request = StandardRequest(
        txRef: txRef,
        amount: amount,
        customer: customer,
        paymentOptions: paymentOptions,
        customization: customization,
        isTestMode: isTestMode,
        publicKey: publicKey,
        currency: currency,
        paymentPlanId: paymentPlanId,
        redirectUrl: redirectUrl,
        subAccounts: subAccounts,
        meta: meta);

    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentWidget(
          request: request,
          style: style ?? FlutterwaveStyle(),
          mainContext: context,
        ),
      ),
    );
  }
}
