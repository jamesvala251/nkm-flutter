class PlaceOrderModel {
  late String _message;
  late bool _success;
  late int _statusCode;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    _message = json['message'] ?? 'msg key null on place order api!';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}
