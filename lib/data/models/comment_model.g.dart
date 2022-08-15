// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      json['_id'] as String,
      json['post'] as String?,
      json['createdAt'] as String,
      (json['replys'] as List<dynamic>?)
          ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['content'] as String,
      UserModel.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'post': instance.postId,
      'createdAt': instance.createdAt,
      'replys': instance.replys?.map((e) => e.toJson()).toList(),
      'content': instance.content,
      'author': instance.author.toJson(),
    };

ListCommentModel _$ListCommentModelFromJson(Map<String, dynamic> json) =>
    ListCommentModel(
      (json['data'] as List<dynamic>)
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int,
    );

Map<String, dynamic> _$ListCommentModelToJson(ListCommentModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'total': instance.total,
    };
