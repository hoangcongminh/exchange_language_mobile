import 'package:exchange_language_mobile/data/repositories/auth_repository_impl.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/bloc/authenticate_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/application_bloc.dart';

class AppBloc {
  static final authenticateBloc = AuthenticateBloc(AuthRepositoryImpl());
  static final applicationBloc = ApplicationBloc();

  static final List<BlocProvider> providers = [
    BlocProvider<ApplicationBloc>(
      create: (context) => applicationBloc,
    ),
    BlocProvider<AuthenticateBloc>(
      create: (context) => authenticateBloc,
    ),
  ];

  static void initialHomeBloc() {
    authenticateBloc.add(RefreshTokenEvent());
  }
}
