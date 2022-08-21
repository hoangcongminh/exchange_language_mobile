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
  final List<Language>? teaching;

  const UpdateProfileEvent({
    required this.fullName,
    required this.introduction,
    this.avatar,
    this.currentAvatar,
    required this.speaking,
    required this.learning,
    this.teaching,
  });

  @override
  List<Object> get props => [
        fullName,
        introduction,
        speaking,
        learning,
      ];
}

class RegisterTeacherEvent extends UpdateProfileInfoEvent {
  final List<Language> teach;
  const RegisterTeacherEvent({required this.teach});

  @override
  List<Object> get props => [teach];
}
