import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';

class DesignCategoryModel {
  late List<Data> _data;
  late String _message;
  late bool _success;
  late int _statusCode;

  List<Data> get data => _data;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  DesignCategoryModel.fromJson(Map<String, dynamic> json) {
    _data = <Data>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
    _message = json['message'] ?? 'msg key null on design cate api';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}

class Data {
  late int _categoryId;
  late String _categoryName;
  late String _categoryImage;
  late bool _isCapitalized = false;

  int get categoryId => _categoryId;

  String get categoryName => _categoryName;

  String get categoryImage => _categoryImage;

  Data.fromJson(Map<String, dynamic> json) {
    _categoryId = json['category_id'];
    _categoryName = json['category_name'] ?? '';
    if (!_isCapitalized && _categoryName.isNotEmpty) {
      _categoryName =
          Helper.capitalizeWords(inputString: _categoryName.toLowerCase());
      _isCapitalized = true;
    }
    _categoryImage = json['category_image'] ?? '';
  }
}
