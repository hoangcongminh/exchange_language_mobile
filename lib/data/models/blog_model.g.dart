// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogModel _$BlogModelFromJson(Map<String, dynamic> json) => BlogModel(
      json['_id'] as String,
      json['slug'] as String,
      json['title'] as String,
      json['content'] as String?,
      json['thumbnail'] == null
          ? null
          : MediaModel.fromJson(json['thumbnail'] as Map<String, dynamic>),
      UserModel.fromJson(json['author'] as Map<String, dynamic>),
      json['createdAt'] as String,
    );

Map<String, dynamic> _$BlogModelToJson(BlogModel instance) => <String, dynamic>{
      '_id': instance.id,
      'slug': instance.slug,
      'title': instance.title,
      'thumbnail': instance.thumbnail?.toJson(),
      'content': instance.content,
      'author': instance.author.toJson(),
      'createdAt': instance.createdAt,
    };

ListBlogModel _$ListBlogModelFromJson(Map<String, dynamic> json) =>
    ListBlogModel(
      (json['data'] as List<dynamic>)
          .map((e) => BlogModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int,
    );

Map<String, dynamic> _$ListBlogModelToJson(ListBlogModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'total': instance.total,
    };
