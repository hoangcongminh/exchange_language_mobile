import 'package:flutter/material.dart';

import 'authenticate/login_screens.dart';

class Routes {
  static const String login = 'login';


  static Map<String, WidgetBuilder> _getAll(RouteSettings settings) => {
      Routes.login: (context) => const LoginScreen()
    };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final _builder = _getAll(settings)[settings.name];
    return MaterialPageRoute(
      builder: _builder!,
      settings: settings,
      fullscreenDialog: false,
    );
  }
}
