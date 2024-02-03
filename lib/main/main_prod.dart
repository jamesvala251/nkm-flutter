import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/env/env_config.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:nkm_nose_pins_llp/main_app.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/preference_obj.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EnvConfig(
    envType: EnvTypeEnum.prod,
    appName: "NKM Nose Pins LLP",
    baseUrl: "https://nkmnosepinsllp.com/api/",
  );
  await PreferenceObj.init();
  if (PreferenceObj.getAuthToken.isNotEmpty) {
    Get.put(
      DashboardController(),
      permanent: true,
      tag: CommonConstants.dashboardControllerTag,
    );
  }
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: CommonConstants.firebaseOptionsAndroidProd,
    );
  } else {
    await Firebase.initializeApp();
  }
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
      runApp(const MainApp());
    },
  );
}
