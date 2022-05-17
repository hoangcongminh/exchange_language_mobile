// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageModel _$LanguageModelFromJson(Map<String, dynamic> json) =>
    LanguageModel(
      json['_id'] as String,
      json['name'] as String,
      json['code'] as String,
      MediaModel.fromJson(json['thumbnail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LanguageModelToJson(LanguageModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'thumbnail': instance.thumbnail.toJson(),
    };
