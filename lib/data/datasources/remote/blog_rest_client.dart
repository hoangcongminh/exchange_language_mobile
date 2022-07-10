import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/api_response_model.dart';

part 'blog_rest_client.g.dart';

@RestApi()
abstract class BlogRestClient {
  factory BlogRestClient(Dio dio, {String baseUrl}) = _BlogRestClient;

  @POST('/blogs')
  Future<ApiResponseModel> createBlog(
    @Body() Map<String, dynamic> body,
  );
}
