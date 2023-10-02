class GetOtpModel {
  late String _message;
  late bool _success;
  late int _statusCode;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  GetOtpModel.fromJson(Map<String, dynamic> json) {
    _message = json['message'] ?? 'msg key null on get otp api';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}
