class ErrorModel {
  Error? error;

  ErrorModel({this.error});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
  }
}

class Error {
  String? code;
  String? message;
  String? param;
  String? type;

  Error({this.code, this.message, this.param, this.type});

  Error.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    param = json['param'];
    type = json['type'];
  }
}
