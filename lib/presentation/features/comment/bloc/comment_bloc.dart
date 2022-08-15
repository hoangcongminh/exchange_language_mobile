import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/comment.dart';
import '../../../../domain/repository/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc(this._commentRepository) : super(CommentInitial()) {
    on<CommentEvent>((event, emit) {});
    on<FetchCommentEvent>(_fetchComment);
    on<CommentToPostEvent>(_commentToPost);
  }

  Future<void> _fetchComment(
      FetchCommentEvent event, Emitter<CommentState> emit) async {
    emit(CommentLoading());
    await _commentRepository.fetchComment(postId: event.postId).then((result) {
      result.fold(
        (failure) {
          emit(CommentLoadFailure(message: failure.message));
        },
        (listComment) {
          comments = listComment.comments;
          emit(CommentLoaded(comments: comments));
        },
      );
    });
  }

  Future<void> _commentToPost(
      CommentToPostEvent event, Emitter<CommentState> emit) async {
    await _commentRepository
        .commentToPost(
            postId: event.postId,
            content: event.content,
            idCommentReply: event.idPostReply)
        .then((result) async {
      await result.fold(
        (failure) {
          emit(CommentLoadFailure(message: failure.message));
        },
        (_) async {
          await _commentRepository
              .fetchComment(postId: event.postId)
              .then((result) {
            result.fold(
              (failure) {
                emit(CommentLoadFailure(message: failure.message));
              },
              (listComment) {
                comments = listComment.comments;
                emit(CommentLoaded(comments: comments));
              },
            );
          });
        },
      );
    });
  }

  final CommentRepository _commentRepository;
  int total = 0;
  List<Comment> comments = [];
}
