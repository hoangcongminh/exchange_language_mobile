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
    @Query('skip') int? skip,
  });

  @GET('/groups/{slug}')
  Future<ApiResponseModel<GroupModel>> fetchGroupDetail({
    @Path('slug') required String slug,
  });
}
