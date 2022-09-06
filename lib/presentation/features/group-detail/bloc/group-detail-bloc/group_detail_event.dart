part of 'group_detail_bloc.dart';

abstract class GroupDetailEvent extends Equatable {
  const GroupDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchGroupDetail extends GroupDetailEvent {
  final String groupId;
  const FetchGroupDetail({required this.groupId});

  @override
  List<Object> get props => [groupId];
}

class JoinGroup extends GroupDetailEvent {
  final String id;
  final String groupId;
  const JoinGroup({
    required this.id,
    required this.groupId,
  });

  @override
  List<Object> get props => [id, groupId];
}

class LeaveGroup extends GroupDetailEvent {
  final String id;
  final String slug;
  const LeaveGroup({
    required this.id,
    required this.slug,
  });

  @override
  List<Object> get props => [id, slug];
}

class CancelJoinRequest extends GroupDetailEvent {
  final String id;
  const CancelJoinRequest({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
