import 'package:dio/dio.dart';
import 'package:exchange_language_mobile/data/models/user_model.dart';
import 'package:retrofit/http.dart';

import '../../models/api_response_model.dart';

part 'auth_rest_client.g.dart';

@RestApi()
abstract class AuthRestClient {
  factory AuthRestClient(Dio dio, {String baseUrl}) = _AuthRestClient;

  @POST('/users/login')
  Future<ApiResponseModel<String>> login(
    @Body() Map<String, dynamic> body,
  );

  @GET('/users/refresh-token')
  Future<ApiResponseModel<UserModel>> refreshToken();

  @POST('/verify/sendOTP')
  Future<void> sendOTP(
    @Body() Map<String, dynamic> body,
  );

  @POST('/verify/verifyOTP')
  Future<void> verifyOTP(
    @Body() Map<String, dynamic> body,
  );

  @POST('/users/register')
  Future<ApiResponseModel<String>> register(
    @Body() Map<String, dynamic> body,
  );

  @POST('/auth/logout')
  Future<void> logout();
}
