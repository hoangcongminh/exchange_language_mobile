part of 'update_profile_info_bloc.dart';

abstract class UpdateProfileInfoState extends Equatable {
  const UpdateProfileInfoState();

  @override
  List<Object> get props => [];
}

class UpdateProfileInfoInitial extends UpdateProfileInfoState {}

class UpdateProfileInfoLoading extends UpdateProfileInfoState {}

class UpdateProfileInfoSuccess extends UpdateProfileInfoState {}

class UpdateProfileInfoFailure extends UpdateProfileInfoState {
  final String message;
  const UpdateProfileInfoFailure({required this.message});
}
