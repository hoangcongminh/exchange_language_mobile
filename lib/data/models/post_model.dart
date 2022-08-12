import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/post.dart';
import 'user_model.dart';

part 'post_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PostModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'favorites')
  final List<String> favorites;
  @JsonKey(name: 'comments')
  final List<String> comments;
  @JsonKey(name: 'createdAt')
  final String createdAt;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'slug')
  final String slug;
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'author')
  final UserModel author;
  @JsonKey(name: 'group')
  final String group;

  PostModel(
    this.id,
    this.favorites,
    this.comments,
    this.createdAt,
    this.title,
    this.slug,
    this.content,
    this.author,
    this.group,
  );

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  Post toEntity() => Post(
        id: id,
        favorites: favorites,
        comments: comments,
        createdAt: createdAt,
        title: title,
        slug: slug,
        content: content,
        author: author.toEntity(),
        group: group,
      );
}

@JsonSerializable(explicitToJson: true)
class ListPostModel {
  @JsonKey(name: 'data')
  final List<PostModel> data;
  @JsonKey(name: 'total')
  final int total;

  const ListPostModel(
    this.data,
    this.total,
  );

  factory ListPostModel.fromJson(Map<String, dynamic> json) =>
      _$ListPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListPostModelToJson(this);

  ListPost toEntity() => ListPost(
        posts: data.map((e) => e.toEntity()).toList(),
        total: total,
      );
}
