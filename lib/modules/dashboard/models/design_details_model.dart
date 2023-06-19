import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';

class DesignDetailsModel {
  late Data? _data;
  late String _message;
  late bool _success;
  late int _statusCode;

  Data? get data => _data;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  DesignDetailsModel.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'] ?? 'msg key is null in design details api!';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}

class Data {
  late int _designId;
  late String _designName;
  late String _designWeight;
  late String _designCaret;
  late int _designQty;
  late int _designRatePerGm;
  late int _designPrice;
  late int _designMakingCharge;
  late int _designTotal;
  late String _designImage;
  late List<String> _designImageFiles;
  late List<String> _designVideoFiles;
  late bool _isCapitalized = false;

  int get designId => _designId;

  String get designName => _designName;

  String get designWeight => _designWeight;

  String get designCaret => _designCaret;

  int get designQty => _designQty;

  int get designRatePerGm => _designRatePerGm;

  int get designPrice => _designPrice;

  int get designMakingCharge => _designMakingCharge;

  int get designTotal => _designTotal;

  String get designImage => _designImage;

  List<String> get designImageFiles => _designImageFiles;

  List<String> get designVideoFiles => _designVideoFiles;

  Data.fromJson(Map<String, dynamic> json) {
    _designId = json['design_id'];
    _designName = json['design_name'] ?? '';
    if (!_isCapitalized && _designName.isNotEmpty) {
      _designName =
          Helper.capitalizeWords(inputString: _designName.toLowerCase());
      _isCapitalized = true;
    }
    _designWeight = json['design_weight'] ?? '';
    _designCaret = json['design_caret'] ?? '';
    _designQty = json['design_qty'] ?? 0;
    _designRatePerGm = json['design_rate_per_gm'] ?? 0;
    _designPrice = json['design_price'] ?? 0;
    _designMakingCharge = json['design_making_charge'] ?? 0;
    _designTotal = json['design_total'] ?? 0;
    _designImage = json['design_image'] ?? '';
    _designImageFiles = json['design_image_files'] == null
        ? []
        : json['design_image_files'].cast<String>();
    _designVideoFiles = json['design_video_files'] == null
        ? []
        : json['design_video_files'].cast<String>();
  }
}
