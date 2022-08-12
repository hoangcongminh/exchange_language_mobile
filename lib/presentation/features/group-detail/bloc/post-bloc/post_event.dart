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
