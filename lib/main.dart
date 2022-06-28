import 'package:flutter/material.dart';

import 'bootstrap.dart';
import 'presentation/app.dart';
import '../../../common/configs/application.dart' as app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await app.Application().initialApplication();
  bootstrap(() => const Application());
  // runApp(
  //   DevicePreview(
  //     builder: (context) => const Application(),
  //   ),
  // );
}
