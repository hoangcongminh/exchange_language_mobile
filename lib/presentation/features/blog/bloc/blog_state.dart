part of 'blog_bloc.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

class BlogInitial extends BlogState {}

class BlogsLoading extends BlogState {}

class BlogsLoaded extends BlogState {
  final List<Blog> blogs;

  const BlogsLoaded({required this.blogs});

  @override
  List<Object> get props => [blogs];
}

class BlogsLoadFailure extends BlogState {}
