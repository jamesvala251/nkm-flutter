import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/dio_client.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';
import 'package:nkm_nose_pins_llp/utils/services/firebase_deeplink_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';

class DesignListModel {
  late List<Data> _data;
  late String _message;
  late bool _success;
  late int _statusCode;

  List<Data> get data => _data;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  DesignListModel.fromJson(Map<String, dynamic> json) {
    _data = <Data>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
    _message = json['message'] ?? 'msg key null on design list api!';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}

class Data {
  late int _designId;
  late String _designName;
  late String _designWeight;
  late String _designImage;
  late int? _userCartId;
  late RxInt userCartQty = 0.obs;
  late bool _isCapitalized = false;
  late int _makingCharge;
  late int _goldPrice;
  late int _goldPricePerGram;
  late int _totalPrice;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  late String _downloadedImagePath = '';

  int get designId => _designId;

  String get designName => _designName;

  String get designWeight => _designWeight;

  String get designImage => _designImage;

  int get makingCharge => _makingCharge;

  int get goldPrice => _goldPrice;

  int get goldPricePerGram => _goldPricePerGram;

  int get totalPrice => _totalPrice;

  int? get userCartId => _userCartId;

  set setUserCartId(int? cartItemId) => _userCartId = cartItemId;

  Data.fromJson(Map<String, dynamic> json) {
    _designId = json['design_id'];
    _designName = json['design_name'] ?? '';
    if (!_isCapitalized && _designName.isNotEmpty) {
      _designName =
          Helper.capitalizeWords(inputString: _designName.toLowerCase());
      _isCapitalized = true;
    }
    _designWeight = json['design_weight'] ?? '';
    _makingCharge = json['making_charge'] ?? -1;
    _goldPrice = json['gold_price'] ?? -1;
    _goldPricePerGram = json['gold_price_per_gram'] ?? -1;
    _totalPrice = json['total_price'] ?? -1;
    _designImage = json['design_image'] ?? '';
    _userCartId = json['user_cart_id'];
    userCartQty.value = json['user_cart_qty'] ?? 0;
  }

  Data.fromJsonForDynamicLink(Map<String, dynamic> json) {
    _designId = int.parse(json['design_id']);
    _designName = json['design_name'] ?? '';
    if (!_isCapitalized && _designName.isNotEmpty) {
      _designName =
          Helper.capitalizeWords(inputString: _designName.toLowerCase());
      _isCapitalized = true;
    }
    _designWeight = json['design_weight'] ?? '';
    _makingCharge = int.parse(json['making_charge']) ?? -1;
    _goldPrice = int.parse(json['gold_price']) ?? -1;
    _goldPricePerGram = int.parse(json['gold_price_per_gram']) ?? -1;
    _totalPrice = int.parse(json['total_price']) ?? -1;
    _designImage = json['design_image'] ?? '';
    _userCartId = json['user_cart_id'].toString().toLowerCase() == "null"
        ? 0
        : int.parse(json['user_cart_id']);
    userCartQty.value = int.parse(json['user_cart_qty']) ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'design_id': _designId.toString(),
      'design_name': _designName,
      'design_weight': _designWeight,
      'making_charge': _makingCharge.toString(),
      'gold_price': _goldPrice.toString(),
      'gold_price_per_gram': _goldPricePerGram.toString(),
      'total_price': _totalPrice.toString(),
      'design_image': _designImage,
      'user_cart_id': _userCartId.toString(),
      'user_cart_qty': userCartQty.value.toString(),
    };
  }

  Future<void> shareImage({required String goldKarat}) async {
    try {
      if (_designImage.isEmpty) {
        return;
      }
      isLoading.value = true;
      hasError.value = false;

      if (_downloadedImagePath.isEmpty) {
        final response = await DioClient.getDioClient()!.get(
          _designImage,
          options: Options(responseType: ResponseType.bytes),
        );
        final tempDir = await getTemporaryDirectory();
        _downloadedImagePath = '${tempDir.path}/${_getImageNameFromUrl()}';
        await File(_downloadedImagePath).writeAsBytes(response.data);
      }

      String dynamicLink = await FirebaseDeepLinkService
          .createFirebaseShortDynamicLinkForProductDesignDetailsScreen(
        designListItemModel: this,
        goldKarat: goldKarat,
      );

      String descriptionTxt =
          """ $_designName ($_designWeight)\n${'karat'.tr}: ${goldKarat}K,\n${'gold_rate_pr_gram'.tr}: $_goldPricePerGram,\n${'gold_price'.tr}: $_goldPrice${dynamicLink.isNotEmpty ? '\n\n${'dynamic_link_click_below'.tr}\n\n$dynamicLink' : ''}""";

      await Share.shareXFiles(
        [XFile(_downloadedImagePath)],
        text: descriptionTxt,
      );
      isLoading.value = false;
      hasError.value = false;
      return;
    } catch (err) {
      hasError.value = true;
      isLoading.value = false;
      return;
    }
  }

  String _getImageNameFromUrl() {
    try {
      if (_designImage.isEmpty) {
        return '${DateTime.now().microsecondsSinceEpoch}.jpg';
      }
      String imageName = path.basename(_designImage);
      return imageName;
    } catch (err) {
      return '${DateTime.now().microsecondsSinceEpoch}.jpg';
    }
  }
}
