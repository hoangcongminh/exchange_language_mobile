import 'package:flutter/material.dart';

import '../../../common/constants/route_constants.dart';
import 'pages/dashboard_screen.dart';

class DashboardRoutes {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) {
    return {
      RouteConstants.home: (context) => const DashboardScreen(),
    };
  }
}
