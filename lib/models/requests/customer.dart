import 'package:flutterwave_standard/utils.dart';

class Customer {
  String email;
  String? phoneNumber;
  String? name;

  Customer({required this.email, this.name, this.phoneNumber});

  /// Converts instance of Customer to json
  Map<String, dynamic> toJson() {
    final customer = {
      "email": email,
      "phonenumber": phoneNumber ?? "",
      "name": name ?? ""
    };
    return Utils.removeKeysWithEmptyValues(customer);
  }
}
