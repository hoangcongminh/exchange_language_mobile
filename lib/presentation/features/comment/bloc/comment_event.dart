part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class RefreshCommentEvent extends CommentEvent {}

class FetchCommentEvent extends CommentEvent {
  final String postId;

  const FetchCommentEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}

class CommentToPostEvent extends CommentEvent {
  final String postId;
  final String content;
  final String? idPostReply;

  const CommentToPostEvent({
    required this.postId,
    required this.content,
    this.idPostReply,
  });

  @override
  List<Object> get props => [postId, content];
}
