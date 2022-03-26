import 'package:dio/dio.dart';
import 'package:exchange_language_mobile/common/constants/http_constants.dart';

import 'auth_rest_client.dart';

class AppApiService {
  static const API_URL = 'http://localhost:8000/api/';

  final dio = Dio();
  late final AuthRestClient authRestClient;

  static final _instance = AppApiService._();

  factory AppApiService() => _instance;

  AppApiService._() {
    authRestClient = AuthRestClient(dio, baseUrl: '');

    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _addDioHeaders();
  }

  void _addDioHeaders({Map<String, String>? headers}) {
    dio.options.headers.clear();
    dio.options.headers[HttpConstants.contentType] = 'application/json';
    dio.options.connectTimeout = 15000;
    dio.options.receiveTimeout = 13000;
  }
}
