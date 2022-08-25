part of 'create_chat_group_bloc.dart';

abstract class CreateChatGroupEvent extends Equatable {
  const CreateChatGroupEvent();

  @override
  List<Object> get props => [];
}

class CreateGroupChat extends CreateChatGroupEvent {
  final String groupName;
  final File? avatar;
  final List<String> members;

  const CreateGroupChat({
    required this.groupName,
    this.avatar,
    required this.members,
  });

  @override
  List<Object> get props => [groupName, members];
}
