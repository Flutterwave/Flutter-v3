import 'package:flutter/material.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/requests/standard_request.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';
import 'package:flutterwave_standard/models/responses/standard_response.dart';
import 'package:flutterwave_standard/models/subaccount.dart';
import 'package:flutterwave_standard/view/standard_widget.dart';
import 'package:flutterwave_standard/view/view_utils.dart';
import 'package:http/http.dart';

class Flutterwave {
  String txRef;
  String amount;
  Customization customization;
  Customer customer;
  bool isTestMode;
  String publicKey;
  String paymentOptions;
  String redirectUrl;
  String currency;
  String? paymentPlanId;
  List<SubAccount>? subAccounts;
  Map<dynamic, dynamic>? meta;

  Flutterwave(
      {required this.publicKey,
      required this.txRef,
      required this.amount,
      required this.customer,
      required this.paymentOptions,
      required this.customization,
      required this.redirectUrl,
      required this.isTestMode,
      required this.currency,
      this.paymentPlanId,
      this.subAccounts,
      this.meta});

  /// Starts a transaction by calling the Standard service
  Future<ChargeResponse> charge(BuildContext context) async {
    final request = StandardRequest(
        txRef: txRef,
        amount: amount,
        customer: customer,
        paymentOptions: paymentOptions,
        customization: customization,
        isTestMode: isTestMode,
        redirectUrl: redirectUrl,
        publicKey: publicKey,
        currency: currency,
        paymentPlanId: paymentPlanId,
        subAccounts: subAccounts,
        meta: meta);

    StandardResponse? standardResponse;

    try {
      standardResponse = await request.execute(Client());

      if (!context.mounted) {
        return ChargeResponse(
          txRef: request.txRef,
          status: "error",
          success: false,
        );
      }

      if ("error" == standardResponse.status) {
        FlutterwaveViewUtils.showToast(
            context, standardResponse.message!);
        return ChargeResponse(
            txRef: request.txRef, status: "error", success: false);
      }

      if (standardResponse.data?.link == null ||
          standardResponse.data?.link?.isEmpty == true) {
        if (!context.mounted) {
          return ChargeResponse(
            txRef: request.txRef,
            status: "error",
            success: false,
          );
        }

        FlutterwaveViewUtils.showToast(
            context,
            "Unable to process this transaction. " +
                "Please check that you generated a new tx_ref");
        return ChargeResponse(
            txRef: request.txRef, status: "error", success: false);
      }
    } catch (error) {
      if (!context.mounted) {
        return ChargeResponse(
          txRef: request.txRef,
          status: "error",
          success: false,
        );
      }

      FlutterwaveViewUtils.showToast(context, error.toString());
      return ChargeResponse(
          txRef: request.txRef, status: "error", success: false);
    }

    if (!context.mounted) {
      return ChargeResponse(
        txRef: request.txRef,
        status: "error",
        success: false,
      );
    }

    final response = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StandardPaymentWidget(
          webUrl: standardResponse!.data!.link!,
        ),
      ),
    );

    if (response != null) return response!;
    return ChargeResponse(
        txRef: request.txRef, status: "cancelled", success: false);
  }
}
