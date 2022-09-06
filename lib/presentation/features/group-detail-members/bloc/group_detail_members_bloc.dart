import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/user.dart';
import '../../../../domain/repository/group_repository.dart';

part 'group_detail_members_event.dart';
part 'group_detail_members_state.dart';

class GroupDetailMembersBloc
    extends Bloc<GroupDetailMembersEvent, GroupDetailMembersState> {
  GroupDetailMembersBloc(this._groupRepository)
      : super(GroupDetailMembersInitial()) {
    on<GroupDetailMembersEvent>((event, emit) {});
    on<FetchGroupRequests>(_fetchGroupRequests);
    on<AcceptJoinGroupRequest>(_acceptJoinGroupRequest);
    on<RejectJoinGroupRequest>(_rejectJoinGroupRequest);
  }

  Future<void> _fetchGroupRequests(
      FetchGroupRequests event, Emitter<GroupDetailMembersState> emit) async {
    emit(GroupDetailMembersLoading());
    await _groupRepository
        .getListRequest(groupId: event.groupId)
        .then((result) {
      result.fold((failure) {
        emit(GroupDetailMembersFailure(message: failure.message));
      }, (requests) {
        emit(GroupDetailMembersLoaded(requests: requests));
      });
    });
  }

  Future<void> _acceptJoinGroupRequest(AcceptJoinGroupRequest event,
      Emitter<GroupDetailMembersState> emit) async {
    emit(GroupDetailMembersLoading());
    await _groupRepository
        .acceptRequestJoin(groupId: event.groupId, userId: event.userId)
        .then((result) async {
      await result.fold(
        (failure) {
          emit(GroupDetailMembersFailure(message: failure.message));
        },
        (_) async {
          await _groupRepository
              .getListRequest(groupId: event.groupId)
              .then((result) {
            result.fold((failure) {
              emit(GroupDetailMembersFailure(message: failure.message));
            }, (requests) {
              emit(GroupDetailMembersLoaded(requests: requests));
            });
          });
        },
      );
    });
  }

  Future<void> _rejectJoinGroupRequest(RejectJoinGroupRequest event,
      Emitter<GroupDetailMembersState> emit) async {
    emit(GroupDetailMembersLoading());
    await _groupRepository
        .rejectRequestJoin(groupId: event.groupId, userId: event.userId)
        .then((result) async {
      await result.fold(
        (failure) {
          emit(GroupDetailMembersFailure(message: failure.message));
        },
        (_) async {
          await _groupRepository
              .getListRequest(groupId: event.groupId)
              .then((result) {
            result.fold((failure) {
              emit(GroupDetailMembersFailure(message: failure.message));
            }, (requests) {
              emit(GroupDetailMembersLoaded(requests: requests));
            });
          });
        },
      );
    });
  }

  final GroupRepository _groupRepository;
}
