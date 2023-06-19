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
    _message = json['message'] ?? 'msg key null on version info api!';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}

class Data {
  // late int _id;
  late String _instructions;
  late String _versionName;
  late String _versionCode;
  late int _severity;

  // late int _type;
  //late String _createdAt;
  //late String _updatedAt;

  // int get id => _id;

  String get instructions => _instructions;

  String get versionName => _versionName;

  String get versionCode => _versionCode;

  int get severity => _severity;

  // int get type => _type;
  // String get createdAt => _createdAt;
  // String get updatedAt => _updatedAt;

  Data.fromJson(Map<String, dynamic> json) {
    // _id = json['id'];
    _instructions = json['instructions'] ?? '';
    _versionName = json['version_name'] ?? '';
    _versionCode = json['version_code'] ?? -1;
    _severity = json['severity'] ?? 1;
    // _type = json['type'] ?? -1;
    // _createdAt = json['created_at'] ?? '';
    // _updatedAt = json['updated_at'] ?? '';
  }
}
