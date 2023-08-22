import 'package:dio/dio.dart';
import 'package:nkm_nose_pins_llp/api/api_interceptor.dart';
import 'package:nkm_nose_pins_llp/config/env/env_config.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:nkm_nose_pins_llp/utils/helpers/preference_obj.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AuthTokenDioClient {
  static Dio? _dio;
  static ApiInterceptor? _apiInterceptor;

  static Dio? getAuthTokenDioClient() {
    if (_dio == null && PreferenceObj.getAuthToken.isNotEmpty) {
      _dio = Dio();
      _apiInterceptor = ApiInterceptor();
      _dio!.options.baseUrl = EnvConfig.instance.baseUrl;
      _dio!.interceptors.add(_apiInterceptor!);
      _dio!.options.connectTimeout = const Duration(
          milliseconds: CommonConstants.connectionTimeOutInMilliseconds);
      _dio!.options.receiveTimeout = const Duration(
          milliseconds: CommonConstants.receiveTimeOutInMilliseconds);
      _dio!.interceptors.add(PrettyDioLogger(requestBody: true));
    }
    return _dio;
  }
}
