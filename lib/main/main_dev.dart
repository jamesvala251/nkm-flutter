import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/env/env_config.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:nkm_nose_pins_llp/root_widget.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/preference_obj.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EnvConfig(
    envType: EnvTypeEnum.dev,
    appName: "NKM LLP-Dev",
    baseUrl: "http://13.126.207.50/api/",
    // baseUrl: "http://3.6.39.35/api/",
  );
  await PreferenceObj.init();
  if (PreferenceObj.getAuthToken.isNotEmpty) {
    Get.put(
      DashboardController(),
      permanent: true,
      tag: CommonConstants.dashboardControllerTag,
    );
  }
  await Firebase.initializeApp(
    options: Platform.isAndroid
        ? CommonConstants.firebaseOptionsAndroidDev
        : CommonConstants.firebaseOptionsIosDev,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) async {
      runApp(const RootWidget());
    },
  );
}
