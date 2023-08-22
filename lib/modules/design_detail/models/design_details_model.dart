// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:nkm_nose_pins_llp/api/dio_client.dart';
// import 'package:nkm_nose_pins_llp/utils/helpers/helper.dart';
// import 'package:nkm_nose_pins_llp/utils/services/firebase_deeplink_service.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:nkm_nose_pins_llp/modules/dashboard/models/design_list_model.dart'
//     as design_cate_item_as;
// import 'package:share_plus/share_plus.dart';
// import 'package:path/path.dart' as path;
//
// class DesignDetailsModel {
//   late Data? _data;
//   late String _message;
//   late bool _success;
//   late int _statusCode;
//
//   Data? get data => _data;
//
//   String get message => _message;
//
//   bool get success => _success;
//
//   int get statusCode => _statusCode;
//
//   DesignDetailsModel.fromJson(Map<String, dynamic> json) {
//     _data = json['data'] != null ? Data.fromJson(json['data']) : null;
//     _message = json['message'] ?? 'msg key is null in design details api!';
//     _success = json['success'] ?? false;
//     _statusCode = json['status_code'] ?? -1;
//   }
// }
//
// class Data {
//   late int _designId;
//   late String _designName;
//   late String _designWeight;
//   late String _designCaret;
//   late int _designQty;
//   late int _designRatePerGm;
//   late int _designPrice;
//   late int _designMakingCharge;
//   late int _designTotal;
//   late String _designImage;
//   late List<String> _designImageFiles;
//   late List<String> _designVideoFiles;
//   late bool _isCapitalized = false;
//   final RxBool isLoading = false.obs;
//   final RxBool hasError = false.obs;
//   late String _downloadedVideoPath = '';
//   late RxBool isSNKPOrNkm = false.obs;
//
//   int get designId => _designId;
//
//   String get designName => _designName;
//
//   String get designWeight => _designWeight;
//
//   String get designCaret => _designCaret;
//
//   int get designQty => _designQty;
//
//   int get designRatePerGm => _designRatePerGm;
//
//   int get designPrice => _designPrice;
//
//   int get designMakingCharge => _designMakingCharge;
//
//   int get designTotal => _designTotal;
//
//   String get designImage => _designImage;
//
//   List<String> get designImageFiles => _designImageFiles;
//
//   List<String> get designVideoFiles => _designVideoFiles;
//
//   Data.fromJson(Map<String, dynamic> json) {
//     _designId = json['design_id'];
//     _designName = json['design_name'] ?? '';
//     if (!_isCapitalized && _designName.isNotEmpty) {
//       _designName =
//           Helper.capitalizeWords(inputString: _designName.toLowerCase());
//       _isCapitalized = true;
//     }
//     _designWeight = json['design_weight'] ?? '';
//     _designCaret = json['design_caret'] ?? '';
//
//     if (_designCaret.isNotEmpty) {
//       isSNKPOrNkm.value = _designCaret.trim().toLowerCase() == 'snkp' ||
//           _designCaret.trim().toLowerCase() == 'nkm';
//     }
//
//     _designQty = json['design_qty'] ?? 0;
//     _designRatePerGm = json['design_rate_per_gm'] ?? 0;
//     _designPrice = json['design_price'] ?? 0;
//     _designMakingCharge = json['design_making_charge'] ?? 0;
//     _designTotal = json['design_total'] ?? 0;
//     _designImage = json['design_image'] ?? '';
//     _designImageFiles = json['design_image_files'] == null
//         ? []
//         : json['design_image_files'].cast<String>();
//     _designVideoFiles = json['design_video_files'] == null
//         ? []
//         : json['design_video_files'].cast<String>();
//   }
//
//   Future<void> shareVideo({
//     required String goldKarat,
//     required design_cate_item_as.Data data,
//   }) async {
//     try {
//       if (designVideoFiles.isEmpty) {
//         return;
//       }
//       isLoading.value = true;
//       hasError.value = false;
//
//       if (_downloadedVideoPath.isEmpty) {
//         final response = await DioClient.getDioClient()!.get(
//           designVideoFiles.first.trim(),
//           options: Options(responseType: ResponseType.bytes),
//         );
//         final tempDir = await getTemporaryDirectory();
//         _downloadedVideoPath = '${tempDir.path}/${_getVideoNameFromUrl()}';
//         await File(_downloadedVideoPath).writeAsBytes(response.data);
//       }
//
//       String dynamicLink = await FirebaseDeepLinkService
//           .createFirebaseShortDynamicLinkForProductDesignDetailsScreen(
//         designListItemModel: data,
//         goldKarat: goldKarat,
//       );
//
//       String descriptionTxt =
//           """ $_designName ($_designWeight)\n${'karat'.tr}: ${goldKarat}K,\n${'gold_rate_pr_gram'.tr}: $_designRatePerGm,\n${'gold_price'.tr}: $_designPrice${dynamicLink.isNotEmpty ? '\n\n${'dynamic_link_click_below'.tr}\n\n$dynamicLink' : ''}""";
//
//       await Share.shareXFiles(
//         [XFile(_downloadedVideoPath)],
//         text: descriptionTxt,
//       );
//       isLoading.value = false;
//       hasError.value = false;
//       return;
//     } catch (err) {
//       hasError.value = true;
//       isLoading.value = false;
//       return;
//     }
//   }
//
//   String _getVideoNameFromUrl() {
//     try {
//       if (designVideoFiles.isEmpty) {
//         return '${DateTime.now().microsecondsSinceEpoch}.mp4';
//       }
//       return path.basename(designVideoFiles.first);
//     } catch (err) {
//       return '${DateTime.now().microsecondsSinceEpoch}.mp4';
//     }
//   }
// }
