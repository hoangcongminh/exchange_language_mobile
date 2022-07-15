part of 'update_profile_info_bloc.dart';

abstract class UpdateProfileInfoEvent extends Equatable {
  const UpdateProfileInfoEvent();

  @override
  List<Object> get props => [];
}

class FetchProfileInfoEvent extends UpdateProfileInfoEvent {}
