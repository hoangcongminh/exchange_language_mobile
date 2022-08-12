part of 'create_group_bloc.dart';

abstract class CreateGroupEvent extends Equatable {
  const CreateGroupEvent();

  @override
  List<Object> get props => [];
}

class CreateNewGroup extends CreateGroupEvent {
  final String title;
  final String description;
  final File? thumbnail;
  final List<Language> topics;

  const CreateNewGroup({
    required this.title,
    required this.description,
    this.thumbnail,
    required this.topics,
  });

  @override
  List<Object> get props => [
        title,
        description,
        topics,
      ];
}
