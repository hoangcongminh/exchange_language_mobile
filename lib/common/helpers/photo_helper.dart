import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'path_helper.dart';

class PhotoHelper {
  Future<File?> compressImage(String imagePath) async {
    final dir = await PathHelper.tempDir;
    final dirPath = dir.absolute.path.endsWith(Platform.pathSeparator)
        ? dir.absolute.path
        : '${dir.absolute.path}${Platform.pathSeparator}';
    final targetPath =
        '$dirPath${imagePath.split(Platform.pathSeparator).last}_temp.jpg';
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      imagePath,
      targetPath,
      quality: 50,
    );
    if (compressedFile != null) {
      return compressedFile;
    } else {
      return null;
    }
  }
}
