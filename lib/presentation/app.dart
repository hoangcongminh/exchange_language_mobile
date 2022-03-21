import 'package:exchange_language_mobile/presentation/theme/theme.dart';
import 'package:flutter/material.dart';

import 'features/routes.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.login,
      onGenerateRoute: Routes.generateRoute,
      theme: defaultTheme(),
    );
  }
}
