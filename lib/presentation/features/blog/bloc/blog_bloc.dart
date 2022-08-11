import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/failure.dart';
import '../../../../domain/entities/blog.dart';
import '../../../../domain/repository/blog_repository.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc(this._blogRepository) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {});
    on<FetchBlogsEvent>(_fetchBlogs);
    on<RefreshBlogsEvent>(_refreshBlogs);
  }

  Future<void> _fetchBlogs(
      FetchBlogsEvent event, Emitter<BlogState> emit) async {
    emit(BlogsLoading());
    Either<Failure, ListBlog> result =
        await _blogRepository.fetchBlogs(skip: blogs.length);
    result.fold((failure) {
      emit(BlogsLoadFailure());
    }, (listBlog) {
      total = listBlog.total;
      blogs.addAll(listBlog.blogs);
      emit(BlogsLoaded(blogs: blogs));
    });
  }

  Future<void> _refreshBlogs(
      RefreshBlogsEvent event, Emitter<BlogState> emit) async {
    emit(BlogsLoading());
    blogs = [];
    Either<Failure, ListBlog> result = await _blogRepository.fetchBlogs();
    result.fold((failure) {
      emit(BlogsLoadFailure());
    }, (listBlog) {
      total = listBlog.total;
      blogs.addAll(listBlog.blogs);
      emit(BlogsLoaded(blogs: blogs));
    });
  }

  final BlogRepository _blogRepository;
  int total = 0;
  List<Blog> blogs = [];
}
