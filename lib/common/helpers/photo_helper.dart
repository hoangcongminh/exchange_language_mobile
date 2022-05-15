import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'path_helper.dart';

class PhotoHelper {
  Future<File?> compressImage(String imagePath) async {
    final dir = await PathHelper.tempDir;
    File? compressedFile = await FlutterImageCompress.compressAndGetFile(
      imagePath,
      dir.path + '/temp.jpg',
    );
    if (compressedFile != null) {
      return compressedFile;
    } else {
      return null;
    }
  }
}
