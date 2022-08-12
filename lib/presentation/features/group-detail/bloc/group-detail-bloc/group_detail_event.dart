part of 'group_detail_bloc.dart';

abstract class GroupDetailEvent extends Equatable {
  const GroupDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchGroupDetail extends GroupDetailEvent {
  final String slug;
  const FetchGroupDetail({required this.slug});

  @override
  List<Object> get props => [slug];
}

class JoinGroup extends GroupDetailEvent {
  final String id;
  final String slug;
  const JoinGroup({
    required this.id,
    required this.slug,
  });

  @override
  List<Object> get props => [id, slug];
}
