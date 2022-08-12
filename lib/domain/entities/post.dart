import 'package:equatable/equatable.dart';
import 'package:exchange_language_mobile/domain/entities/user.dart';

class Post extends Equatable {
  final String id;
  final List<String> favorites;
  final List<String> comments;
  final String createdAt;
  final String title;
  final String slug;
  final String content;
  final User author;
  final String group;

  const Post({
    required this.id,
    required this.favorites,
    required this.comments,
    required this.createdAt,
    required this.title,
    required this.slug,
    required this.content,
    required this.author,
    required this.group,
  });

  @override
  List<Object?> get props => [
        id,
        favorites,
        comments,
        createdAt,
        title,
        slug,
        content,
        author,
        group,
      ];
}

class ListPost extends Equatable {
  final List<Post> posts;
  final int total;

  const ListPost({
    required this.posts,
    required this.total,
  });
  @override
  List<Object?> get props => [
        posts,
        total,
      ];
}
