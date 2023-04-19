import '../utils/enums/transaction_charge_type.dart';

class SubAccount {
  /// [id] of the Account you want to payout.
  String id;

  /// Inputting [transactionSplitRatio] here will override whatever value you input in the Dashboard for this Account.
  /// If you want to use the value that was set in the dashboard, do not input anything here.
  int? transactionSplitRatio;

  /// Inputting [transactionChargeType] here will override whatever value you input in the Dashboard for this Account.
  /// If you want to use the value that was set in the dashboard, do not input anything here.
  TransactionChargeType? transactionChargeType;

  /// Inputting [transactionPercentage] here will override whatever value you input in the Dashboard for this Account.
  /// If you want to use the value that was set in the dashboard, do not input anything here.
  @Deprecated('User transactionCharge instead.')
  double? transactionPercentage;

  /// [transactionCharge] covers all mode of payment It is no longer restricted to percentage.
  /// Whether it is a percentage or an exact amount figure, in [double].
  /// Inputting [transactionCharge] here will override whatever value you input in the Dashboard for this Account.
  /// If you want to use the value that was set in the dashboard, do not input anything here.
  /// For example:
  ///
  /// ```
  /// transaction_charge_type: TransactionChargeType.flatSubaccount,
  /// transaction_charge: 4200,
  /// ```
  /// OR
  /// ```
  /// transaction_charge_type: TransactionChargeType.percentage,
  /// transaction_charge: 0.2, // which is 20% of the total amount
  /// ```
  /// OR
  /// ```
  /// transaction_charge_type: TransactionChargeType.flat,
  /// transaction_charge: 400,
  /// ```
  double? transactionCharge;

  SubAccount(
      {required this.id,
      this.transactionSplitRatio,
      this.transactionChargeType,
      this.transactionCharge,
      this.transactionPercentage});

  /// Converts this instance to json
  Map<String, dynamic> toJson() {
    switch (transactionChargeType) {
      case TransactionChargeType.percentage:
        return {
          "id": id,
          "transaction_split_ratio": transactionSplitRatio,
          "transaction_charge_type": 'percentage',
          "transaction_charge": transactionCharge ?? transactionPercentage,
        };
      case TransactionChargeType.flat:
        return {
          "id": id,
          "transaction_split_ratio": transactionSplitRatio,
          "transaction_charge_type": 'flat',
          "transaction_charge": transactionCharge ?? transactionPercentage,
        };
      case TransactionChargeType.flatSubaccount:
        return {
          "id": id,
          "transaction_split_ratio": transactionSplitRatio,
          "transaction_charge_type": 'flat_subaccount',
          "transaction_charge": transactionCharge ?? transactionPercentage,
        };
      default:
        return {
          "id": id,
          "transaction_split_ratio": null,
          "transaction_charge_type": null,
          "transaction_charge": null,
        };
    }
  }
}
