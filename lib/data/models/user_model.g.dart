// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['_id'] as String,
      json['fullname'] as String,
      json['role'] as int?,
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
      json['teacher'] == null
          ? null
          : TeacherModel.fromJson(json['teacher'] as Map<String, dynamic>),
      json['introduction'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'fullname': instance.fullName,
    'role': instance.role,
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
  val['teacher'] = instance.teacher?.toJson();
  writeNotNull('introduction', instance.introduction);
  return val;
}

TeacherModel _$TeacherModelFromJson(Map<String, dynamic> json) => TeacherModel(
      json['_id'] as String,
      (json['teach'] as List<dynamic>?)
          ?.map((e) => LanguageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['rating'] as List<dynamic>)
          .map((e) => RateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TeacherModelToJson(TeacherModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'teach': instance.teachingLanguage?.map((e) => e.toJson()).toList(),
      'rating': instance.rate.map((e) => e.toJson()).toList(),
    };

RateModel _$RateModelFromJson(Map<String, dynamic> json) => RateModel(
      json['_id'] as String,
      json['author'] as String,
      json['star'] as int,
    );

Map<String, dynamic> _$RateModelToJson(RateModel instance) => <String, dynamic>{
      '_id': instance.id,
      'author': instance.author,
      'star': instance.star,
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

ListUserModel _$ListUserModelFromJson(Map<String, dynamic> json) =>
    ListUserModel(
      (json['data'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int,
    );

Map<String, dynamic> _$ListUserModelToJson(ListUserModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'total': instance.total,
    };
