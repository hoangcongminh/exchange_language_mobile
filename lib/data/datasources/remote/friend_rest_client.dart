import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/api_response_model.dart';
import '../../models/user_model.dart';

part 'friend_rest_client.g.dart';

@RestApi()
abstract class FriendRestClient {
  factory FriendRestClient(Dio dio, {String baseUrl}) = _FriendRestClient;

  @GET('/friends/check-friend/{userId}')
  Future<ApiResponseModel<int>> checkFriend({
    @Path('userId') required String userId,
  });

  @GET('/friends/add-request/{userId}')
  Future<ApiResponseModel<int>> addFriend({
    @Path('userId') required String userId,
  });

  @GET('/friends/confirm-request/{userId}')
  Future<ApiResponseModel<int>> confirmFriendRequest({
    @Path('userId') required String userId,
  });

  @GET('/friends/cancel-request/{userId}')
  Future<ApiResponseModel<int>> cancelFriendRequest({
    @Path('userId') required String userId,
  });

  @GET('/friends/delete-friend/{userId}')
  Future<ApiResponseModel<int>> deleteFriend({
    @Path('userId') required String userId,
  });

  @GET('/users/my-friends')
  Future<ApiResponseModel<ListUserModel>> getFriends();
}
