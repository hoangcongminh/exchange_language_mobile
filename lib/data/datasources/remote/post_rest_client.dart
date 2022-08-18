import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/api_response_model.dart';
import '../../models/post_model.dart';

part 'post_rest_client.g.dart';

@RestApi()
abstract class PostRestClient {
  factory PostRestClient(Dio dio, {String baseUrl}) = _PostRestClient;

  @GET('/groups/posts/{groupId}')
  Future<ApiResponseModel<ListPostModel>> fetchPosts({
    @Path('groupId') required String groupId,
    @Query("skip") int? skip,
    @Query("limit") int? limit,
  });

  @POST('/groups/posts/{groupId}')
  Future<ApiResponseModel> createPost(
    @Body() Map<String, dynamic> body, {
    @Path('groupId') required String groupId,
  });

  @GET('/groups/posts/favorites/{postId}')
  Future<ApiResponseModel<ListPostModel>> likePost({
    @Path('postId') required String postId,
  });

  @GET('/groups/posts/{groupId}')
  Future<ApiResponseModel<ListPostModel>> searchPost({
    @Path('groupId') required String groupId,
    @Query('search') required String searchTitle,
  });
}
