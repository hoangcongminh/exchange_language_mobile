import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/failure.dart';
import '../../../../../domain/entities/group.dart';
import '../../../../../domain/repository/group_repository.dart';

part 'group_detail_event.dart';
part 'group_detail_state.dart';

class GroupDetailBloc extends Bloc<GroupDetailEvent, GroupDetailState> {
  GroupDetailBloc(this._groupRepository) : super(GroupDetailInitial()) {
    on<GroupDetailEvent>((event, emit) {});
    on<FetchGroupDetail>(_fetchGroupDetail);
    on<JoinGroup>(_joinGroup);
    on<LeaveGroup>(_leaveGroup);
  }

  Future<void> _fetchGroupDetail(
      FetchGroupDetail event, Emitter<GroupDetailState> emit) async {
    emit(GroupDetailLoading());
    Either<Failure, Group> result =
        await _groupRepository.fetchGroupDetail(slug: event.slug);
    result.fold(
      (failure) {
        emit(GroupDetailFailure(message: failure.message));
      },
      (group) {
        emit(GroupDetailLoaded(group: group));
      },
    );
  }

  FutureOr<void> _joinGroup(
      JoinGroup event, Emitter<GroupDetailState> emit) async {
    emit(GroupDetailLoading());
    await _groupRepository.joinGroup(groupId: event.id).then(
      (result) {
        result.fold(
          (failure) {
            emit(GroupDetailFailure(message: failure.message));
          },
          (_) async {
            emit(GroupDetailJoinSuccess(event.slug));
          },
        );
      },
    );
  }

  Future<void> _leaveGroup(
      LeaveGroup event, Emitter<GroupDetailState> emit) async {
    await _groupRepository.leaveGroup(groupId: event.id).then(
      (result) {
        result.fold(
          (failure) {
            emit(GroupDetailFailure(message: failure.message));
          },
          (_) async {
            emit(GroupDetailLeaveSuccess());
          },
        );
      },
    );
  }

  final GroupRepository _groupRepository;
}
