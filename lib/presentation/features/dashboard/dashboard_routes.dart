import 'package:exchange_language_mobile/common/constants/route_constants.dart';
import 'package:exchange_language_mobile/presentation/features/dashboard/pages/dashboard_screen.dart';
import 'package:flutter/material.dart';

class DashboardRoutes {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) {
    return {
      RouteConstants.home: (context) => const DashboardScreen(),
    };
  }
}
