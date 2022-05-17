import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String fullname;
  final String email;
  final Avatar avatar;

  const User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.avatar,
  });

  @override
  List<Object?> get props => [id, fullname, email, avatar];
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
