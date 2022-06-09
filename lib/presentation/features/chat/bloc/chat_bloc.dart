import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/failure.dart';
import '../../../../domain/entities/conversation.dart';
import '../../../../domain/repository/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this.chatRepository) : super(ChatInitial()) {
    on<FetchConversations>(_fetchConversations);
  }

  _fetchConversations(FetchConversations event, Emitter emit) async {
    emit(ChatLoading());
    Either<Failure, List<Conversation>> result =
        await chatRepository.getConversations();
    result.fold((failue) {
      emit(ChatFailure(failue.toString()));
    }, (conversations) {
      emit(ChatLoaded(conversations));
    });
  }

  ChatRepository chatRepository;
}
