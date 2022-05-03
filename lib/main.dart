import 'package:device_preview/device_preview.dart';
import 'package:exchange_language_mobile/bootstrap.dart';
import 'package:exchange_language_mobile/presentation/app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() => const Application());
  // runApp(
  //   DevicePreview(
  //     builder: (context) => const Application(),
  //   ),
  // );
}
