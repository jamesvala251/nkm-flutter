import 'package:dio/dio.dart';
import 'package:nkm_nose_pins_llp/api/api_interceptor.dart';
import 'package:nkm_nose_pins_llp/api/api_urls.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/preference_obj.dart';

class AuthTokenDioClient {
  static Dio? _dio;
  static ApiInterceptor? _apiInterceptor;

  static Dio? getAuthTokenDioClient() {
    if (_dio == null && PreferenceObj.getAuthToken.isNotEmpty) {
      _dio = Dio();
      _apiInterceptor = ApiInterceptor();
      _dio!.options.baseUrl = ApiUrls.baseUrl;
      _dio!.interceptors.add(_apiInterceptor!);
      _dio!.options.connectTimeout = const Duration(
          milliseconds: CommonConstants.connectionTimeOutInMilliseconds);
      _dio!.options.receiveTimeout = const Duration(
          milliseconds: CommonConstants.receiveTimeOutInMilliseconds);
    }
    return _dio;
  }
}
