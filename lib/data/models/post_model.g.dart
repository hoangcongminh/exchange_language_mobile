// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      json['_id'] as String,
      (json['favorites'] as List<dynamic>).map((e) => e as String).toList(),
      (json['comments'] as List<dynamic>).map((e) => e as String).toList(),
      json['createdAt'] as String,
      json['title'] as String,
      json['slug'] as String,
      json['content'] as String,
      UserModel.fromJson(json['author'] as Map<String, dynamic>),
      json['group'] as String,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      '_id': instance.id,
      'favorites': instance.favorites,
      'comments': instance.comments,
      'createdAt': instance.createdAt,
      'title': instance.title,
      'slug': instance.slug,
      'content': instance.content,
      'author': instance.author.toJson(),
      'group': instance.group,
    };

ListPostModel _$ListPostModelFromJson(Map<String, dynamic> json) =>
    ListPostModel(
      (json['data'] as List<dynamic>)
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int,
    );

Map<String, dynamic> _$ListPostModelToJson(ListPostModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'total': instance.total,
    };
