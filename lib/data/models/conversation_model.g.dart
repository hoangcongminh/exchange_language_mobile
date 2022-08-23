// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    ConversationModel(
      json['_id'] as String,
      json['name'] as String?,
      (json['members'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      DateTime.parse(json['modifiedAt'] as String),
      json['lastMessage'] == null
          ? null
          : MessageItemModel.fromJson(
              json['lastMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConversationModelToJson(ConversationModel instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.conversationName);
  val['members'] = instance.members;
  val['modifiedAt'] = instance.modifiedAt.toIso8601String();
  val['lastMessage'] = instance.lastMessage;
  return val;
}
