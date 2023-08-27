import 'package:dio/dio.dart';
import 'package:nkm_nose_pins_llp/config/env/env_config.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static Dio? _dio;

  static Dio? getDioClient() {
    if (_dio == null) {
      _dio = Dio();
      _dio!.options.baseUrl = EnvConfig.instance.baseUrl;
      _dio!.options.connectTimeout = const Duration(
          milliseconds: CommonConstants.connectionTimeOutInMilliseconds);
      _dio!.options.receiveTimeout = const Duration(
          milliseconds: CommonConstants.receiveTimeOutInMilliseconds);
      _dio!.interceptors.add(PrettyDioLogger(requestBody: true));
    }
    return _dio;
  }
}
