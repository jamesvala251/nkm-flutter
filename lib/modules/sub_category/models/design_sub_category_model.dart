import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';

class DesignSubCategoryModel {
  late List<Data> _data;
  late String _message;
  late bool _success;
  late int _statusCode;

  List<Data> get data => _data;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  DesignSubCategoryModel.fromJson(Map<String, dynamic> json) {
    _data = <Data>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
    _message = json['message'] ?? 'msg key null in design sub cate api';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}

class Data {
  late int _subCategoryId;
  late String _subCategoryName;
  late String _subCategoryImage;
  late bool _isCapitalized = false;

  int get subCategoryId => _subCategoryId;

  String get subCategoryName => _subCategoryName;

  String get subCategoryImage => _subCategoryImage;

  Data.fromJson(Map<String, dynamic> json) {
    _subCategoryId = json['sub_category_id'];
    _subCategoryName = json['sub_category_name'] ?? '';
    if (!_isCapitalized && _subCategoryName.isNotEmpty) {
      _subCategoryName =
          Helper.capitalizeWords(inputString: _subCategoryName.toLowerCase());
      _isCapitalized = true;
    }
    _subCategoryImage = json['sub_category_image'] ?? '';
  }
}
