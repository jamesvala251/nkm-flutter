import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/api/dio_client.dart';
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
  late int _id;
  late int _caretId;
  late String _name;
  late RxInt articleCount = 0.obs;
  late List<String> _images;
  late List<String> _videos;
  final RxBool isLoadingImage = false.obs;
  final RxBool hasErrorInImage = false.obs;
  late String _downloadedImagePath = '';

  final RxBool isLoadingVideo = false.obs;
  final RxBool hasErrorInVideo = false.obs;
  late String _downloadedVideoPath = '';

  int get id => _id;

  int get caretId => _caretId;

  String get name => _name;

  List<String> get images => _images;

  List<String> get videos => _videos;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _caretId = json['caret_id'];
    _name = json['name'] ?? '';
    articleCount.value = json['article_count'] ?? 0;
    _images = <String>[];
    if (json['images'] != null) {
      _images = json['images'].cast<String>();
    }
    _videos = <String>[];
    if (json['videos'] != null) {
      _videos = json['videos'].cast<String>();
    }
  }

  Future<void> shareImage({
    required String goldKarat,
    required int imageIndex,
  }) async {
    try {
      if (_images.isEmpty) {
        return;
      }
      isLoadingImage.value = true;
      hasErrorInImage.value = false;

      if (_downloadedImagePath.isEmpty) {
        final response = await DioClient.getDioClient()!.get(
          _images[imageIndex],
          options: Options(responseType: ResponseType.bytes),
        );
        final tempDir = await getTemporaryDirectory();
        _downloadedImagePath = '${tempDir.path}/${_getImageNameFromUrl()}';
        await File(_downloadedImagePath).writeAsBytes(response.data);
      }

      String dynamicLink = await FirebaseDeepLinkService
          .createFirebaseShortDynamicLinkForArticleListScreen(
        designId: id.toString(),
        designName: name,
        goldKarat: goldKarat,
      );

      String descriptionTxt =
          """ $name \n${'karat'.tr}: ${goldKarat}K ${dynamicLink.isNotEmpty ? '\n\n${'dynamic_link_click_below'.tr}\n\n$dynamicLink' : ''}""";

      await Share.shareXFiles(
        [XFile(_downloadedImagePath)],
        text: descriptionTxt,
      );
      isLoadingImage.value = false;
      hasErrorInImage.value = false;
      return;
    } catch (err) {
      hasErrorInImage.value = true;
      isLoadingImage.value = false;
      return;
    }
  }

  Future<void> shareVideo({
    required String goldKarat,
  }) async {
    try {
      isLoadingVideo.value = true;
      hasErrorInVideo.value = false;

      if (videos.isEmpty) {
        isLoadingVideo.value = false;
        hasErrorInVideo.value = false;
      }

      if (_downloadedVideoPath.isEmpty) {
        final response = await DioClient.getDioClient()!.get(
          videos.first.trim(),
          options: Options(responseType: ResponseType.bytes),
        );
        final tempDir = await getTemporaryDirectory();
        _downloadedVideoPath = '${tempDir.path}/${_getVideoNameFromUrl()}';
        await File(_downloadedVideoPath).writeAsBytes(response.data);
      }

      String dynamicLink = await FirebaseDeepLinkService
          .createFirebaseShortDynamicLinkForArticleListScreen(
        designId: id.toString(),
        designName: name,
        goldKarat: goldKarat,
      );

      String descriptionTxt =
          """ $name \n${'karat'.tr}: ${goldKarat}K ${dynamicLink.isNotEmpty ? '\n\n${'dynamic_link_click_below'.tr}\n\n$dynamicLink' : ''}""";

      await Share.shareXFiles(
        [XFile(_downloadedVideoPath)],
        text: descriptionTxt,
      );
      isLoadingVideo.value = false;
      hasErrorInVideo.value = false;
      return;
    } catch (err) {
      hasErrorInVideo.value = true;
      isLoadingVideo.value = false;
      return;
    }
  }

  String _getVideoNameFromUrl() {
    try {
      if (videos.isEmpty) {
        return '${DateTime.now().microsecondsSinceEpoch}.mp4';
      }
      return path.basename(videos.first);
    } catch (err) {
      return '${DateTime.now().microsecondsSinceEpoch}.mp4';
    }
  }

  String _getImageNameFromUrl() {
    try {
      if (_images.isEmpty) {
        return '${DateTime.now().microsecondsSinceEpoch}.jpg';
      }
      String imageName = path.basename(_images.first);
      return imageName;
    } catch (err) {
      return '${DateTime.now().microsecondsSinceEpoch}.jpg';
    }
  }
}
