import 'package:equatable/equatable.dart';
import 'package:exchange_language_mobile/domain/entities/language.dart';

class User extends Equatable {
  final String id;
  final String fullname;
  final int? role;
  final String? email;
  final Avatar? avatar;
  final List<Language>? learningLanguage;
  final List<Language>? speakingLanguage;
  final String? introduction;

  const User({
    required this.id,
    required this.fullname,
    this.role,
    this.email,
    this.avatar,
    this.learningLanguage,
    this.speakingLanguage,
    this.introduction,
  });

  @override
  List<Object?> get props => [
        id,
        fullname,
        role,
        email,
        avatar,
        speakingLanguage,
        learningLanguage,
        introduction
      ];
}

class Avatar extends Equatable {
  final String id;

  final String src;

  const Avatar({
    required this.id,
    required this.src,
  });

  @override
  List<Object?> get props => [id, src];
}
