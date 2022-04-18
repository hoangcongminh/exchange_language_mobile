import 'package:exchange_language_mobile/data/repositories/auth_repository_impl.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/bloc/authenticate_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/application_bloc.dart';

class AppBloc {
  static final authenticateBloc = AuthenticateBloc(AuthRepositoryImpl());
  static final applicationBloc = ApplicationBloc();
  static final dashboardBloc = DashboardBloc();

  static final List<BlocProvider> providers = [
    BlocProvider<ApplicationBloc>(
      create: (context) => applicationBloc,
    ),
    BlocProvider<AuthenticateBloc>(
      create: (context) => authenticateBloc,
    ),
    BlocProvider<DashboardBloc>(
      create: (context) => dashboardBloc,
    ),
  ];

  static void initialHomeBloc() {
    authenticateBloc.add(RefreshTokenEvent());
  }
}
