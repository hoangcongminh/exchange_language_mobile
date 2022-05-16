import 'package:equatable/equatable.dart';

import 'media.dart';

class Language extends Equatable {
  final String id;
  final String name;
  final String code;
  final Media thumbnail;

  const Language({
    required this.id,
    required this.name,
    required this.code,
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [id, name, code, thumbnail];
}
