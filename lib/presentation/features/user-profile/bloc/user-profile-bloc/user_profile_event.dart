part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class GetUserProfileEvent extends UserProfileEvent {
  final String userId;
  const GetUserProfileEvent({required this.userId});
}

class RateTeacherEvent extends UserProfileEvent {
  final String userId;
  final int star;
  const RateTeacherEvent({required this.userId, required this.star});
}
