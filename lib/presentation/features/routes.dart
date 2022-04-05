import 'package:exchange_language_mobile/presentation/features/authenticate/authenticate_routes.dart';
import 'package:exchange_language_mobile/presentation/features/dashboard/dashboard_routes.dart';
import 'package:exchange_language_mobile/presentation/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> _getAll(RouteSettings settings) => {
        ...AuthenticateRoutes.getAll(settings),
        ...DashboardRoutes.getAll(settings),
      };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final _builder = _getAll(settings)[settings.name] ?? initialRoute();

    return MaterialPageRoute(
      builder: _builder,
      settings: settings,
      fullscreenDialog: false,
    );
  }

  static WidgetBuilder initialRoute() => (context) => const SplashScreen();
}
