class UpdateUserProfile {
  late Data? _data;
  late String _message;
  late bool _success;
  late int _statusCode;

  Data? get data => _data;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  UpdateUserProfile.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'] ?? 'msg key null on update prof. api';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}

class Data {
  late int? _id;
  late String _name;
  late String _email;
  late String _mobileNo;
  late dynamic _pincode;
  late dynamic _panNo;
  late dynamic _gstNo;
  late dynamic _address;
  late String _fcmToken;
  late String _userType;

  int? get id => _id;

  String get name => _name;

  String get email => _email;

  String get mobileNo => _mobileNo;

  dynamic get pincode => _pincode;

  dynamic get panNo => _panNo;

  dynamic get gstNo => _gstNo;

  dynamic get address => _address;

  String get fcmToken => _fcmToken;

  String get userType => _userType;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'] ?? '';
    _email = json['email'] ?? '';
    _mobileNo = json['mobile_no'] ?? '';
    _pincode = json['pincode'] ?? '';
    _panNo = json['pan_no'] ?? '';
    _gstNo = json['gst_no'] ?? '';
    _address = json['address'] ?? '';
    _fcmToken = json['fcm_token'] ?? '';
    _userType = json['user_type'] ?? '';
  }
}
