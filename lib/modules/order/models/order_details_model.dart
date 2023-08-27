import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';

class OrderDetailsModel {
  late Data? _data;
  late String _message;
  late bool _success;
  late int _statusCode;

  Data? get data => _data;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'] ?? 'msg key null on order details api!';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}

class Data {
  late int _totalQty;
  late int _totalWeight;
  late int _totalMakingCharge;
  late int _totalGoldPrice;
  late String _total;
  late List<ArticleDetail> _articleDetail;

  int get totalQty => _totalQty;

  int get totalWeight => _totalWeight;

  int get totalMakingCharge => _totalMakingCharge;

  int get totalGoldPrice => _totalGoldPrice;

  String get total => _total;

  List<ArticleDetail> get articleDetail => _articleDetail;

  Data.fromJson(Map<String, dynamic> json) {
    _totalQty = json['total_qty'] ?? 0;
    _totalWeight = json['total_weight'] ?? 0;
    _totalMakingCharge = json['total_making_charge'] ?? 0;
    _totalGoldPrice = json['total_gold_price'] ?? 0;
    _total = json['total'] ?? '0';
    _articleDetail = <ArticleDetail>[];
    if (json['article_detail'] != null) {
      json['article_detail'].forEach((v) {
        _articleDetail.add(ArticleDetail.fromJson(v));
      });
    }
  }
}

class ArticleDetail {
  late String _designName;
  late String _designImage;
  late String _caret;
  late int _weight;
  late int _makingCharge;
  late int _goldPrice;
  late int _totalPrice;
  late int _goldRate;
  late String _articalNumber;
  late bool _isCapitalized = false;

  String get designName => _designName;

  String get designImage => _designImage;

  String get caret => _caret;

  int get weight => _weight;

  int get makingCharge => _makingCharge;

  int get goldPrice => _goldPrice;

  int get totalPrice => _totalPrice;

  int get goldRate => _goldRate;

  String get articalNumber => _articalNumber;

  ArticleDetail.fromJson(Map<String, dynamic> json) {
    _designName = json['design_name'];
    if (!_isCapitalized && _designName.isNotEmpty) {
      _designName =
          Helper.capitalizeWords(inputString: _designName.toLowerCase());
      _isCapitalized = true;
    }
    _designImage = json['design_image'] ?? '';
    _caret = json['caret'] ?? '';
    _weight = json['weight'] ?? 0;
    _makingCharge = json['making_charge'] ?? 0;
    _goldPrice = json['gold_price'] ?? 0;
    _totalPrice = json['total_price'] ?? 0;
    _goldRate = json['gold_rate'] ?? 0;
    _articalNumber = json['artical_number'] ?? 0;
  }
}
