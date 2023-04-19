
import '../utils/enums/transaction_charge_type.dart';

class SubAccount {
  String id;
  int? transactionSplitRatio;
  TransactionChargeType? transactionChargeType;
  double? transactionPercentage;

  SubAccount({
    required this.id,
    this.transactionSplitRatio,
    this.transactionChargeType,
    this.transactionPercentage
  });

  /// Converts this instance to json
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "transaction_split_ratio": this.transactionSplitRatio,
      "transaction_charge_type": this.transactionChargeType == TransactionChargeType.flat ? "flat_subaccount" : "percentage",
      "transaction_charge": this.transactionPercentage
    };
  }
}
