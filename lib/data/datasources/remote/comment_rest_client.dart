import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/api_response_model.dart';
import '../../models/comment_model.dart';

part 'comment_rest_client.g.dart';

@RestApi()
abstract class CommentRestClient {
  factory CommentRestClient(Dio dio, {String baseUrl}) = _CommentRestClient;

  @GET('/groups/posts/comments/{postId}')
  Future<ApiResponseModel<ListCommentModel>> fetchComment({
    @Path('postId') required String postId,
    @Query("skip") int? skip,
    @Query("limit") int? limit,
  });

  @POST('/groups/posts/comments/{postId}')
  Future<ApiResponseModel> commentToPost(
    @Body() Map<String, dynamic> body, {
    @Path('postId') required String postId,
  });
}
