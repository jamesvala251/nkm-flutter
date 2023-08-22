import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';

class RefundArticleListModel {
  late List<Data> _data;
  late String _message;
  late bool _success;
  late int _statusCode;

  List<Data> get data => _data;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  RefundArticleListModel.fromJson(Map<String, dynamic> json) {
    _data = <Data>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
    _message = json['message'] ?? 'msg key null on refund article list api!';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}

class Data {
  late int _id;
  late int _orderId;
  late String _articalNumber;
  late String _orderDetails;

  // late int _isWebMobile;
  late int _status;
  late int _userId;
  late int _designId;
  late int _designCaretId;
  late int _designArticleId;
  late int _caret;
  late int _weight;
  late int _orderMakingCharge;
  late int _orderGoldPrice;
  late int _orderTotalPrice;
  late int _orderGoldRate;
  late int _makingCharge;
  late int _goldPrice;
  late int _totalRefundAmount;
  late int _goldRate;
  late String _createdAt;

  // late String _updatedAt;
  late String _refundStatus;
  late Color _refundStatusColor;
  late String _caretLabel = '';
  late String _createdAtFormattedDate;

  int get id => _id;

  int get orderId => _orderId;

  String get articalNumber => _articalNumber;

  String get orderDetails => _orderDetails;

  // int get isWebMobile => _isWebMobile;

  int get status => _status;

  int get userId => _userId;

  int get designId => _designId;

  int get designCaretId => _designCaretId;

  int get designArticleId => _designArticleId;

  int get caret => _caret;

  int get weight => _weight;

  int get orderMakingCharge => _orderMakingCharge;

  int get orderGoldPrice => _orderGoldPrice;

  int get orderTotalPrice => _orderTotalPrice;

  int get orderGoldRate => _orderGoldRate;

  int get makingCharge => _makingCharge;

  int get goldPrice => _goldPrice;

  int get totalRefundAmount => _totalRefundAmount;

  int get goldRate => _goldRate;

  String get createdAt => _createdAt;

  String get createdAtFormattedDate => _createdAtFormattedDate;

  // String get updatedAt => _updatedAt;

  String get refundStatus => _refundStatus;

  Color get refundStatusColor => _refundStatusColor;

  String get caretLabel => _caretLabel;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _articalNumber = json['artical_number'] ?? '';
    _orderDetails = json['order_details'] ?? '';
    // _isWebMobile = json['is_web_mobile'];
    _status = json['status'] ?? -1;
    _userId = json['user_id'];
    _designId = json['design_id'];
    _designCaretId = json['design_caret_id'];
    _designArticleId = json['design_article_id'];
    _caret = json['caret'] ?? 0;
    _weight = json['weight'] ?? 0;
    _orderMakingCharge = json['order_making_charge'] ?? 0;
    _orderGoldPrice = json['order_gold_price'] ?? 0;
    _orderTotalPrice = json['order_total_price'] ?? 0;
    _orderGoldRate = json['order_gold_rate'] ?? 0;
    _makingCharge = json['making_charge'] ?? 0;
    _goldPrice = json['gold_price'] ?? 0;
    _totalRefundAmount = json['total_refund_amount'] ?? 0;
    _goldRate = json['gold_rate'] ?? 0;
    _createdAt = json['created_at'] ?? DateTime.now().toString();
    // _updatedAt = json['updated_at'];

    _createdAtFormattedDate =
        DateFormat('dd-MMM-yyyy hh:mm a').format(DateTime.parse(_createdAt));

    _caretLabel = CommonConstants.caretLabels[_caret] ?? '${_caret}K';

    _refundStatus = CommonConstants.refundArticleStatus[_status][0] ?? '-';

    _refundStatusColor = CommonConstants.refundArticleStatus[_status][1] ??
        Get.theme.primaryColor;
  }
}
