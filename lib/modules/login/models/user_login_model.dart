class UserLoginModel {
  late String _message;
  late bool _success;
  late int _statusCode;
  late String? _token;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  String? get token => _token;

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    _message = json['message'] ?? 'msg key null on user login api';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
    _token = json['token'];
  }
}
