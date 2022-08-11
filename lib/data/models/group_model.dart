import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/group.dart';
import 'media_model.dart';
import 'user_model.dart';

part 'group_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GroupModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'posts')
  final List<dynamic> posts;
  @JsonKey(name: 'members')
  final List<String> members;
  @JsonKey(name: 'createdAt')
  final String createdAt;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'slug')
  final String slug;
  @JsonKey(name: 'thumbnail')
  final MediaModel? thumbnail;
  @JsonKey(name: 'author')
  final UserModel author;
  @JsonKey(name: 'description')
  final String description;

  GroupModel(
    this.id,
    this.posts,
    this.members,
    this.createdAt,
    this.title,
    this.slug,
    this.thumbnail,
    this.author,
    this.description,
  );

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupModelToJson(this);

  Group toEntity() => Group(
        id: id,
        slug: slug,
        title: title,
        members: members,
        posts: posts,
        thumbnail: thumbnail?.toEntity(),
        author: author.toEntity(),
        createdAt: createdAt,
        description: description,
      );
}

@JsonSerializable(explicitToJson: true)
class ListGroupModel {
  @JsonKey(name: 'data')
  final List<GroupModel> data;
  @JsonKey(name: 'total')
  final int total;

  const ListGroupModel(
    this.data,
    this.total,
  );

  factory ListGroupModel.fromJson(Map<String, dynamic> json) =>
      _$ListGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListGroupModelToJson(this);

  ListGroup toEntity() => ListGroup(
        groups: data.map((e) => e.toEntity()).toList(),
        total: total,
      );
}
