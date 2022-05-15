import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../models/api_response_model.dart';
import '../../models/conversation_model.dart';

part 'chat_rest_client.g.dart';

@RestApi()
abstract class ChatRestCient {
  factory ChatRestCient(Dio dio, {String baseUrl}) = _ChatRestCient;

  @GET('/conversations')
  Future<ApiResponseModel<ConversationModel>> getConversation();
}
