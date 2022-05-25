import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../models/api_response_model.dart';
import '../../models/language_model.dart';

part 'language_rest_client.g.dart';

@RestApi()
abstract class LanguageRestClient {
  factory LanguageRestClient(Dio dio, {String baseUrl}) = _LanguageRestClient;

  @GET('/language')
  Future<ApiResponseModel<List<LanguageModel>>> getListLanguage();
}
