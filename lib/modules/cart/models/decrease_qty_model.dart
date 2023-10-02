class DecreaseQuantityModel {
  late String _message;
  late bool _success;
  late int _statusCode;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  DecreaseQuantityModel.fromJson(Map<String, dynamic> json) {
    _message = json['message'] ?? 'msg key null on desc qty api';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}
