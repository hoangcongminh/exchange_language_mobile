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
  Future<ApiResponseModel<List<ConversationModel>>> getConversation();

  @GET('/conversation/get-messages/{conversationId}')
  Future<ApiResponseModel<MessageModel>> getMessageByConversation(
    @Path('conversationId') String conversationId,
  );
}
