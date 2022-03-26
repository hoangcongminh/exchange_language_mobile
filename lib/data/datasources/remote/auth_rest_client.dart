import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'auth_rest_client.g.dart';

@RestApi()
abstract class AuthRestClient {
  factory AuthRestClient(Dio dio, {String baseUrl}) = _AuthRestClient;

  @POST('/auth/login')
  Future<void> login();

  @POST('/auth/logout')
  Future<void> logout();
}
