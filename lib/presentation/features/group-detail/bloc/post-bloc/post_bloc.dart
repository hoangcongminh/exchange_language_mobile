import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:exchange_language_mobile/data/datasources/local/user_local_data.dart';
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
    on<SearchPostEvent>(_searchPost);
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
            likedPosts = [
              ...likedPosts,
              ...listPost.posts
                  .where((element) =>
                      element.favorites.contains(UserLocal().getUser()!.id))
                  .toList()
                  .map((e) => e.id)
                  .toList()
            ];
            emit(PostLoaded(posts: posts, likedPosts: likedPosts));
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
            likedPosts = listPost.posts
                .where((element) =>
                    element.favorites.contains(UserLocal().getUser()!.id))
                .toList()
                .map((e) => e.id)
                .toList();
            emit(PostLoaded(posts: posts, likedPosts: likedPosts));
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
            emit(PostLike());
            if (likedPosts.contains(event.postId)) {
              likedPosts.remove(event.postId);
              posts
                  .where((element) => element.id == event.postId)
                  .first
                  .favorites
                  .remove(UserLocal().getUser()!.id);
            } else {
              likedPosts.add(event.postId);
              posts
                  .where((element) => element.id == event.postId)
                  .first
                  .favorites
                  .add(UserLocal().getUser()!.id);
            }
            emit(PostLoaded(posts: posts, likedPosts: likedPosts));
          },
        );
      },
    );
  }

  Future<void> _searchPost(
      SearchPostEvent event, Emitter<PostState> emit) async {
    // emit(PostLoading());
    await _postRepository
        .searchPost(groupId: event.groupId, searchTitle: event.searchTitle)
        .then(
      (result) {
        result.fold(
          (failure) {
            emit(PostLoadFailure());
          },
          (listPost) {
            posts = listPost.posts;
            likedPosts = listPost.posts
                .where((element) =>
                    element.favorites.contains(UserLocal().getUser()!.id))
                .toList()
                .map((e) => e.id)
                .toList();
            emit(PostLoaded(posts: posts, likedPosts: likedPosts));
          },
        );
      },
    );
  }

  final PostRepository _postRepository;
  int total = 0;
  List<Post> posts = [];
  List<String> likedPosts = [];
}
