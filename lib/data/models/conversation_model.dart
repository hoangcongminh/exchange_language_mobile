import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/conversation.dart';
import 'user_model.dart';

part 'conversation_model.g.dart';

@JsonSerializable()
class ConversationModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'name')
  final String conversationName;
  @JsonKey(name: 'members')
  final List<UserModel> users;

  ConversationModel(this.id, this.conversationName, this.users);

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);

  Conversation toEntity() => Conversation(
        id: id,
        conversationName: conversationName,
        users: users.map((e) => e.toEntity()).toList(),
      );
}
