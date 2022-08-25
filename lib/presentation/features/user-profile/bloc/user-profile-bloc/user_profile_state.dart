part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final User user;
  final int? star;
  final int? rated;
  const UserProfileLoaded({required this.user, this.star, this.rated});

  @override
  List<Object> get props => [user];
}

class UserProfileLoadFailure extends UserProfileState {
  final String message;
  const UserProfileLoadFailure({required this.message});
}
