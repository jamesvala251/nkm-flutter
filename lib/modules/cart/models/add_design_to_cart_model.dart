class AddDesignToCartModel {
  late Data? _data;
  late String _message;
  late bool _success;
  late int _statusCode;

  Data? get data => _data;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  AddDesignToCartModel.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'] ?? 'msg key null in add to cart api!';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}

class Data {
  late int _cartItemsCount;
  late CartItem? _cartItem;

  int get cartItemsCount => _cartItemsCount;

  CartItem? get cartItem => _cartItem;

  Data.fromJson(Map<String, dynamic> json) {
    _cartItemsCount = json['cart_items_count'] ?? 0;
    _cartItem =
        json['cart_item'] != null ? CartItem.fromJson(json['cart_item']) : null;
  }
}

class CartItem {
  late int _id;
  late int _userId;

  // late int _designId;
  // late int _caret;
  // late int _qty;
  // late String _makingCharge;
  // late String _price;
  // late String _total;
  // late String _createdAt;
  // late String _updatedAt;

  int get id => _id;

  int get userId => _userId;

  // int get designId => _designId;
  //
  // int get caret => _caret;
  //
  // int get qty => _qty;
  //
  // String get makingCharge => _makingCharge;
  //
  // String get price => _price;
  //
  // String get total => _total;
  //
  // String get createdAt => _createdAt;
  //
  // String get updatedAt => _updatedAt;

  CartItem.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    // _designId = json['design_id'];
    // _caret = json['caret'];
    // _qty = json['qty'];
    // _makingCharge = json['making_charge'];
    // _price = json['price'];
    // _total = json['total'];
    // _createdAt = json['created_at'];
    // _updatedAt = json['updated_at'];
  }
}
