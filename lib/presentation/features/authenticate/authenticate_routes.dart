import 'package:exchange_language_mobile/common/constants/route_constants.dart';
import 'package:flutter/material.dart';

import 'pages/login_screens.dart';
import 'pages/sign_up_screen.dart';
import 'pages/verification_screen.dart';

class AuthenticateRoutes {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) {
    return {
      RouteConstants.login: (context) => const LoginScreen(),
      RouteConstants.signUp: (context) => const SignUpScreen(),
      RouteConstants.verification: (context) => const VerificationScreen(),
    };
  }
}
