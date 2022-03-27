import 'package:device_preview/device_preview.dart';
import 'package:exchange_language_mobile/data/datasources/local/base_local_data.dart';
import 'package:exchange_language_mobile/presentation/app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BaseLocalData.initialBox();

  runApp(
    DevicePreview(
      builder: (context) => const Application(),
    ),
  );
}
