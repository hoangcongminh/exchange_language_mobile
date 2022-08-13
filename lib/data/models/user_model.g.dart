// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['_id'] as String,
      json['fullname'] as String,
      json['email'] as String?,
      json['avatar'] == null
          ? null
          : AvatarModel.fromJson(json['avatar'] as Map<String, dynamic>),
      (json['learn'] as List<dynamic>?)
          ?.map((e) => LanguageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['speak'] as List<dynamic>?)
          ?.map((e) => LanguageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['introduction'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'fullname': instance.fullName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('email', instance.email);
  val['avatar'] = instance.avatar?.toJson();
  val['learn'] = instance.learningLanguage?.map((e) => e.toJson()).toList();
  val['speak'] = instance.speakingLanguage?.map((e) => e.toJson()).toList();
  writeNotNull('introduction', instance.introduction);
  return val;
}

AvatarModel _$AvatarModelFromJson(Map<String, dynamic> json) => AvatarModel(
      json['_id'] as String,
      json['src'] as String,
    );

Map<String, dynamic> _$AvatarModelToJson(AvatarModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'src': instance.src,
    };

UserSearchResponse _$UserSearchResponseFromJson(Map<String, dynamic> json) =>
    UserSearchResponse(
      (json['data'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserSearchResponseToJson(UserSearchResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
