import 'package:exchange_language_mobile/data/models/conversation_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/message.dart';
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

  DataMessage toEntity() => DataMessage(
        messages: messages.map((e) => e.toEntity()).toList(),
        conversationInfo: conversation.toEntity(),
      );
}

@JsonSerializable()
class MessageItemModel {
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'author')
  final UserModel author;
  @JsonKey(name: 'IDConversation')
  final String conversationId;
  @JsonKey(name: 'content', includeIfNull: false)
  final String? content;
  @JsonKey(name: 'type', includeIfNull: false)
  final int? type;

  MessageItemModel(this.createdAt, this.id, this.author, this.conversationId,
      this.content, this.type);

  factory MessageItemModel.fromJson(Map<String, dynamic> json) =>
      _$MessageItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageItemModelToJson(this);

  Message toEntity() => Message(
        createdAt: createdAt,
        id: id,
        author: author.toEntity(),
        conversationId: conversationId,
        content: content,
        type: type,
      );
}
