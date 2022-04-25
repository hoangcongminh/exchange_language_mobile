import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange_language_mobile/common/configs/application.dart';
import 'package:exchange_language_mobile/data/datasources/local/user_local_data.dart';

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
    });

    on<OnLoggedOut>((event, emit) async {
      emit(ApplicationUnauthorized());
    });
  }

  bool _onAuthCheck() {
    return UserLocal().getAccessToken() != '';
  }
}
