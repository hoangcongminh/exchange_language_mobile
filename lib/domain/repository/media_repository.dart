import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/media.dart';

abstract class MediaRepository {
  Future<Either<Failure, Media>> uploadImage(File image);

  Future<Either<Failure, Media>> uploadAudio(File audio);
}
