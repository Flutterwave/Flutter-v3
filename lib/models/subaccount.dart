class SubAccount {
  String id;
  int? transactionSplitRatio;
  String? transactionChargeType;
  double? transactionPercentage;

  SubAccount(
      {required this.id,
      this.transactionSplitRatio,
      this.transactionChargeType,
      this.transactionPercentage});

  /// Converts this instance to json
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "transaction_split_ratio": transactionSplitRatio,
      "transaction_charge_type": transactionChargeType,
      "transaction_charge": transactionPercentage
    };
  }
}
