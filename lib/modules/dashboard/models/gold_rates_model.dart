class GoldRatesModel {
  late Data? _data;
  late String _message;
  late bool _success;
  late int _statusCode;

  Data? get data => _data;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  GoldRatesModel.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'] ?? 'msg key null in gold rates api';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}

class Data {

  late String _s14k;
  late String _s18k;
  late String _s20k;
  late String _s22k;
  late String _s24k;
  //for animation
  late String anim14k;
  late String anim18k;
  late String anim24k;

  String get s14k => _s14k;

  String get s18k => _s18k;

  String get s20k => _s20k;

  String get s22k => _s22k;

  String get s24k => _s24k;

  Data.fromJson(Map<String, dynamic> json) {
    _s14k = json['14k'] ?? '0';
    anim14k = _s14k.replaceAll(',', '');
    _s18k = json['18k'] ?? '0';
    anim18k = _s18k.replaceAll(',', '');
    _s20k = json['20k'] ?? '0';
    _s22k = json['22k'] ?? '0';
    _s24k = json['24k'] ?? '0';
    anim24k = _s24k.replaceAll(',', '');
  }
}
