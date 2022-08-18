part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class FetchPostsEvent extends PostEvent {
  final String groupId;
  const FetchPostsEvent({required this.groupId});

  @override
  List<Object> get props => [groupId];
}

class RefreshPostEvent extends PostEvent {
  final String groupId;
  const RefreshPostEvent({required this.groupId});

  @override
  List<Object> get props => [groupId];
}

class LikePostEvent extends PostEvent {
  final String postId;
  final String groupId;
  const LikePostEvent({required this.postId, required this.groupId});

  @override
  List<Object> get props => [postId, groupId];
}

class SearchPostEvent extends PostEvent {
  final String groupId;
  final String searchTitle;
  const SearchPostEvent({required this.groupId, required this.searchTitle});

  @override
  List<Object> get props => [groupId, searchTitle];
}
