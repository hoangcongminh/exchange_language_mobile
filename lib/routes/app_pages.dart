import 'package:flutter/material.dart';

import '../common/constants/route_constants.dart';
import '../presentation/app.dart';
import '../presentation/features/authenticate/pages/forgot_password_screen.dart';
import '../presentation/features/authenticate/pages/login_screen.dart';
import '../presentation/features/authenticate/pages/register_screen.dart';
import '../presentation/features/conversation/pages/conversation_screen.dart';
import '../presentation/features/dashboard/pages/dashboard_screen.dart';
import '../presentation/features/filter/pages/result_screen.dart';
import '../presentation/features/setting/setting_screen.dart';
import '../presentation/features/verification/pages/input_email_screen.dart';
import '../presentation/features/verification/pages/verification_screen.dart';
import 'app_navigator_observer.dart';
import 'scaffold_wrapper.dart';

class AppNavigator extends RouteObserver<PageRoute<dynamic>> {
  static final _instance = AppNavigator._();

  factory AppNavigator() {
    return _instance;
  }

  AppNavigator._();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Route<dynamic> getRoute(RouteSettings settings) {
    Map<String, dynamic>? arguments = _getArguments(settings);
    switch (settings.name) {
      case RouteConstants.root:
        return _buildRoute(
          settings,
          const Application(),
        );
      case RouteConstants.home:
        return _buildRoute(
          settings,
          const ScaffoldWrapper(child: DashboardScreen()),
        );
      case RouteConstants.login:
        return _buildRoute(
          settings,
          const LoginScreen(),
        );
      case RouteConstants.register:
        return _buildRoute(
          settings,
          RegisterScreen(
            email: arguments?['email'],
          ),
        );
      case RouteConstants.inputEmail:
        return _buildRoute(
          settings,
          InputEmailScreen(
            isForgotPassword: arguments?['isForgotPassword'],
          ),
        );
      case RouteConstants.verification:
        return _buildRoute(
          settings,
          VerificationScreen(
            email: arguments?['email'],
          ),
        );
      case RouteConstants.forgotPassword:
        return _buildRoute(
          settings,
          ForgotPasswordScreen(
            email: arguments?['email'],
          ),
        );
      case RouteConstants.filterResult:
        return _buildRoute(
          settings,
          const ResultScreen(),
        );
      case RouteConstants.conversation:
        return _buildRoute(
          settings,
          const ConversationScreen(),
        );
      case RouteConstants.setting:
        return _buildRoute(
          settings,
          const SettingScreen(),
        );
      default:
        return _buildRoute(settings, const LoginScreen());
    }
  }

  _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => ScaffoldWrapper(child: builder),
    );
  }

  _getArguments(RouteSettings settings) {
    return settings.arguments;
  }

  Future push<T>(
    String route, {
    Object? arguments,
  }) {
    return state.pushNamed(route, arguments: arguments);
  }

  Future pushNamedAndRemoveUntil<T>(
    String route, {
    Object? arguments,
  }) {
    return state.pushNamedAndRemoveUntil(
      route,
      (route) => false,
      arguments: arguments,
    );
  }

  Future replaceWith<T>(
    String route, {
    Map<String, dynamic>? arguments,
  }) {
    return state.pushReplacementNamed(route, arguments: arguments);
  }

  void popUntil<T>(String route) {
    state.popUntil(ModalRoute.withName(route));
  }

  void pop() {
    if (canPop) {
      state.pop();
    }
  }

  bool get canPop => state.canPop();

  String? currentRoute() => AppNavigatorObserver.currentRouteName;

  BuildContext? get context => navigatorKey.currentContext;

  NavigatorState get state => navigatorKey.currentState!;
}