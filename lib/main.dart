import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_screens.dart';
import 'package:nkm_nose_pins_llp/config/theme/app_theme.dart';
import 'package:nkm_nose_pins_llp/constants/string_constants.dart';
import 'package:nkm_nose_pins_llp/firebase_options.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/preference_obj.dart';
import 'package:nkm_nose_pins_llp/utils/services/language_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PreferenceObj.init();
  await Future.delayed(const Duration(seconds: 1));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: StringConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: PreferenceObj.getAuthToken.isNotEmpty
          ? AppRoutes.dashboardScreen
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
    );
  }
}
