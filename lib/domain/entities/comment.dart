import 'package:equatable/equatable.dart';

import 'user.dart';

class Comment extends Equatable {
  final String id;
  final String? postId;
  final String createdAt;
  final List<Comment>? replys;
  final String content;
  final User author;

  const Comment({
    required this.id,
    this.postId,
    required this.createdAt,
    this.replys,
    required this.content,
    required this.author,
  });

  @override
  List<Object?> get props => [
        id,
        postId,
        createdAt,
        replys,
        content,
        author,
      ];
}

class ListComment extends Equatable {
  final List<Comment> comments;
  final int total;

  const ListComment({
    required this.comments,
    required this.total,
  });
  @override
  List<Object?> get props => [
        comments,
        total,
      ];
}
