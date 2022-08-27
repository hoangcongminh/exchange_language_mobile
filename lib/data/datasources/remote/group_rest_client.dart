import 'package:dio/dio.dart';
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

  @GET('/groups/leave/{id}')
  Future<ApiResponseModel> leaveGroup({
    @Path('id') required String groupId,
  });
}
