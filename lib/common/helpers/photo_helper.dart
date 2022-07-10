import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'path_helper.dart';

class PhotoHelper {
  Future<File?> compressImage(String imagePath) async {
    final dir = await PathHelper.tempDir;
    if (File('${dir.absolute.path}/temp.jpg').existsSync()) {
      File('${dir.absolute.path}/temp.jpg').delete();
    }
    File? compressedFile = await FlutterImageCompress.compressAndGetFile(
      imagePath,
      '${dir.absolute.path}/temp.jpg',
    );
    if (compressedFile != null) {
      return compressedFile;
    } else {
      return null;
    }
  }
}
