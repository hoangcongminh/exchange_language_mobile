part of 'group_detail_members_bloc.dart';

abstract class GroupDetailMembersEvent extends Equatable {
  const GroupDetailMembersEvent();

  @override
  List<Object> get props => [];
}

class FetchGroupRequests extends GroupDetailMembersEvent {
  final String groupId;
  const FetchGroupRequests({required this.groupId});
}

class AcceptJoinGroupRequest extends GroupDetailMembersEvent {
  final String userId;
  final String groupId;
  const AcceptJoinGroupRequest({
    required this.userId,
    required this.groupId,
  });
}

class RejectJoinGroupRequest extends GroupDetailMembersEvent {
  final String userId;
  final String groupId;
  const RejectJoinGroupRequest({
    required this.userId,
    required this.groupId,
  });
}
