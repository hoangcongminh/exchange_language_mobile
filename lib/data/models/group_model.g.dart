// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) => GroupModel(
      json['_id'] as String,
      json['posts'] as List<dynamic>,
      (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      json['createdAt'] as String,
      json['title'] as String,
      json['slug'] as String,
      json['thumbnail'] == null
          ? null
          : MediaModel.fromJson(json['thumbnail'] as Map<String, dynamic>),
      UserModel.fromJson(json['author'] as Map<String, dynamic>),
      json['description'] as String,
    );

Map<String, dynamic> _$GroupModelToJson(GroupModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'posts': instance.posts,
      'members': instance.members,
      'createdAt': instance.createdAt,
      'title': instance.title,
      'slug': instance.slug,
      'thumbnail': instance.thumbnail?.toJson(),
      'author': instance.author.toJson(),
      'description': instance.description,
    };

ListGroupModel _$ListGroupModelFromJson(Map<String, dynamic> json) =>
    ListGroupModel(
      (json['data'] as List<dynamic>)
          .map((e) => GroupModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int,
    );

Map<String, dynamic> _$ListGroupModelToJson(ListGroupModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'total': instance.total,
    };
