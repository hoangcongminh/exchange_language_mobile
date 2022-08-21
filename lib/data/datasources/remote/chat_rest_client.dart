import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../models/api_response_model.dart';
import '../../models/conversation_model.dart';
import '../../models/message_model.dart';

part 'chat_rest_client.g.dart';

@RestApi()
abstract class ChatRestCient {
  factory ChatRestCient(Dio dio, {String baseUrl}) = _ChatRestCient;

  @POST('/conversation')
  Future<ApiResponseModel> createConversation(
    @Body() Map<String, dynamic> body,
  );

  @GET('/conversation')
  Future<ApiResponseModel<List<ConversationModel>>> getConversation({
    @Query('skip') int? skip,
    @Query('limit') int? limit,
  });

  @GET('/conversation/get-messages/{conversationId}')
  Future<ApiResponseModel<MessageModel>> getMessageByConversation({
    @Path('conversationId') required String conversationId,
    @Query('skip') int? skip,
    @Query('limit') int? limit,
  });

  @GET('/conversation/get-message-or-create/{userId}')
  Future<ApiResponseModel<MessageModel>> createOrGetMessageByUserId({
    @Path('userId') required String userId,
  });
}
