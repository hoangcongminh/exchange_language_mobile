import 'package:exchange_language_mobile/data/repositories/auth_repository_impl.dart';
import 'package:exchange_language_mobile/presentation/common/locale/cubit/locale_cubit.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/bloc/authenticate_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/chat/bloc/chat_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/verification/bloc/verification_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/application_bloc.dart';

class AppBloc {
  static final localeCubit = LocaleCubit();
  static final authenticateBloc = AuthenticateBloc(AuthRepositoryImpl());
  static final verificationBloc = VerificationBloc(AuthRepositoryImpl());
  static final applicationBloc = ApplicationBloc();
  static final dashboardBloc = DashboardBloc();
  static final chatBloc = ChatBloc();

  static final List<BlocProvider> providers = [
    BlocProvider<LocaleCubit>(
      create: (context) => localeCubit,
    ),
    BlocProvider<ApplicationBloc>(
      create: (context) => applicationBloc,
    ),
    BlocProvider<AuthenticateBloc>(
      create: (context) => authenticateBloc,
    ),
    BlocProvider<VerificationBloc>(
      create: (context) => verificationBloc,
    ),
    BlocProvider<DashboardBloc>(
      create: (context) => dashboardBloc,
    ),
    BlocProvider<ChatBloc>(
      create: (context) => chatBloc,
    ),
  ];

  static void initialHomeBloc() {
    authenticateBloc.add(RefreshTokenEvent());
  }
}
