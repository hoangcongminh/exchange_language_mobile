import 'package:flutter/material.dart';

import 'bootstrap.dart';
import 'presentation/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() => const Application());
  // runApp(
  //   DevicePreview(
  //     builder: (context) => const Application(),
  //   ),
  // );
}
