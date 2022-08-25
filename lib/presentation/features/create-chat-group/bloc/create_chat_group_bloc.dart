import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:exchange_language_mobile/data/datasources/local/user_local_data.dart';
import 'package:exchange_language_mobile/domain/repository/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/conversation.dart';
import '../../../../domain/repository/media_repository.dart';

part 'create_chat_group_event.dart';
part 'create_chat_group_state.dart';

class CreateChatGroupBloc
    extends Bloc<CreateChatGroupEvent, CreateChatGroupState> {
  CreateChatGroupBloc(this._chatRepository, this._mediaRepository)
      : super(CreateChatGroupInitial()) {
    on<CreateChatGroupEvent>((event, emit) {});
    on<CreateGroupChat>(_createGroupChat);
  }

  Future<void> _createGroupChat(
      CreateGroupChat event, Emitter<CreateChatGroupState> emit) async {
    emit(CreateChatGroupLoading());
    if (event.avatar == null) {
      emit(CreateChatGroupFailure(message: 'Invalid image'));
    } else {
      await _mediaRepository.uploadImage(event.avatar!).then((result) async {
        await result.fold((failure) {
          emit(CreateChatGroupFailure(message: failure.message));
        }, (avatar) async {
          await _chatRepository
              .createConversation(
            groupChatName: event.groupName,
            memberIds: event.members..add(UserLocal().getUser()!.id),
            thumbnailId: avatar.id,
          )
              .then((result) {
            result.fold((failure) {
              emit(CreateChatGroupFailure(message: failure.message));
            }, (conversation) {
              emit(CreateChatGroupSuccess(conversation: conversation));
            });
          });
        });
      });
    }
  }

  final ChatRepository _chatRepository;
  final MediaRepository _mediaRepository;
}
