import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/api_response_model.dart';
import '../../models/blog_model.dart';

part 'blog_rest_client.g.dart';

@RestApi()
abstract class BlogRestClient {
  factory BlogRestClient(Dio dio, {String baseUrl}) = _BlogRestClient;

  @POST('/blogs')
  Future<ApiResponseModel> createBlog(
    @Body() Map<String, dynamic> body,
  );

  @PUT('/blogs/{blogId}')
  Future<ApiResponseModel<String>> editBlog(
    @Path('blogId') String id,
    @Body() Map<String, dynamic> body,
  );

  @GET('/blogs')
  Future<ApiResponseModel<ListBlogModel>> fetchBlogs({
    @Query("skip") int? skip,
    @Query("limit") int? limit,
  });

  @GET('/blogs/{slug}')
  Future<ApiResponseModel<BlogModel>> fetchBlogDetail(
    @Path('slug') String slug,
  );
}
