// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['_id'] as String,
      json['fullname'] as String,
      json['email'] as String,
      AvatarModel.fromJson(json['avatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'fullname': instance.fullName,
      'email': instance.email,
      'avatar': instance.avatar.toJson(),
    };

AvatarModel _$AvatarModelFromJson(Map<String, dynamic> json) => AvatarModel(
      json['_id'] as String,
      json['src'] as String,
    );

Map<String, dynamic> _$AvatarModelToJson(AvatarModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'src': instance.src,
    };
