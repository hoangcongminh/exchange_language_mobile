import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../models/api_response_model.dart';
import '../../models/user_model.dart';

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
  Future<ApiResponseModel> sendOTP(
    @Body() Map<String, dynamic> body,
  );

  @POST('/verify/verifyOTP')
  Future<ApiResponseModel> verifyOTP(
    @Body() Map<String, dynamic> body,
  );

  @POST('/users/register')
  Future<ApiResponseModel<String>> register(
    @Body() Map<String, dynamic> body,
  );

  @POST('/users/reset-password')
  Future<ApiResponseModel> resetPassword(
    @Body() Map<String, dynamic> body,
  );

  

  @POST('/auth/logout')
  Future<void> logout();
}
