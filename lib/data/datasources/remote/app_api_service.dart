import 'package:dio/dio.dart';
import 'package:exchange_language_mobile/data/datasources/local/user_local_data.dart';
import 'package:exchange_language_mobile/data/datasources/remote/blog_rest_client.dart';
import 'package:exchange_language_mobile/data/datasources/remote/filter_rest_client.dart';
import 'package:exchange_language_mobile/data/datasources/remote/language_rest_client.dart';
import 'package:exchange_language_mobile/data/datasources/remote/media_rest_client.dart';

import '../../../common/constants/app_constants.dart';
import '../../../common/constants/http_constants.dart';
import 'auth_rest_client.dart';
import 'chat_rest_client.dart';
import 'group_rest_client.dart';

class AppApiService {
  final dio = Dio();
  late final AuthRestClient authRestClient =
      AuthRestClient(dio, baseUrl: AppConstants.baseUrl);
  late final MediaRestClient mediaRestClient =
      MediaRestClient(dio, baseUrl: AppConstants.baseUrl);
  late final LanguageRestClient languageRestClient =
      LanguageRestClient(dio, baseUrl: AppConstants.baseUrl);
  late final FilterRestClient filterRestClient =
      FilterRestClient(dio, baseUrl: AppConstants.baseUrl);
  late final ChatRestCient chatRestCient =
      ChatRestCient(dio, baseUrl: AppConstants.baseUrl);
  late final BlogRestClient blogRestClient =
      BlogRestClient(dio, baseUrl: AppConstants.baseUrl);
  late final GroupRestClient groupRestClient =
      GroupRestClient(dio, baseUrl: AppConstants.baseUrl);

  static final _instance = AppApiService._();

  factory AppApiService() => _instance;

  AppApiService._() {
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    dio.options.headers.clear();
    dio.options.headers[HttpConstants.contentType] = 'application/json';
    dio.options.connectTimeout = 15000;
    dio.options.receiveTimeout = 13000;
    final String authToken = UserLocal().getAccessToken();
    if (authToken.isNotEmpty) {
      setToken(authToken);
    }
  }

  void setToken(String authToken) {
    dio.options.headers[HttpConstants.authorization] = 'Bearer $authToken';
  }

  Future<void> clientSetup() async {
    final String authToken = UserLocal().getAccessToken();
    if (authToken.isNotEmpty) {
      dio.options.headers[HttpConstants.authorization] = 'Bearer $authToken';
    }
  }
}
