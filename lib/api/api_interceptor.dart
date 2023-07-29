import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:nkm_nose_pins_llp/config/routes/app_routes.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/preference_obj.dart';
import 'package:nkm_nose_pins_llp/utils/ui/ui_utils.dart';

class ApiInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["Authorization"] = "Bearer ${PreferenceObj.getAuthToken}";
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response != null && err.response!.statusCode == 401) {
      PreferenceObj.clearPreferenceDataAndLogout();
      UiUtils.errorSnackBar(message: 'Session Expired,Please login again!');
      Get.offAllNamed(
        AppRoutes.loginScreen,
      );
      return handler.next(err);
    }
    return handler.next(err);
  }
}
