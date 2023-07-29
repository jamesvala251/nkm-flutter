class PlaceOrderModel {
  late String _message;
  late bool _success;
  late int _statusCode;
  late String _paymentUrl;
  late String _redirectUrl;
  late String _cancelUrl;
  late String _orderNo;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  String get paymentUrl => _paymentUrl;

  String get redirectUrl => _redirectUrl;

  String get cancelUrl => _cancelUrl;

  String get orderNo => _orderNo;

  PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    _message = json['message'] ?? 'msg key null on payment api!';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
    _paymentUrl = json['payment_url'] ?? '';
    _redirectUrl = json['redirect_url'] ?? '';
    _cancelUrl = json['cancel_url'] ?? '';
    _orderNo = json['order_no'] ?? '';
  }
}
