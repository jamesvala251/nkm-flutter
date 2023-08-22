class RemoveDesignFromCartModel {
  late String _message;
  late bool _success;
  late int _statusCode;
  late int _cartItemsCount;
  late int _total;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  int get cartItemsCount => _cartItemsCount;

  int get total => _total;

  RemoveDesignFromCartModel.fromJson(Map<String, dynamic> json) {
    _message =
        json['message'] ?? 'msg key null in remove design from cart api!';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
    _cartItemsCount = json['cart_items_count'] ?? 0;
    _total = json['total'] ?? 0;
  }
}
