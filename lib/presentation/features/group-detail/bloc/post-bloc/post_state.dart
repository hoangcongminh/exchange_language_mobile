part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  final List<String> likedPosts;

  const PostLoaded({required this.posts, required this.likedPosts});

  @override
  List<Object> get props => [posts, likedPosts];
}

class PostLoading extends PostState {}

class PostLoadFailure extends PostState {}

class PostLike extends PostState {}
