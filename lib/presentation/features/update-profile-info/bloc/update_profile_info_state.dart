part of 'update_profile_info_bloc.dart';

abstract class UpdateProfileInfoState extends Equatable {
  const UpdateProfileInfoState();

  @override
  List<Object> get props => [];
}

class UpdateProfileInfoInitial extends UpdateProfileInfoState {}

class LoadingUpdateProfileInfo extends UpdateProfileInfoState {}

class LoadedUpdateProfileInfo extends UpdateProfileInfoState {
  final User user;

  const LoadedUpdateProfileInfo(this.user);

  @override
  List<Object> get props => [user];
}
