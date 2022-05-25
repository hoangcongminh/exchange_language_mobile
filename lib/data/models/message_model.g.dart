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
      json['createdAt'] as String,
      json['_id'] as String,
      UserModel.fromJson(json['author'] as Map<String, dynamic>),
      json['IDConversation'] as String,
      json['content'] as String,
    );

Map<String, dynamic> _$MessageItemModelToJson(MessageItemModel instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      '_id': instance.id,
      'author': instance.author,
      'IDConversation': instance.idConversation,
      'content': instance.content,
    };
