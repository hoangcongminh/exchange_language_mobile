import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange_language_mobile/common/services/socket/socket_emit.dart';
import 'package:exchange_language_mobile/domain/repository/media_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/failure.dart';
import '../../../../domain/entities/conversation.dart';
import '../../../../domain/entities/message.dart';
import '../../../../domain/repository/chat_repository.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc(this.chatRepository, this.mediaRepository)
      : super(ConversationInitial()) {
    on<FetchMessage>(_fetchMessages);
    on<ReceiveNewMessage>(_receiveNewMessage);
    on<SendMessage>(_sendMessage);
    on<SendAudioMessage>(_sendAudioMessage);
    on<SendIconMessage>(_sendIconMessage);
    on<RefreshMessage>(_refreshMessage);
    on<CreateOrGetMessage>(_createOrGetMessage);
  }

  _fetchMessages(FetchMessage event, Emitter emit) async {
    Either<Failure, DataMessage> result =
        await chatRepository.getMessagesByConversation(
      conversationId: event.conversationId,
      skip: event.skip,
      limit: limit,
    );
    result.fold((failue) {
      emit(ConversationFailure());
    }, (dataMessages) {
      conversation = dataMessages.conversationInfo;
      if (dataMessages.messages.isEmpty) {
        hasReachedMax == true;
      } else {
        messages = List.of(dataMessages.messages)..addAll(messages);
        emit(ConversationLoaded(
            messages: messages,
            isScroll: false,
            conversation: dataMessages.conversationInfo));
      }
    });
  }

  Future<void> _refreshMessage(
      RefreshMessage event, Emitter<ConversationState> emit) async {
    emit(ConversationLoading());
    Either<Failure, DataMessage> result =
        await chatRepository.getMessagesByConversation(
      conversationId: event.conversationId,
      limit: limit,
    );
    result.fold((failue) {
      emit(ConversationFailure());
    }, (dataMessages) {
      hasReachedMax == false;
      messages = dataMessages.messages;
      conversation = dataMessages.conversationInfo;

      emit(ConversationLoaded(
        messages: messages,
        isScroll: true,
        conversation: dataMessages.conversationInfo,
      ));
    });
  }

  Future<void> _createOrGetMessage(
      CreateOrGetMessage event, Emitter<ConversationState> emit) async {
    emit(ConversationLoading());
    await chatRepository
        .createOrGetMessageByUserId(userId: event.userId)
        .then((result) {
      result.fold((failue) {
        emit(ConversationFailure());
      }, (dataMessages) {
        conversation = dataMessages.conversationInfo;
        hasReachedMax == false;
        messages = dataMessages.messages;
        emit(ConversationLoaded(
          messages: messages,
          isScroll: true,
          conversation: dataMessages.conversationInfo,
        ));
      });
    });
  }

  _receiveNewMessage(ReceiveNewMessage event, Emitter emit) {
    emit(ConversationLoading());

    if (event.message.conversationId == conversation!.id) {
      messages.add(event.message);
      emit(ConversationLoaded(
        messages: messages,
        isScroll: true,
        conversation: conversation!,
      ));
    } else {
      emit(ConversationLoaded(
        messages: messages,
        isScroll: true,
        conversation: conversation!,
      ));
    }
  }

  _sendMessage(SendMessage event, Emitter emit) async {
    SocketEmit().sendMessage(
        conversationId: event.conversationId, content: event.content, type: 0);
    await chatRepository
        .getMessagesByConversation(
      conversationId: event.conversationId,
      limit: null,
    )
        .then((result) {
      result.fold((failure) {
        emit(ConversationFailure());
      }, (dataMessage) {
        messages = List.of(messages)..add(dataMessage.messages.last);
        emit(ConversationLoaded(
            messages: messages,
            isScroll: true,
            conversation: dataMessage.conversationInfo));
      });
    });
  }

  _sendAudioMessage(SendAudioMessage event, Emitter emit) async {
    await mediaRepository.uploadAudio(event.audio).then((audioResult) async {
      await audioResult.fold((failure) {
        emit(ConversationFailure());
      }, (audio) async {
        SocketEmit().sendMessage(
            conversationId: event.conversationId, content: audio.src!, type: 1);
        await chatRepository
            .getMessagesByConversation(
          conversationId: event.conversationId,
          limit: null,
        )
            .then(
          (result) {
            result.fold(
              (failure) {
                emit(ConversationFailure());
              },
              (dataMessage) {
                messages = List.of(messages)..add(dataMessage.messages.last);
                emit(ConversationLoaded(
                  messages: messages,
                  isScroll: true,
                  conversation: dataMessage.conversationInfo,
                ));
              },
            );
          },
        );
      });
    });
  }

  Future<void> _sendIconMessage(
      SendIconMessage event, Emitter<ConversationState> emit) async {
    SocketEmit().sendMessage(
        conversationId: event.conversationId, content: event.content, type: 2);
    await chatRepository
        .getMessagesByConversation(
      conversationId: event.conversationId,
      limit: null,
    )
        .then((result) {
      result.fold((failure) {
        emit(ConversationFailure());
      }, (dataMessage) {
        messages = List.of(messages)..add(dataMessage.messages.last);
        emit(ConversationLoaded(
            messages: messages,
            isScroll: true,
            conversation: dataMessage.conversationInfo));
      });
    });
  }

  List<Message> messages = [];
  int limit = 20;
  bool hasReachedMax = false;
  Conversation? conversation;

  ChatRepository chatRepository;
  MediaRepository mediaRepository;
}
