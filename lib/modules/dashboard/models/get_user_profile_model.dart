import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';

class GetUserProfileModel {
  late Data? _data;
  late String _message;
  late bool _success;
  late int _statusCode;

  Data? get data => _data;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  GetUserProfileModel.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'] ?? 'msg key null on profile api';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}

class Data {
  late String _name;
  late String _email;
  late String _userType;
  late String _mobileNo;
  late dynamic _pincode;
  late String _panNo;
  late String _gstNo;
  late dynamic _address;
  late String profileCircleName = '-';

  String get name => _name;

  String get userType => _userType;

  String get email => _email;

  String get mobileNo => _mobileNo;

  dynamic get pincode => _pincode;

  String get panNo => _panNo;

  String get gstNo => _gstNo;

  dynamic get address => _address;

  Data.fromJson(Map<String, dynamic> json) {
    _name = json['name'] ?? '';
    if (_name.trim().isNotEmpty) {
      try {
        _name = Helper.capitalizeWords(inputString: _name.toLowerCase()).trim();
        profileCircleName = _name[0];
        if (_name.contains(' ')) {
          List<String> temp = _name.split(' ');
          if (temp.isNotEmpty && temp.length >= 2) {
            profileCircleName = '${temp[0][0]}${temp[1][0]}';
          }
        }
      } catch (err) {
        profileCircleName = _name[0];
      }
    }
    _email = json['email'] ?? '';
    _userType = json['user_type'] ?? '';
    _mobileNo = json['mobile_no'] ?? '';
    _pincode = json['pincode'] ?? '';
    _panNo = json['pan_no'] ?? '';
    _gstNo = json['gst_no'] ?? '';
    _address = json['address'] ?? '';
  }
}
