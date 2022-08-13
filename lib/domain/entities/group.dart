import 'package:equatable/equatable.dart';

import 'media.dart';
import 'user.dart';

class Group extends Equatable {
  final String id;
  final List<String> members;
  final String createdAt;
  final String title;
  final String slug;
  final Media? thumbnail;
  final User author;
  final String description;

  const Group({
    required this.id,
    required this.members,
    required this.createdAt,
    required this.title,
    required this.slug,
    required this.thumbnail,
    required this.author,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        members,
        createdAt,
        title,
        slug,
        thumbnail,
        author,
        description,
      ];
}

class ListGroup extends Equatable {
  final List<Group> groups;
  final int total;

  const ListGroup({
    required this.groups,
    required this.total,
  });

  @override
  List<Object?> get props => [
        groups,
        total,
      ];
}
