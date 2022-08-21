import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/api_response_model.dart';
import '../../models/user_model.dart';

part 'user_rest_client.g.dart';

@RestApi()
abstract class UserRestClient {
  factory UserRestClient(Dio dio, {String baseUrl}) = _UserRestClient;

  @PUT('/users/update-info')
  Future<ApiResponseModel> updateProfile(
    @Body() Map<String, dynamic> body,
  );

  @GET('/users/{userId}')
  Future<ApiResponseModel<UserModel>> getUserProfile({
    @Path('userId') required userId,
  });

  @POST('/users/register-teacher')
  Future<ApiResponseModel> registerTeacher(
    @Body() Map<String, dynamic> body,
  );
}
