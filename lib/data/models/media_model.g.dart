// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaModel _$MediaModelFromJson(Map<String, dynamic> json) => MediaModel(
      json['_id'] as String,
      json['name'] as String,
      json['src'] as String?,
    );

Map<String, dynamic> _$MediaModelToJson(MediaModel instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'name': instance.filename,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('src', instance.src);
  return val;
}
