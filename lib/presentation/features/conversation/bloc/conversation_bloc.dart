import 'dart:async';

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
    on<RefreshMessage>(_refreshMessage);
  }

  _fetchMessages(FetchMessage event, Emitter emit) async {
    if (hasReachedMax) {
    } else {}
    Either<Failure, List<Message>> result =
        await chatRepository.getMessagesByConversation(
      conversationId: event.conversationId,
      skip: event.skip,
      limit: limit,
    );
    result.fold((failue) {
      emit(ConversationFailure());
    }, (dataMessages) {
      if (dataMessages.isEmpty) {
        hasReachedMax == true;
      } else {
        messages = List.of(dataMessages)..addAll(messages);
        emit(ConversationLoaded(messages: messages));
      }
    });
  }

  Future<void> _refreshMessage(
      RefreshMessage event, Emitter<ConversationState> emit) async {
    emit(ConversationLoading());
    Either<Failure, List<Message>> result =
        await chatRepository.getMessagesByConversation(
      conversationId: event.conversationId,
      limit: limit,
    );
    result.fold((failue) {
      emit(ConversationFailure());
    }, (dataMessages) {
      hasReachedMax == false;
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
  int limit = 20;
  bool hasReachedMax = false;
  ChatRepository chatRepository;
}
