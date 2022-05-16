import 'package:equatable/equatable.dart';
import 'package:exchange_language_mobile/common/constants/route_constants.dart';
import 'package:exchange_language_mobile/routes/app_pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/configs/application.dart';
import '../../../data/datasources/local/user_local_data.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(InitialApplicationState()) {
    on<OnSetupApplication>((event, emit) async {
      emit(ApplicationStart());
      await Application().initialApplication();
      // Check Login
      bool isLogin = _onAuthCheck();
      if (isLogin) {
        emit(ApplicationAuthorized());
      } else {
        emit(ApplicationUnauthorized());
      }
    });

    on<OnLoggedIn>((event, emit) async {
      emit(ApplicationAuthorized());

      AppNavigator().pushNamedAndRemoveUntil(RouteConstants.home);
    });

    on<OnLoggedOut>((event, emit) async {
      emit(ApplicationUnauthorized());
      AppNavigator().pushNamedAndRemoveUntil(RouteConstants.login);
    });
  }

  bool _onAuthCheck() {
    return UserLocal().getAccessToken() != '';
  }
}
