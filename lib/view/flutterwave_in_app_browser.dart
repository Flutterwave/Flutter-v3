import 'dart:convert';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutterwave_standard/core/TransactionCallBack.dart';

import 'package:flutterwave_standard/models/responses/charge_response.dart';

class FlutterwaveInAppBrowser extends InAppBrowser {
  final TransactionCallBack callBack;

  FlutterwaveInAppBrowser({required this.callBack});

  ChargeResponse? _chargeResponse;

  @override
  Future onLoadStart(url) async {
    if (url != null) _processUrl(url);
  }

  @override
  void onExit() {
    callBack.onTransactionComplete(_chargeResponse);
  }

  _processUrl(Uri uri) {
    if (_checkHasAppendedWithResponse(uri)) {
      _finishWithAppendedResponse(uri);
    } else {
      _checkHasCompletedProcessing(uri);
    }
  }

  _checkHasCompletedProcessing(final Uri uri) {
    final status = uri.queryParameters["status"];
    final txRef = uri.queryParameters["tx_ref"];
    final id = uri.queryParameters["transaction_id"];
    if (status != null && txRef != null) {
      _finish(uri);
    }
  }

  bool _checkHasAppendedWithResponse(final Uri uri) {
    final response = uri.queryParameters["response"];
    if (response != null) {
      final json = jsonDecode(response);
      final status = json["status"];
      final txRef = json["txRef"];
      return status != null && txRef != null;
    }
    return false;
  }

  _finishWithAppendedResponse(Uri uri) {
    final response = uri.queryParameters["response"];
    final decoded = Uri.decodeFull(response!);
    final json = jsonDecode(decoded);
    final status = json["status"];
    final txRef = json["txRef"];
    final id = json["id"];

    final ChargeResponse chargeResponse = ChargeResponse(
        status: status,
        transactionId: "$id",
        txRef: txRef,
        success: status?.toString().toLowerCase() == "success" ||
            status?.toString().toLowerCase() == "completed");
    _closeTransactionScreen(chargeResponse);
    // callBack.onTransactionComplete(chargeResponse);
    // close();
  }

  _finish(final Uri uri) {
    final status = uri.queryParameters["status"];
    final txRef = uri.queryParameters["tx_ref"];
    final id = uri.queryParameters["transaction_id"];
    final ChargeResponse chargeResponse = ChargeResponse(
        status: status,
        transactionId: id,
        txRef: txRef,
        success: status?.toLowerCase() == "success" ||
            status?.toLowerCase() == "completed");
    _closeTransactionScreen(chargeResponse);
    // callBack.onTransactionComplete(chargeResponse);
    // close();
  }

  _closeTransactionScreen(final ChargeResponse chargeResponse) {
    _chargeResponse = chargeResponse;
    close();
  }
}
