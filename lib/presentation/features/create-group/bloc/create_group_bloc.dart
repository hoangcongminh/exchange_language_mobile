import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/language.dart';
import '../../../../domain/repository/group_repository.dart';
import '../../../../domain/repository/media_repository.dart';

part 'create_group_event.dart';
part 'create_group_state.dart';

class CreateGroupBloc extends Bloc<CreateGroupEvent, CreateGroupState> {
  CreateGroupBloc(this._groupRepository, this._mediaRepository)
      : super(CreateGroupInitial()) {
    on<CreateGroupEvent>((event, emit) {});
    on<CreateNewGroup>(_createNewGroup);
  }

  Future<void> _createNewGroup(
      CreateNewGroup event, Emitter<CreateGroupState> emit) async {
    emit(CreateGroupLoading());
    if (event.thumbnail == null) {
      emit(const CreateGroupFailure(message: 'Thumbnail is required'));
    } else {
      await _mediaRepository
          .uploadImage(event.thumbnail!)
          .then((imageResult) => imageResult.fold(
                (failure) {
                  emit(CreateGroupFailure(message: failure.message));
                },
                (thumbnail) async {
                  await _groupRepository
                      .createGroup(
                        title: event.title,
                        thumbnailId: thumbnail.id,
                        description: event.description,
                        topics: event.topics,
                      )
                      .then(
                        (result) => result.fold((failure) {
                          emit(CreateGroupFailure(message: failure.message));
                        }, (data) {
                          emit(CreateGroupSuccess());
                        }),
                      );
                },
              ));
    }
  }

  final GroupRepository _groupRepository;
  final MediaRepository _mediaRepository;
}
