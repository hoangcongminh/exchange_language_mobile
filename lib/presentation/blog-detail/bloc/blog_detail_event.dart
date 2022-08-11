part of 'blog_detail_bloc.dart';

abstract class BlogDetailEvent extends Equatable {
  const BlogDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchBlogDetail extends BlogDetailEvent {
  final String slug;
  const FetchBlogDetail({required this.slug});

  @override
  List<Object> get props => [slug];
}

class DeleteBlogEvent extends BlogDetailEvent {
  final String id;

  const DeleteBlogEvent({required this.id});
}
