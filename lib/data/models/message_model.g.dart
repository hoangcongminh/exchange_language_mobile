// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      (json['dataMessage'] as List<dynamic>)
          .map((e) => MessageItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      ConversationModel.fromJson(
          json['infoConversation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'dataMessage': instance.messages,
      'infoConversation': instance.conversation,
    };

MessageItemModel _$MessageItemModelFromJson(Map<String, dynamic> json) =>
    MessageItemModel(
      DateTime.parse(json['createdAt'] as String),
      json['_id'] as String,
      UserModel.fromJson(json['author'] as Map<String, dynamic>),
      json['IDConversation'] as String,
      json['content'] as String?,
      json['type'] as int?,
    );

Map<String, dynamic> _$MessageItemModelToJson(MessageItemModel instance) {
  final val = <String, dynamic>{
    'createdAt': instance.createdAt.toIso8601String(),
    '_id': instance.id,
    'author': instance.author,
    'IDConversation': instance.conversationId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('content', instance.content);
  writeNotNull('type', instance.type);
  return val;
}
