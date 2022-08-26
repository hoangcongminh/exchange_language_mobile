import 'package:equatable/equatable.dart';
import 'package:exchange_language_mobile/domain/entities/language.dart';

class User extends Equatable {
  final String id;
  final String fullname;
  final int? role;
  final List<String>? friends;
  final String? email;
  final Avatar? avatar;
  final List<Language>? learningLanguage;
  final List<Language>? speakingLanguage;
  final Teacher? teacher;
  final String? introduction;

  const User({
    required this.id,
    required this.fullname,
    this.friends,
    this.role,
    this.email,
    this.avatar,
    this.learningLanguage,
    this.speakingLanguage,
    this.teacher,
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
        teacher,
        introduction
      ];
}

class Teacher extends Equatable {
  final String id;
  final List<Language>? teachingLanguage;
  final List<Rate> rate;
  const Teacher({
    required this.id,
    required this.rate,
    this.teachingLanguage,
  });

  @override
  List<Object?> get props => [id, teachingLanguage];
}

class Rate extends Equatable {
  final String id;
  final String author;
  final int star;
  const Rate({
    required this.id,
    required this.author,
    required this.star,
  });

  @override
  List<Object?> get props => [id, author, star];
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

class ListUser extends Equatable {
  final List<User> users;
  final int total;

  const ListUser({
    required this.users,
    required this.total,
  });
  @override
  List<Object?> get props => [
        users,
        total,
      ];
}
