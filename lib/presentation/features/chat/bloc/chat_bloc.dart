import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/failure.dart';
import '../../../../domain/entities/conversation.dart';
import '../../../../domain/repository/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this.chatRepository) : super(ConversationInitial()) {
    on<FetchConversations>((event, emit) async {
      emit(ConversationLoading());
      Either<Failure, List<Conversation>> result =
          await chatRepository.getConversations();
      result.fold((failue) {
        emit(ConversationFailure(failue.toString()));
      }, (conversations) {
        emit(ConversationLoaded(conversations));
      });
    });
  }

  ChatRepository chatRepository;
}
