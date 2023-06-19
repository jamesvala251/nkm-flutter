import 'package:dio/dio.dart';
import 'package:nkm_nose_pins_llp/api/api_urls.dart';
import 'package:nkm_nose_pins_llp/constants/common_constants.dart';

class DioClient {
  static Dio? _dio;

  static Dio? getDioClient() {
    if (_dio == null) {
      _dio = Dio();
      _dio!.options.baseUrl = ApiUrls.baseUrl;
      _dio!.options.connectTimeout = const Duration(
          milliseconds: CommonConstants.connectionTimeOutInMilliseconds);
      _dio!.options.receiveTimeout = const Duration(
          milliseconds: CommonConstants.receiveTimeOutInMilliseconds);
    }
    return _dio;
  }
}
