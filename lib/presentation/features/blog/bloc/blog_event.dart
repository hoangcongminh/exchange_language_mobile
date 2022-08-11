part of 'blog_bloc.dart';

abstract class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

class RefreshBlogsEvent extends BlogEvent {}

class FetchBlogsEvent extends BlogEvent {}
