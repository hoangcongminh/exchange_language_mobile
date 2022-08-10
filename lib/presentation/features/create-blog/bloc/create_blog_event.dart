part of 'create_blog_bloc.dart';

abstract class CreateBlogEvent extends Equatable {
  const CreateBlogEvent();

  @override
  List<Object> get props => [];
}

class CreateNewBlogEvent extends CreateBlogEvent {
  final File? thubmnail;
  final String title;
  final String content;

  const CreateNewBlogEvent({
    this.thubmnail,
    required this.title,
    required this.content,
  });
}
