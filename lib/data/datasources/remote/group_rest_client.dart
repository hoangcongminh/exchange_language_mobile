import 'package:dio/dio.dart';
import 'package:exchange_language_mobile/data/models/user_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/api_response_model.dart';
import '../../models/group_model.dart';

part 'group_rest_client.g.dart';

@RestApi()
abstract class GroupRestClient {
  factory GroupRestClient(Dio dio, {String baseUrl}) = _GroupRestClient;

  @GET('/groups')
  Future<ApiResponseModel<ListGroupModel>> fetchGroup({
    @Query("skip") int? skip,
    @Query("limit") int? limit,
  });

  @GET('/groups/by-id/{groupId}')
  Future<ApiResponseModel<GroupModel>> fetchGroupDetail({
    @Path('groupId') required String groupId,
  });

  @POST('/groups')
  Future<ApiResponseModel> createGroup(
    @Body() Map<String, dynamic> body,
  );

  @GET('/groups/join/{id}')
  Future<ApiResponseModel> joinGroup({
    @Path('id') required String groupId,
  });

  @GET('/groups/cancel-request-join/{id}')
  Future<ApiResponseModel> cancelRequestJoin({
    @Path('id') required String groupId,
  });

  @GET('/groups/list-request/{id}')
  Future<ApiResponseModel<List<UserModel>>> getListRequest({
    @Path('id') required String groupId,
  });

  @GET('/groups/list-member/{id}')
  Future<ApiResponseModel<List<UserModel>>> getListMember({
    @Path('id') required String groupId,
  });

  @POST('/groups/accept-join')
  Future<ApiResponseModel> acceptJoin(
    @Body() Map<String, dynamic> body,
  );

  @POST('/groups/denied-join')
  Future<ApiResponseModel> deniedJoin(
    @Body() Map<String, dynamic> body,
  );

  @GET('/groups/leave/{id}')
  Future<ApiResponseModel> leaveGroup({
    @Path('id') required String groupId,
  });
}
