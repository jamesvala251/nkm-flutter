import 'dart:io';
import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Helper {
  static String getErrMsgFromDioError({
    required DioException dioError,
  }) {
    if (dioError.type == DioExceptionType.connectionError ||
        dioError.type == DioExceptionType.unknown) {
      if (dioError.error is SocketException) {
        return 'network_error_desc'.tr;
      }
      return 'something_went_wrong'.tr;
    } else if (dioError.type == DioExceptionType.badResponse) {
      if (dioError.response == null || dioError.response!.data == null) {
        return 'something_went_wrong'.tr;
      } else if (dioError.response!.statusCode == 401 ||
          dioError.response!.statusCode == 400) {
        return dioError.response!.data['message'];
      } else if (dioError.response!.statusCode == 422) {
        return dioError.response!.data['message'];
      } else if (dioError.response!.statusCode == 429) {
        return dioError.response!.statusMessage ?? 'something_went_wrong'.tr;
      } else if (dioError.response!.statusCode == 404) {
        return '404_err_msg'.tr;
      } else if (dioError.response!.statusCode == 500) {
        if (dioError.response!.statusMessage == null) {
          return 'internal_server_err'.tr;
        }
        return dioError.response!.statusMessage!;
      }
      return 'something_went_wrong'.tr;
    } else if (dioError.type == DioExceptionType.connectionTimeout) {
      return 'connection_timeout_err'.tr;
    } else if (dioError.type == DioExceptionType.receiveTimeout) {
      return 'receive_timeout'.tr;
    } else if (dioError.type == DioExceptionType.sendTimeout) {
      return 'send_timeout'.tr;
    } else if (dioError.type == DioExceptionType.cancel) {
      return 'req_canceled'.tr;
    }
    return 'something_went_wrong'.tr;
  }

  static double getFileSizeInMb({required String filePath}) {
    File fileObj = File(filePath);
    int fileLengthInBytes = fileObj.readAsBytesSync().lengthInBytes;
    double fileSizeInMb = fileLengthInBytes /
        1048576; //Note:- 1048576 = 1024 * 1024 so don't get confused
    return fileSizeInMb;
  }

  static Color parseColor(String hexCode, {double? opacity}) {
    try {
      return Color(int.parse(hexCode.replaceAll("#", "0xFF")))
          .withOpacity(opacity ?? 1);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
    }
  }

  static String generateRandom6DigitOTP() {
    int min = 100000; //min and max values act as your 6 digit range
    int max = 999999;
    var rNum = min + math.Random().nextInt(max - min);
    return rNum.toString();
  }

  static bool checkIsEmptyOrNullForStringAndInt(Object? object) {
    if (object == null) {
      return true;
    } else if (object.toString().isEmpty) {
      return true;
    }
    return false;
  }

  static String getWeekDayShortNameFromNo({required int dayNo}) {
    if (dayNo == 1) {
      return 'Mon';
    } else if (dayNo == 2) {
      return 'Tue';
    } else if (dayNo == 3) {
      return 'Wed';
    } else if (dayNo == 4) {
      return 'Thi';
    } else if (dayNo == 5) {
      return 'Fri';
    } else if (dayNo == 6) {
      return 'Sat';
    } else {
      return 'Sun';
    }
  }

  static math.Random random = math.Random();
  static List<Color> randomColorList = <Color>[
    Colors.blueGrey.shade100,
    Colors.cyan.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.grey.shade200,
    Colors.black38
  ];

  static Color getRandomColor() {
    int randomNumber = random.nextInt(randomColorList.length);
    return randomColorList[randomNumber];
  }

  static String getImageExtension({required String imageUrl}) {
    try {
      final String path = imageUrl.split('/').last;
      final List<String> parts = path.split('.');
      return parts.length > 1 ? parts.last : 'png';
    } catch (_) {
      return 'png';
    }
  }

  static String getVideoExtension({required String videoUrl}) {
    try {
      final String path = videoUrl.split('/').last;
      final List<String> parts = path.split('.');
      return parts.length > 1 ? parts.last : 'mp4';
    } catch (_) {
      return 'mp4';
    }
  }

  static String capitalizeWords({required String inputString}) {
    try {
      final words = inputString.split(' ');
      final capitalizedWords = words.map((word) => capitalize(word));
      return capitalizedWords.join(' ');
    } catch (_) {
      return '';
    }
  }

  static String capitalize(String input) {
    try {
      if (input.isEmpty) return input;
      return input[0].toUpperCase() + input.substring(1);
    } catch (_) {
      return '';
    }
  }
}
