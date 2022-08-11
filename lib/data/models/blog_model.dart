import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/blog.dart';
import 'media_model.dart';
import 'user_model.dart';

part 'blog_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BlogModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'slug')
  final String slug;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'thumbnail')
  final MediaModel thumbnail;
  @JsonKey(name: 'content')
  final String? content;
  @JsonKey(name: 'author')
  final UserModel author;
  @JsonKey(name: 'createdAt')
  final String createdAt;

  const BlogModel(
    this.id,
    this.slug,
    this.title,
    this.content,
    this.thumbnail,
    this.author,
    this.createdAt,
  );

  factory BlogModel.fromJson(Map<String, dynamic> json) =>
      _$BlogModelFromJson(json);

  Map<String, dynamic> toJson() => _$BlogModelToJson(this);

  Blog toEntity() => Blog(
        id: id,
        slug: slug,
        title: title,
        thumbnail: thumbnail.toEntity(),
        content: content,
        author: author.toEntity(),
        createdAt: createdAt,
      );
}

@JsonSerializable(explicitToJson: true)
class ListBlogModel {
  @JsonKey(name: 'data')
  final List<BlogModel> data;
  @JsonKey(name: 'total')
  final int total;

  const ListBlogModel(
    this.data,
    this.total,
  );

  factory ListBlogModel.fromJson(Map<String, dynamic> json) =>
      _$ListBlogModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListBlogModelToJson(this);

  ListBlog toEntity() => ListBlog(
        blogs: data.map((e) => e.toEntity()).toList(),
        total: total,
      );
}
