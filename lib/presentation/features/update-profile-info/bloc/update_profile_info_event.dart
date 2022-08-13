part of 'update_profile_info_bloc.dart';

abstract class UpdateProfileInfoEvent extends Equatable {
  const UpdateProfileInfoEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileEvent extends UpdateProfileInfoEvent {
  final String fullName;
  final String introduction;
  final File? avatar;
  final String? currentAvatar;
  final List<Language> speaking;
  final List<Language> learning;

  const UpdateProfileEvent({
    required this.fullName,
    required this.introduction,
    this.avatar,
    this.currentAvatar,
    required this.speaking,
    required this.learning,
  });

  @override
  List<Object> get props => [
        fullName,
        introduction,
        speaking,
        learning,
      ];
}
