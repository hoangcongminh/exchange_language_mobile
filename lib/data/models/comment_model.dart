import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/comment.dart';
import 'user_model.dart';

part 'comment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'post')
  final String? postId;
  @JsonKey(name: 'createdAt')
  final String createdAt;
  @JsonKey(name: 'replys')
  final List<CommentModel>? replys;
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'author')
  final UserModel author;

  CommentModel(
    this.id,
    this.postId,
    this.createdAt,
    this.replys,
    this.content,
    this.author,
  );

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  Comment toEntity() => Comment(
        id: id,
        postId: postId,
        createdAt: createdAt,
        replys: replys?.map((e) => e.toEntity()).toList(),
        content: content,
        author: author.toEntity(),
      );
}

@JsonSerializable(explicitToJson: true)
class ListCommentModel {
  @JsonKey(name: 'data')
  final List<CommentModel> data;
  @JsonKey(name: 'total')
  final int total;

  const ListCommentModel(
    this.data,
    this.total,
  );

  factory ListCommentModel.fromJson(Map<String, dynamic> json) =>
      _$ListCommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListCommentModelToJson(this);

  ListComment toEntity() => ListComment(
        comments: data.map((e) => e.toEntity()).toList(),
        total: total,
      );
}
