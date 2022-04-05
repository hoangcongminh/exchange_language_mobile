import 'package:exchange_language_mobile/common/constants/route_constants.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/pages/forgot_password_screen.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/pages/input_email_screen.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/pages/register_screen.dart';
import 'package:flutter/material.dart';

import 'pages/login_screen.dart';
import 'pages/verification_screen.dart';

class AuthenticateRoutes {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) {
    return {
      RouteConstants.login: (context) => const LoginScreen(),
      RouteConstants.inputEmail: (context) => const InputEmailScreen(),
      RouteConstants.register: (context) => const RegisterScreen(),
      RouteConstants.forgotPassword: (context) => const ForgotPasswordScreen(),
      RouteConstants.verification: (context) => const VerificationScreen(),
    };
  }
}
