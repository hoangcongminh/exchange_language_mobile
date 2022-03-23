import 'package:dio/dio.dart';
import 'package:exchange_language_mobile/common/constants/http_constants.dart';

class AppApiService {
  static const API_URL = 'http://localhost:8000/api/';

  final dio = Dio();

  static final _instance = AppApiService._();

  factory AppApiService() => _instance;

  AppApiService._() {
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
