import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/blog_repository_impl.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../data/repositories/filter_repository_impl.dart';
import '../../data/repositories/group_repository_impl.dart';
import '../../data/repositories/language_repository_impl.dart';
import '../../data/repositories/media_repository_impl.dart';
import '../features/authenticate/bloc/authenticate_bloc.dart';
import '../features/blog/bloc/blog_bloc.dart';
import '../features/chat/bloc/chat_bloc.dart';
import '../features/conversation/bloc/conversation_bloc.dart';
import '../features/dashboard/bloc/dashboard_bloc.dart';
import '../features/filter/bloc/filter_bloc.dart';
import '../features/group/bloc/group_bloc.dart';
import '../features/update-profile-info/bloc/update_profile_info_bloc.dart';
import '../features/verification/bloc/verification_bloc.dart';
import 'application/application_bloc.dart';
import 'locale/cubit/locale_cubit.dart';

class AppBloc {
  static final localeCubit = LocaleCubit();
  static final authenticateBloc =
      AuthenticateBloc(AuthRepositoryImpl(), MediaRepositoryImpl());
  static final verificationBloc = VerificationBloc(AuthRepositoryImpl());
  static final applicationBloc = ApplicationBloc();
  static final dashboardBloc = DashboardBloc();
  static final chatBloc = ChatBloc(ChatRepositoryImpl());
  static final conversationBloc = ConversationBloc(ChatRepositoryImpl());
  static final filterBloc =
      FilterBloc(LanguageRepositoryImpl(), FilterRepositoryImpl());
  static final groupBloc = GroupBloc(GroupRepositoryImpl());
  static final blogBloc = BlogBloc(BlogRepositoryImpl());
  static final updateProfileInfoBloc = UpdateProfileInfoBloc();

  static final List<BlocProvider> providers = [
    BlocProvider<ApplicationBloc>(
      create: (context) => applicationBloc,
    ),
    BlocProvider<LocaleCubit>(
      create: (context) => localeCubit,
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
    BlocProvider<FilterBloc>(
      create: (context) => filterBloc,
    ),
    BlocProvider<ConversationBloc>(
      create: (context) => conversationBloc,
    ),
    BlocProvider<GroupBloc>(
      create: (context) => groupBloc,
    ),
    BlocProvider<BlogBloc>(
      create: (context) => blogBloc,
    ),
    BlocProvider<UpdateProfileInfoBloc>(
      create: (context) => updateProfileInfoBloc,
    ),
  ];

  static void initialHomeBloc() {
    authenticateBloc.add(RefreshTokenEvent());
    chatBloc.add(FetchConversations());
  }

  static void cleanBloc() {
    dashboardBloc.add(const OnChangeIndexEvent(index: 0));
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
