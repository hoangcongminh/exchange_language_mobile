import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/failure.dart';
import '../../../../domain/entities/media.dart';
import '../../../../domain/repository/blog_repository.dart';
import '../../../../domain/repository/media_repository.dart';

part 'create_blog_event.dart';
part 'create_blog_state.dart';

class CreateBlogBloc extends Bloc<CreateBlogEvent, CreateBlogState> {
  CreateBlogBloc(this._blogRepository, this._mediaRepository)
      : super(CreateBlogInitial()) {
    on<CreateBlogEvent>((event, emit) {});
    on<CreateNewBlogEvent>(_createBlog);
    on<EditBlogEvent>(_editBlog);
  }

  Future<void> _createBlog(
      CreateNewBlogEvent event, Emitter<CreateBlogState> emit) async {
    emit(CreateBlogLoading());
    if (event.thubmnail == null) {
      emit(const CreateBlogFailure(error: 'Invalid image'));
    } else {
      Either<Failure, Media> imageResult =
          await _mediaRepository.uploadImage(event.thubmnail!);
      await imageResult.fold(
        (failure) {
          emit(CreateBlogFailure(error: failure.message));
        },
        (thubmnail) async {
          Either<Failure, void> result = await _blogRepository.createBlog(
            title: event.title,
            content: event.content,
            thumbnailId: thubmnail.id,
          );
          result.fold((failure) {
            emit(CreateBlogFailure(error: failure.message));
          }, (data) {
            emit(CreateBlogSuccess());
          });
        },
      );
    }
  }

  Future<void> _editBlog(
      EditBlogEvent event, Emitter<CreateBlogState> emit) async {
    emit(CreateBlogLoading());
    await Future.delayed(const Duration(seconds: 5));
    if (event.thubmnail == null) {
      Either<Failure, String> result = await _blogRepository.editBlog(
          blogId: event.blogId,
          title: event.title,
          content: event.content,
          thumbnailId: event.currentThumbnailId!);
      result.fold((failure) {
        emit(CreateBlogFailure(error: failure.message));
      }, (data) {
        emit(EditBlogSuccess(edittedSlug: data));
      });
    } else {
      Either<Failure, Media> imageResult =
          await _mediaRepository.uploadImage(event.thubmnail!);
      await imageResult.fold(
        (failure) {
          emit(CreateBlogFailure(error: failure.message));
        },
        (thubmnail) async {
          Either<Failure, String> result = await _blogRepository.editBlog(
              blogId: event.blogId,
              title: event.title,
              content: event.content,
              thumbnailId: thubmnail.id);
          result.fold((failure) {
            emit(CreateBlogFailure(error: failure.message));
          }, (data) {
            emit(EditBlogSuccess(edittedSlug: data));
          });
        },
      );
    }
  }

  final BlogRepository _blogRepository;
  final MediaRepository _mediaRepository;
}
