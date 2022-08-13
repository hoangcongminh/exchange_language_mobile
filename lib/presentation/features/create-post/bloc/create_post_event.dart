part of 'create_post_bloc.dart';

abstract class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object> get props => [];
}

class CreateNewPostEvent extends CreatePostEvent {
  final String groupId;
  final String postTitle;
  final String postContent;
  const CreateNewPostEvent({
    required this.groupId,
    required this.postTitle,
    required this.postContent,
  });
  @override
  List<Object> get props => [groupId, postTitle, postContent];
}
