part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ConversationInitial extends ChatState {}

class GettingConversation extends ChatState {}

class GetConversationDone extends ChatState {}
