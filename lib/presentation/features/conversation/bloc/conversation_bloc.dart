import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange_language_mobile/common/services/socket/socket_emit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/failure.dart';
import '../../../../domain/entities/message.dart';
import '../../../../domain/repository/chat_repository.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc(this.chatRepository) : super(ConversationInitial()) {
    on<FetchMessage>(_fetchMessages);
    on<ReceiveNewMessage>(_receiveNewMessage);
    on<SendMessage>(_sendMessage);
  }

  _fetchMessages(FetchMessage event, Emitter emit) async {
    emit(ConversationLoading());
    Either<Failure, List<Message>> result =
        await chatRepository.getMessagesByConversation(event.conversationId);
    result.fold((failue) {
      emit(ConversationFailure());
    }, (dataMessages) {
      messages = dataMessages;
      emit(ConversationLoaded(messages: messages));
    });
  }

  _receiveNewMessage(ReceiveNewMessage event, Emitter emit) {
    emit(ConversationLoading());
    messages.add(event.message);
    emit(ConversationLoaded(messages: messages));
  }

  _sendMessage(SendMessage event, Emitter emit) {
    SocketEmit().sendMessage(
        conversationId: event.conversationId, content: event.content);
  }

  List<Message> messages = [];
  ChatRepository chatRepository;
}
