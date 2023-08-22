import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';

class GetUserCartItemsModel {
  late Data? _data;
  late String _message;
  late bool _success;
  late int _statusCode;

  Data? get data => _data;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  GetUserCartItemsModel.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'] ?? 'msg key null on get user cart api!';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}

class Data {
  late int _cartId;
  late int _userId;
  late int _totalMakingCharge;
  late int _totalGoldPrice;
  late int _qty;
  late int _total;
  late List<CartItemData> _cartItemData;
  late List<ProductDetails> _productDetails;

  int get cartId => _cartId;

  int get userId => _userId;

  int get totalMakingCharge => _totalMakingCharge;

  int get totalGoldPrice => _totalGoldPrice;

  int get qty => _qty;

  int get total => _total;

  List<CartItemData> get cartItemData => _cartItemData;

  List<ProductDetails> get productDetails => _productDetails;

  Data.fromJson(Map<String, dynamic> json) {
    _cartId = json['cart_id'];
    _userId = json['user_id'];
    _totalMakingCharge = json['total_making_charge'];
    _totalGoldPrice = json['total_gold_price'];
    _qty = json['qty'];
    _total = json['total'];
    _productDetails = <ProductDetails>[];
    if (json['product_details'] != null) {
      json['product_details'].forEach((v) {
        _productDetails.add(ProductDetails.fromJson(v));
      });
    }

    _cartItemData = <CartItemData>[];
    if (json['cart_item_data'] != null) {
      json['cart_item_data'].forEach((v) {
        CartItemData cartItemDataTemp = CartItemData.fromJson(v);
        cartItemDataTemp.productDetail = _productDetails.firstWhereOrNull(
            (element) => element.id == cartItemDataTemp.designId);
        _cartItemData.add(cartItemDataTemp);
      });
    }
  }
}

class CartItemData {
  late int _id;
  late int _cartId;
  late int _designId;
  late int _designCaretId;
  late int _designArticleId;
  late String _articleNumber;
  late int _caret;
  late String _caretLabel = '';
  late int _weight;
  late int _makingCharge;
  late int _goldPrice;
  late int _totalPrice;
  late int _goldRate;
  late ProductDetails?
      productDetail; //this is custom logic to get product details item design id wise just to make ui part easy and optimized!
  // late String _createdAt;
  // late String _updatedAt;

  int get id => _id;

  int get cartId => _cartId;

  int get designId => _designId;

  int get designCaretId => _designCaretId;

  int get designArticleId => _designArticleId;

  String get articleNumber => _articleNumber;

  // int get caret => _caret;

  String get caretLabel => _caretLabel;

  int get weight => _weight;

  int get makingCharge => _makingCharge;

  int get goldPrice => _goldPrice;

  int get totalPrice => _totalPrice;

  int get goldRate => _goldRate;

  // String get createdAt => _createdAt;
  // String get updatedAt => _updatedAt;

  CartItemData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _cartId = json['cart_id'];
    _designId = json['design_id'];
    _designCaretId = json['design_caret_id'];
    _designArticleId = json['design_article_id'];
    _articleNumber = json['article_number'] ?? '';
    _caret = json['caret'] ?? 0;
    _caretLabel = CommonConstants.caretLabels[_caret] ?? '${_caret}K';
    _weight = json['weight'] ?? 0;
    _makingCharge = json['making_charge'] ?? 0;
    _goldPrice = json['gold_price'] ?? 0;
    _totalPrice = json['total_price'] ?? 0;
    _goldRate = json['gold_rate'] ?? 0;
    // _createdAt = json['created_at'] ?? '';
    // _updatedAt = json['updated_at'] ?? '';
  }
}

class ProductDetails {
  late int _id;
  late String _name;
  late String _image;

  int get id => _id;

  String get name => _name;

  String get image => _image;

  ProductDetails.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'] ?? '';
    _image = json['image'] ?? '';
  }
}
