import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String fullname;
  final String email;

  const User({
    required this.id,
    required this.fullname,
    required this.email,
  });

  @override
  List<Object?> get props => [id, fullname, email];
}
