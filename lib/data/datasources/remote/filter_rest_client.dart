import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../models/api_response_model.dart';
import '../../models/user_model.dart';

part 'filter_rest_client.g.dart';

@RestApi()
abstract class FilterRestClient {
  factory FilterRestClient(Dio dio, {String baseUrl}) = _FilterRestClient;

  @GET('/users/search')
  Future<ApiResponseModel<UserSearchResponse>> searchUsers();
}
