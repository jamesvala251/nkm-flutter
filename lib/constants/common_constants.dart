import 'package:firebase_core/firebase_core.dart';
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

  static const FirebaseOptions firebaseOptionsAndroidProd = FirebaseOptions(
    apiKey: 'AIzaSyCZOiCsxdfQxuGfBw-_yku4QOI1bPP2lCU',
    appId: '1:534290823844:android:ff5197989aa8d73fe0c431',
    messagingSenderId: '534290823844',
    projectId: 'nkm-nose-pins-llp-80f0b',
    storageBucket: 'nkm-nose-pins-llp-80f0b.appspot.com',
  );

  static const FirebaseOptions firebaseOptionsIosProd = FirebaseOptions(
    apiKey: 'AIzaSyBGNdr0ZZGssYoLzyqBWrLjU0ALUodBH3A',
    appId: '1:534290823844:ios:27dfbff798e628b8e0c431',
    messagingSenderId: '534290823844',
    projectId: 'nkm-nose-pins-llp-80f0b',
    storageBucket: 'nkm-nose-pins-llp-80f0b.appspot.com',
    androidClientId: '534290823844-76uhk2hqn5jj38bpld8qhuhjqponvntf.apps.googleusercontent.com',
    iosClientId: '534290823844-aqa1il7l223uptv4nb4sn0ahljh4od73.apps.googleusercontent.com',
    iosBundleId: 'com.org.nkmNosePinsLlp',
  );

  static const FirebaseOptions firebaseOptionsAndroidDev = FirebaseOptions(
    apiKey: 'AIzaSyDE-xH42ol2qjx3nfpaFxylmhC7ej2P9LQ',
    appId: '1:561690903886:android:3f879556007bb55c92ca1f',
    messagingSenderId: '561690903886',
    projectId: 'nkm-llp-dev',
    storageBucket: 'nkm-llp-dev.appspot.com',
  );

  static const FirebaseOptions firebaseOptionsIosDev = FirebaseOptions(
    apiKey: 'AIzaSyAnlt5NBuQkmSnsFwVHAm7oWI5DnnkpmMc',
    appId: '1:561690903886:ios:8bf8b578790bc54592ca1f',
    messagingSenderId: '561690903886',
    projectId: 'nkm-llp-dev',
    storageBucket: 'nkm-llp-dev.appspot.com',
    iosClientId:
        '561690903886-lfg4kgfum4gg9f0jltti8bk8i9onp8m7.apps.googleusercontent.com',
    iosBundleId: 'com.org.nkmnosepinsllp.dev',
  );
}
