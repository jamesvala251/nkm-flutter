import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';

class OrderDetailsModel {
  late List<Data> _data;
  late String _message;
  late bool _success;
  late int _statusCode;
  late int _totalCount;
  late int _perPage;
  late int _currentPage;

  List<Data> get data => _data;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  int get totalCount => _totalCount;

  int get perPage => _perPage;

  int get currentPage => _currentPage;

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    _data = <Data>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
    _message = json['message'] ?? 'msg key null on order details api';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
    _totalCount = json['total_count'] ?? 0;
    _perPage = json['per_page'] ?? 0;
    _currentPage = json['current_page'] ?? 0;
  }
}

class Data {
  late String _designName;
  late String _designImage;
  late String _caret;
  late String _goldRate;
  late int _quantity;
  late String _makingCharge;
  late int _totalWeight;
  late String _totalPrice;
  late bool _isCapitalized = false;

  String get designName => _designName;

  String get designImage => _designImage;

  String get caret => _caret;

  String get goldRate => _goldRate;

  int get quantity => _quantity;

  String get makingCharge => _makingCharge;

  int get totalWeight => _totalWeight;

  String get totalPrice => _totalPrice;

  Data.fromJson(Map<String, dynamic> json) {
    _designName = json['design_name'] ?? '';
    if (!_isCapitalized && _designName.isNotEmpty) {
      _designName =
          Helper.capitalizeWords(inputString: _designName.toLowerCase());
      _isCapitalized = true;
    }
    _designImage = json['design_image'] ?? '';
    _caret = json['caret'] ?? '';
    // _caret = _caret.isNotEmpty ? _caret.toLowerCase().replaceFirst('k', '') : _caret;
    _goldRate = json['gold_rate'] ?? '';
    _quantity = json['quantity'] ?? 0;
    _makingCharge = json['making_charge'] ?? '';
    _totalWeight = json['total_weight'] ?? 0;
    _totalPrice = json['total_price'] ?? '';
  }
}
