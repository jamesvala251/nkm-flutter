class VersionInfoModel {
  late Data? _data;
  late String _message;
  late bool _success;
  late int _statusCode;

  Data? get data => _data;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  VersionInfoModel.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'] ?? '';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}

class Data {
  // late int _id;
  late String _versionName;
  late String _instructions;
  late int _versionCode;
  late int _severity;

  // late int _type;
  // late String _createdAt;
  // late String _updatedAt;

  // int get id => _id;
  String get versionName => _versionName;

  String get instructions => _instructions;

  int get versionCode => _versionCode;

  int get severity => _severity;

  // int get type => _type;
  // String get createdAt => _createdAt;
  // String get updatedAt => _updatedAt;

  Data.fromJson(Map<String, dynamic> json) {
    // _id = json['id'];
    _versionName = json['version_name'] ?? '1.0.0';
    _instructions = json['instructions'] ?? '';
    _versionCode = json['version_code'] ?? 1;
    _severity = json['severity'] ?? 1;
    // _type = json['type'];
    // _createdAt = json['created_at'];
    // _updatedAt = json['updated_at'];
  }
}
