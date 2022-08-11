import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/failure.dart';
import '../../../../domain/entities/group.dart';
import '../../../../domain/repository/group_repository.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc(this._groupRepository) : super(GroupInitial()) {
    on<GroupEvent>((event, emit) {});
    on<FetchGroupsEvent>(_fetchGroup);
  }

  Future<void> _fetchGroup(
      FetchGroupsEvent event, Emitter<GroupState> emit) async {
    emit(GroupLoading());
    Either<Failure, ListGroup> result = await _groupRepository.fetchGroups();
    result.fold(
      (failue) {
        emit(GroupLoadFailure());
      },
      (listGroup) {
        emit(GroupLoaded(groups: listGroup.groups));
      },
    );
  }

  final GroupRepository _groupRepository;
}
