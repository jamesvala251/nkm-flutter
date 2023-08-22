import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonConstants {
  static const int connectionTimeOutInMilliseconds = 180000;
  static const int receiveTimeOutInMilliseconds = 180000;
  static const int errorMilliseconds = 1000;
  static const int errorLongMilliseconds = 3000;

  static const Map<String, String> xWwwFromUrlEncodedHeader = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static const Map<String, String> applicationJsonHeader = {
    'Content-Type': 'application/json'
  };

  static const Map<String, String> multipartFormDataHeader = {
    'Content-Type': 'multipart/form-data'
  };

  static const String regular = "proxima_nova_regular";
  static const String bold = "proxima_nova_bold";
  static const String thin = "proxima_nova_thin";

  //TODO For Video and Image Upload Size
  static const int capturedImageQuality = 60;
  static const int pickedImageQuality = 70;

  static const double imageUploadSizeInMb = 10;

  //Theme Constants
  static const int lightThemeFlag = 1;
  static const int darkThemeFlag = 2;
  static const int autoThemeFlag = 3;

  //For Method Channel
  static const String getAndroidVersionMethod = "getAndroidVersion";
  static const String getVersionNameAndVersionCodeMethod =
      "getVersionNameAndVersionCode";
  static const String nkmMethodChannel =
      "com.org.nkm_nose_pins_llp/common_channel";
  static const String nkmNosePinsLLPFolderName =
      'nkm_nose_pins_llp_order_invoice';
  static const String nativeDataMapKeyVersionName = "version_name";
  static const String nativeDataMapKeyVersionCode = "version_code";
  static const String nativeDataMapKeyPackageName = "package_name";

  //Login Type
  static const int loginTypeUser = 1;
  static const int loginTypeAdmin = 2;
  static const int appUpdateSeverityForceUpdate = 1;
  static const int appUpdateSeverityOptionUpdate = 2;

  //Firebase Dynamic Link Keys
  static const String designIdDynamicLinkKey = 'design_id';
  static const String designNameDynamicLinkKey = 'design_name';
  static const String goldKaratDynamicLinkKey = 'gold_karat';
  static const String screenNameDynamicLinkKey = 'article_list_screen';
  static const String dashboardControllerTag = 'dashboard_controller_tag';

  //Payment Option
  static const int paymentModeCash = 1;
  static const int paymentModeOnline = 2;

  //possible caret label
  static const Map<int, String> caretLabels = {
    18: '18K',
    24: '24K',
    22: '22K',
    20: '20K',
    14: '14K',
    52: 'SNKP',
    62: 'NKM',
  };

  //Refund Article Status
  static Map<int, dynamic> refundArticleStatus = {
    1: ['Pending', Get.theme.primaryColor],
    2: ['Approved', Colors.green],
    3: ['Approved', Colors.green],
    4: ['Rejected', Colors.red],
  };
}
