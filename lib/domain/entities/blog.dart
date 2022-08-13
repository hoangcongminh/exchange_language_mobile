import 'package:equatable/equatable.dart';
import 'package:exchange_language_mobile/domain/entities/media.dart';

import 'user.dart';

class Blog extends Equatable {
  final String id;
  final String slug;
  final String title;
  final Media? thumbnail;
  final String? content;
  final User author;
  final String createdAt;

  const Blog({
    required this.id,
    required this.slug,
    required this.title,
    required this.thumbnail,
    required this.content,
    required this.author,
    required this.createdAt,
  });
  @override
  List<Object?> get props => [
        slug,
        title,
        thumbnail,
        content,
        author,
        createdAt,
      ];
}

class ListBlog extends Equatable {
  final List<Blog> blogs;
  final int total;

  const ListBlog({
    required this.blogs,
    required this.total,
  });
  @override
  List<Object?> get props => [
        blogs,
        total,
      ];
}
