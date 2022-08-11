part of 'create_blog_bloc.dart';

abstract class CreateBlogState extends Equatable {
  const CreateBlogState();

  @override
  List<Object> get props => [];
}

class CreateBlogInitial extends CreateBlogState {}

class CreateBlogLoading extends CreateBlogState {}

class CreateBlogFailure extends CreateBlogState {
  final String error;

  const CreateBlogFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class CreateBlogSuccess extends CreateBlogState {}

class EditBlogSuccess extends CreateBlogState {
  final String edittedSlug;

  const EditBlogSuccess({required this.edittedSlug});
}
