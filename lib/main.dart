import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_screens.dart';
import 'package:nkm_nose_pins_llp/config/theme/app_theme.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/constants/string_constants.dart';
import 'package:nkm_nose_pins_llp/firebase_options.dart';
import 'package:nkm_nose_pins_llp/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/preference_obj.dart';
import 'package:nkm_nose_pins_llp/utils/services/language_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceObj.init();
  if (PreferenceObj.getAuthToken.isNotEmpty) {
    Get.put(
      DashboardController(),
      permanent: true,
      tag: CommonConstants.dashboardControllerTag,
    );
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
      runApp(
        GetMaterialApp(
          title: StringConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          initialRoute: PreferenceObj.getAuthToken.isNotEmpty
              ? AppRoutes.dashboardScreen
              : PreferenceObj.getIsUserFirstTime
                  ? AppRoutes.registerScreen
                  : AppRoutes.loginScreen,
          getPages: AppScreens.list,
          locale: (PreferenceObj.getLanguageCode == null ||
                  PreferenceObj.getCountryCode == null)
              ? const Locale('en', 'US')
              : Locale(
                  PreferenceObj.getLanguageCode!,
                  PreferenceObj.getCountryCode!,
                ),
          translations: LocaleString(),
        ),
      );
    },
  );
}
