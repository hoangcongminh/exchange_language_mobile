import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repository/post_repository.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc(this._postRepository) : super(CreatePostInitial()) {
    on<CreatePostEvent>((event, emit) {});
    on<CreateNewPostEvent>(_createPost);
  }

  Future<void> _createPost(
      CreateNewPostEvent event, Emitter<CreatePostState> emit) async {
    emit(CreatePostLoading());
    await _postRepository
        .createPost(
            groupId: event.groupId,
            postTitle: event.postTitle,
            postContent: event.postContent)
        .then((result) {
      result.fold(
        (failure) {
          emit(CreatePostFailure(message: failure.message));
        },
        (_) {
          emit(CreatePostSuccess());
        },
      );
    });
  }

  final PostRepository _postRepository;
}
