part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Conversation> conversations;

  const ChatLoaded(this.conversations);
}

class ChatFailure extends ChatState {
  final String error;

  const ChatFailure(this.error);
}
