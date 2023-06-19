class RemoveDesignFromCartModel {
  late Data? _data;
  late String _message;
  late bool _success;
  late int _statusCode;

  Data? get data => _data;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  RemoveDesignFromCartModel.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message =
        json['message'] ?? 'msg key null in remove design from cart api!';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}

class Data {
  late int _cartItemsCount;

  int get cartItemsCount => _cartItemsCount;

  Data.fromJson(Map<String, dynamic> json) {
    _cartItemsCount = json['cart_items_count'] ?? 0;
  }
}
