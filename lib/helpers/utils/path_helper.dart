import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;

class PathHelper {
    static Future<Directory> get appDir async => await path_provider.getApplicationDocumentsDirectory();
  }
