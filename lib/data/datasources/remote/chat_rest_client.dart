import 'package:dio/dio.dart';
import 'package:exchange_language_mobile/data/models/api_response_model.dart';
import 'package:exchange_language_mobile/data/models/conversation_model.dart';
import 'package:retrofit/http.dart';

part 'chat_rest_client.g.dart';

@RestApi()
abstract class ChatRestCient {
  factory ChatRestCient(Dio dio, {String baseUrl}) = _ChatRestCient;

  @GET('/conversations')
  Future<ApiResponseModel<ConversationModel>> getConversation();
}
