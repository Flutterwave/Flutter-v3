class TransactionError implements Exception {
  String message;

  TransactionError(this.message);

  @override
  String toString() => message;

  static String formatError(dynamic error) {
    try {
      if (error["errors"] != null) {
        final errorList = error["errors"] as List<dynamic>;
        return "${errorList.first["message"]}";
      }
      if (error["message"] != null) {
        return error["message"];
      }
      return "An unexpected error occurred. Please try again.";
    } catch (error) {
      return "An unexpected error occurred. Please try again.";
    }
  }
}
