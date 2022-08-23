// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      json['_id'] as String,
      json['userSender'] == null
          ? null
          : UserModel.fromJson(json['userSender'] as Map<String, dynamic>),
      json['userReceiver'] == null
          ? null
          : UserModel.fromJson(json['userReceiver'] as Map<String, dynamic>),
      json['type'] as int,
      json['dataTarget'] as String?,
      json['status'] as int,
      json['createdAt'] as String,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userSender': instance.userSender?.toJson(),
      'userReceiver': instance.userReceiver?.toJson(),
      'type': instance.type,
      'dataTarget': instance.dataTarget,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };

ListNotificationModel _$ListNotificationModelFromJson(
        Map<String, dynamic> json) =>
    ListNotificationModel(
      (json['data'] as List<dynamic>)
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int,
    );

Map<String, dynamic> _$ListNotificationModelToJson(
        ListNotificationModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'total': instance.total,
    };
