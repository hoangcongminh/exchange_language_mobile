import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repository/blog_repository.dart';
import '../../../../domain/repository/media_repository.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc(this._blogRepository, this._mediaRepository) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {});
  }

  final BlogRepository _blogRepository;
  final MediaRepository _mediaRepository;
}
