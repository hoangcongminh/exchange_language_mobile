import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/post.dart';
import '../../../../../domain/repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this._postRepository) : super(PostInitial()) {
    on<PostEvent>((event, emit) {});
    on<FetchPostsEvent>(_fetchPosts);
  }

  Future<void> _fetchPosts(
      FetchPostsEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    await _postRepository.fetchPosts(groupId: event.groupId).then(
      (result) {
        result.fold(
          (failure) {
            emit(PostLoadFailure());
          },
          (listPost) {
            emit(PostLoaded(posts: listPost.posts));
          },
        );
      },
    );
  }

  final PostRepository _postRepository;
  List<Post> post = [];
}
