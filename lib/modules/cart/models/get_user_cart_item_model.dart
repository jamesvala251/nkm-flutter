import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';

class GetUserCartItemsModel {
  late int _orderTotalAmount;
  late List<Data> _data;
  late String _message;
  late bool _success;
  late int _statusCode;

  int get orderTotalAmount => _orderTotalAmount;

  List<Data> get data => _data;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  GetUserCartItemsModel.fromJson(Map<String, dynamic> json) {
    _orderTotalAmount = json['order_total_amount'] ?? 0;
    _data = <Data>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
    _message = json['message'] ?? 'msg key null on get user cart!';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}

class Data {
  late int _userCartId;
  late int _designId;
  late String _designName;
  late String _designCaret;
  late String _designWeight;
  late RxInt designQty = 0.obs;
  late String _designPrice;
  late String _designTotalPrice;
  late String _designImage;
  late bool _isCapitalized = false;

  int get userCartId => _userCartId;

  int get designId => _designId;

  String get designName => _designName;

  String get designCaret => _designCaret;

  String get designWeight => _designWeight;

  String get designPrice => _designPrice;

  String get designTotalPrice => _designTotalPrice;

  String get designImage => _designImage;

  Data.fromJson(Map<String, dynamic> json) {
    _userCartId = json['user_cart_id'];
    _designId = json['design_id'];
    _designName = json['design_name'] ?? '';
    if (!_isCapitalized && _designName.isNotEmpty) {
      _designName =
          Helper.capitalizeWords(inputString: _designName.toLowerCase());
      _isCapitalized = true;
    }
    _designCaret = json['design_caret'] ?? '';
    _designWeight = json['design_weight'] ?? '';
    designQty.value = json['design_qty'] ?? 0;
    _designPrice = json['design_price'] ?? '0';
    _designTotalPrice = json['design_total_price'] ?? '0';
    _designImage = json['design_image'] ?? '';
  }
}
