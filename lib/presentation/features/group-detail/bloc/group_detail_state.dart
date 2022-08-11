part of 'group_detail_bloc.dart';

abstract class GroupDetailState extends Equatable {
  const GroupDetailState();
  
  @override
  List<Object> get props => [];
}

class GroupDetailInitial extends GroupDetailState {}
