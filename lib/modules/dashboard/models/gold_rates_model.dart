import 'package:get/get_rx/get_rx.dart';

class GoldRatesModel {
  late Data _data;
  late String _message;
  late bool _success;
  late int _statusCode;

  Data get data => _data;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  GoldRatesModel.fromJson(Map<String, dynamic> json) {
    _data = Data.fromJson(json['data']);
    _message = json['message'] ?? 'msg key null on gold rate api!';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}

class Data {
  late List<GoldCategory> _goldCategory;
  late List<GoldRate> _goldRate;

  List<GoldCategory> get goldCategory => _goldCategory;

  List<GoldRate> get goldRate => _goldRate;

  Data.fromJson(Map<String, dynamic> json) {
    _goldCategory = <GoldCategory>[];
    if (json['gold_category'] != null) {
      json['gold_category'].forEach((v) {
        GoldCategory goldCategory = GoldCategory.fromJson(v);
        if (goldCategory.status == 1) {
          _goldCategory.add(goldCategory);
        }
      });
      _goldCategory.sort(
        (a, b) => a.sortOrder.compareTo(b.sortOrder),
      );
    }

    _goldRate = <GoldRate>[];
    if (json['gold_rate'] != null) {
      json['gold_rate'].forEach((v) {
        GoldRate goldRate = GoldRate.fromJson(v);
        if (goldRate.status == 1) {
          _goldRate.add(goldRate);
        }
      });
      _goldRate.sort(
        (a, b) => a.sortOrder.compareTo(b.sortOrder),
      );
    }
  }
}

class GoldCategory {
  late String _label;
  late int _status;
  late int _value;
  late int _sortOrder;
  final RxBool isSelected = false.obs;

  String get label => _label;

  int get status => _status;

  int get value => _value;

  int get sortOrder => _sortOrder;

  GoldCategory.fromJson(Map<String, dynamic> json) {
    _label = json['label'] ?? '';
    _status = json['status'] ?? -1;
    _value = json['value'] ?? -1;
    _sortOrder = json['sort_order'] ?? -1;
  }
}

class GoldRate {
  late String _label;
  late int _status;
  late String _rate;
  late int _sortOrder;
  late String animK;

  String get label => _label;

  int get status => _status;

  String get rate => _rate;

  int get sortOrder => _sortOrder;

  GoldRate.fromJson(Map<String, dynamic> json) {
    _label = json['label'] ?? '';
    _status = json['status'] ?? -1;
    _rate = json['rate'] ?? '0';
    animK = _rate.replaceAll(',', '');
    _sortOrder = json['sort_order'] ?? -1;
  }
}
