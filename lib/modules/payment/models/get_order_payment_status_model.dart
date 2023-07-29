class GetOrderPaymentStatus {
  late String _message;
  late bool _success;
  late int _statusCode;
  late int _paymentStatus;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  int get paymentStatus => _paymentStatus;

  GetOrderPaymentStatus.fromJson(Map<String, dynamic> json) {
    _message =
        json['message'] ?? 'msg key null on get order payment status api!';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
    _paymentStatus = json['payment_status'] ?? -1;
  }
}
