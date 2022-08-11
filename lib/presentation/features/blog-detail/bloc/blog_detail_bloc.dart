import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/failure.dart';
import '../../../../domain/entities/blog.dart';
import '../../../../domain/repository/blog_repository.dart';


part 'blog_detail_event.dart';
part 'blog_detail_state.dart';

class BlogDetailBloc extends Bloc<BlogDetailEvent, BlogDetailState> {
  BlogDetailBloc(this._blogRepository) : super(BlogDetailInitial()) {
    on<BlogDetailEvent>((event, emit) {});
    on<FetchBlogDetail>(_fetchBlogDetail);
    //TODO
    // on<DeleteBlogEvent>(_deleteBlog);
  }

  Future<void> _fetchBlogDetail(
      FetchBlogDetail event, Emitter<BlogDetailState> emit) async {
    emit(BlogDetailLoading());
    Either<Failure, Blog> result =
        await _blogRepository.getBlogDetail(slug: event.slug);
    result.fold((failure) {
      emit(BlogDetailFailure());
    }, (blog) {
      emit(BlogDetailLoaded(blog: blog));
    });
  }

  // Future<void> _deleteBlog(
  //     DeleteBlogEvent event, Emitter<BlogDetailState> emit) {}

  final BlogRepository _blogRepository;
}
