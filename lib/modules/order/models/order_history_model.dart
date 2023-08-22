import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/modules/order/controllers/order_history_controller.dart';
import 'package:nkm_nose_pins_llp/utils/ui/ui_utils.dart';
import 'package:open_file/open_file.dart';

class OrderHistoryModel {
  late List<Data> _data;
  late String _message;
  late bool _success;
  late int _statusCode;
  // late int _totalCount;
  late int _perPage;
  late int _currentPage;

  List<Data> get data => _data;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  // int get totalCount => _totalCount;

  int get perPage => _perPage;

  int get currentPage => _currentPage;

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    _data = <Data>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
    _message = json['message'] ?? 'msg key null on order history api';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
    // _totalCount = json['total_count'] ?? 0;
    _perPage = json['per_page'] ?? 0;
    _currentPage = json['current_page'] ?? 0;
  }
}

class Data {
  late int _orderId;
  late String _orderDate;
  late String _orderNo;
  late int _totalQty;
  late String _totalPrice;
  late String _status;
  // late String _invoice;
  late String _customerInvoice;

  late Color statusColor = Get.theme.primaryColor;

  //for download
  final RxBool isDownloading = false.obs;
  final RxBool hasErrorWhileDownloading = false.obs;
  late String downloadErrorString = '';
  final RxString downloadPercentage = '0%'.obs;
  final RxString downloadedInvoicePath = ''.obs;

  int get orderId => _orderId;

  String get orderDate => _orderDate;

  String get orderNo => _orderNo;

  int get totalQty => _totalQty;

  String get totalPrice => _totalPrice;

  String get status => _status;

  // String get invoice => _invoice;

  String get customerInvoice => _customerInvoice;

  Data.fromJson(Map<String, dynamic> json) {
    _orderId = json['order_id'];
    _orderDate = json['order_date'] ?? '';
    _orderNo = json['order_no'] ?? '';
    _totalQty = json['total_qty'] ?? 0;
    _totalPrice = json['total_price'] ?? '';
    _status = json['status'] ?? '';
    // _invoice = json['invoice'] ?? '';
    _customerInvoice = json['customer_invoice'] ?? '';
    statusColor = _status.isNotEmpty
        ? _status.toLowerCase() == 'approved'
            ? Colors.green
            : _status.toLowerCase() == 'cancelled'
                ? Colors.red
                : statusColor
        : statusColor;
  }

  void downloadOrderInvoice() async {
    try {
      isDownloading.value = true;
      hasErrorWhileDownloading.value = false;
      downloadErrorString = '';
      downloadPercentage.value = '0%';
      String invoiceStorageDirectoryPath =
          await Get.find<OrderHistoryController>().getStorageDirectoryPath();

      final String invoiceName = '$_orderNo.pdf';
      File destinationFile = File('$invoiceStorageDirectoryPath/$invoiceName');

      if (await destinationFile.exists()) {
        isDownloading.value = false;
        hasErrorWhileDownloading.value = false;
        downloadErrorString = '';
        downloadPercentage.value = '100%';
        downloadedInvoicePath.value = destinationFile.path;
        UiUtils.successSnackBar(
          message: '$invoiceName is downloaded successfully!'.tr,
        );
        return;
      }

      // final String invoicePath = "$invoiceStorageDirectoryPath/$invoiceName";

      await Dio().downloadUri(
        Uri.parse(_customerInvoice),
        destinationFile.path,
        onReceiveProgress: (receivedBytes, totalBytes) {
          if (totalBytes != -1) {
            double percentage = receivedBytes / totalBytes * 100;
            downloadPercentage.value = '${percentage.toStringAsFixed(0)}%';
          }
        },
      );

      UiUtils.successSnackBar(
        message: '$invoiceName is downloaded successfully!'.tr,
      );

      isDownloading.value = false;
      hasErrorWhileDownloading.value = false;
      downloadErrorString = '';
      downloadPercentage.value = '0%';
      downloadedInvoicePath.value = destinationFile.path;
      return;
    } catch (err) {
      downloadErrorString = err.toString();
      isDownloading.value = false;
      hasErrorWhileDownloading.value = true;
      return;
    }
  }

  void openPDF() async {
    try {
      OpenFile.open(downloadedInvoicePath.value);
    } catch (err) {
      UiUtils.errorSnackBar(message: err.toString());
    }
  }
}
