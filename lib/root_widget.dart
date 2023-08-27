import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nkm_nose_pins_llp/config/env/env_config.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_screens.dart';
import 'package:nkm_nose_pins_llp/config/theme/app_theme.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/preference_obj.dart';
import 'package:nkm_nose_pins_llp/utils/services/language_service.dart';

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: EnvConfig.instance.appName,
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
