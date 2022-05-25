import 'package:exchange_language_mobile/data/models/conversation_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'user_model.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  @JsonKey(name: 'dataMessage')
  final List<MessageItemModel> messages;
  @JsonKey(name: 'infoConversation')
  final ConversationModel conversation;

  MessageModel(this.messages, this.conversation);

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}

@JsonSerializable()
class MessageItemModel {
  @JsonKey(name: 'createdAt')
  final String createdAt;
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'author')
  final UserModel author;
  @JsonKey(name: 'IDConversation')
  final String idConversation;
  @JsonKey(name: 'content')
  final String content;

  MessageItemModel(
      this.createdAt, this.id, this.author, this.idConversation, this.content);

  factory MessageItemModel.fromJson(Map<String, dynamic> json) =>
      _$MessageItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageItemModelToJson(this);
}
