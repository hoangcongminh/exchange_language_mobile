import 'package:dio/dio.dart';
import 'package:exchange_language_mobile/data/datasources/local/user_local_data.dart';
import 'package:exchange_language_mobile/data/datasources/remote/language_rest_client.dart';
import 'package:exchange_language_mobile/data/datasources/remote/media_rest_client.dart';

import '../../../common/constants/app_constants.dart';
import '../../../common/constants/http_constants.dart';
import 'auth_rest_client.dart';

class AppApiService {
  final dio = Dio();
  late final AuthRestClient authRestClient;
  late final MediaRestClient mediaRestClient;
  late final LanguageRestClient languageRestClient;

  static final _instance = AppApiService._();

  factory AppApiService() => _instance;

  AppApiService._() {
    authRestClient = AuthRestClient(dio, baseUrl: AppConstants.baseUrl);
    mediaRestClient = MediaRestClient(dio, baseUrl: AppConstants.baseUrl);
    languageRestClient = LanguageRestClient(dio, baseUrl: AppConstants.baseUrl);

    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    dio.options.headers.clear();
    dio.options.headers[HttpConstants.contentType] = 'application/json';
    dio.options.connectTimeout = 15000;
    dio.options.receiveTimeout = 13000;
  }
  void setToken(String authToken) {
    dio.options.headers['Authorization'] = 'Bearer $authToken';
  }

  Future<void> clientSetup() async {
    final String authToken = UserLocal().getAccessToken();
    if (authToken.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $authToken';
    }
  }

  // // void addDioHeaders({Map<String, String>? headers}) {
  // void addDioHeaders({String? token}) {
  //   dio.options.headers.clear();
  //   dio.options.headers[HttpConstants.contentType] = 'application/json';
  //   dio.options.connectTimeout = 15000;
  //   dio.options.receiveTimeout = 13000;
  //   if (token != null) {
  //     dio.options.headers[HttpConstants.authorization] = 'Bearer $token';
  //   }
  //   /* dio.options.headers[HttpConstants.authorization] = */
  //   /*     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjNmZmM2ZmQ5OTBkNDRjM2YxMzVlZjYiLCJpYXQiOjE2NDgzNzQ5MTV9._kP-XnMJQqFzIBUzqY2IEtwlYi8FfzkOVfq1toPAzik'; */
  // }
}
