import 'package:equatable/equatable.dart';

class Media extends Equatable {
  final String id;
  final String filename;
  final String? src;

  const Media({
    required this.id,
    required this.filename,
    this.src,
  });

  @override
  List<Object?> get props => [id, filename, src];
}
