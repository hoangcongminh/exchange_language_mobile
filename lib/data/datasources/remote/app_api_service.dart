import 'package:dio/dio.dart';
import 'package:exchange_language_mobile/common/constants/http_constants.dart';

import '../../../common/constants/app_constants.dart';
import 'auth_rest_client.dart';

class AppApiService {
  final dio = Dio();
  late final AuthRestClient authRestClient;

  static final _instance = AppApiService._();

  factory AppApiService() => _instance;

  AppApiService._() {
    authRestClient = AuthRestClient(dio, baseUrl: AppConstants.baseUrl);

    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    addDioHeaders();
  }

  void addDioHeaders({Map<String, String>? headers}) {
    dio.options.headers.clear();
    dio.options.headers[HttpConstants.contentType] = 'application/json';
    dio.options.connectTimeout = 15000;
    dio.options.receiveTimeout = 13000;
    dio.options.headers[HttpConstants.authorization] =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjNmZmM2ZmQ5OTBkNDRjM2YxMzVlZjYiLCJpYXQiOjE2NDgzNzQ5MTV9._kP-XnMJQqFzIBUzqY2IEtwlYi8FfzkOVfq1toPAzik';
  }
}
