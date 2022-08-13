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
    on<RefreshPostEvent>(_refreshPosts);
    on<LikePostEvent>(_likePost);
  }

  Future<void> _fetchPosts(
      FetchPostsEvent event, Emitter<PostState> emit) async {
    // emit(PostLoading());
    if (posts.length == total) {
      return;
    }
    await _postRepository
        .fetchPosts(groupId: event.groupId, skip: posts.length)
        .then(
      (result) {
        result.fold(
          (failure) {
            emit(PostLoadFailure());
          },
          (listPost) {
            posts = List.of(posts)..addAll(listPost.posts);
            emit(PostLoaded(posts: posts));
          },
        );
      },
    );
  }

  Future<void> _refreshPosts(
      RefreshPostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    posts = [];
    await _postRepository.fetchPosts(groupId: event.groupId).then(
      (result) {
        result.fold(
          (failure) {
            emit(PostLoadFailure());
          },
          (listPost) {
            total = listPost.total;
            posts = listPost.posts;
            emit(PostLoaded(posts: posts));
          },
        );
      },
    );
  }

  Future<void> _likePost(LikePostEvent event, Emitter<PostState> emit) async {
    await _postRepository.likePost(postId: event.postId).then(
      (result) async {
        await result.fold(
          (failure) {
            emit(PostLoadFailure());
          },
          (_) async {
            await _postRepository
                .fetchPosts(groupId: event.groupId, limit: posts.length)
                .then(
              (result) {
                result.fold(
                  (failure) {
                    emit(PostLoadFailure());
                  },
                  (listPost) {
                    posts = listPost.posts;

                    emit(PostLoaded(posts: posts));
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  final PostRepository _postRepository;
  int total = 0;
  List<Post> posts = [];
}
