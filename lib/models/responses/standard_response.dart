class StandardResponse {
  String? status;
  String? message;
  StandardResponseData? data;

  StandardResponse({this.status, this.data, this.message});

  StandardResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = StandardResponseData.fromJson(json["data"]);
  }

  /// Converts this instance to json
  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data?.toJson()
    };
  }
}

class StandardResponseData {
  String? link;

  StandardResponseData([this.link = ""]);

  StandardResponseData.fromJson(Map<String, dynamic> json) {
    link = json["link"];
  }

  /// Converts this instance to json
  Map<String, dynamic> toJson() {
    return {"link": link};
  }
}
