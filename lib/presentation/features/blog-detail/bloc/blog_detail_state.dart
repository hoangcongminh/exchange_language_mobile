part of 'blog_detail_bloc.dart';

abstract class BlogDetailState extends Equatable {
  const BlogDetailState();

  @override
  List<Object> get props => [];
}

class BlogDetailInitial extends BlogDetailState {}

class BlogDetailLoading extends BlogDetailState {}

class BlogDetailLoaded extends BlogDetailState {
  final Blog blog;
  const BlogDetailLoaded({required this.blog});
}

class BlogDetailDeleted extends BlogDetailState {}

class BlogDetailFailure extends BlogDetailState {}
