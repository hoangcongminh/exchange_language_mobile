import 'package:equatable/equatable.dart';
import 'package:exchange_language_mobile/data/datasources/local/user_local_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authenticate_event.dart';
part 'authenticate_state.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  AuthenticateBloc() : super(AuthenticateInitial()) {
    on<AuthenticationCheck>((event, emit) {
      bool isLogin = _onAuthCheck();
      if (isLogin) {
        emit(AuthenticationSuccess());
      } else {
        emit(AuthenticationFail());
      }
    });

    on<LoginEvent>((event, emit) {
      try {
        bool isSuccess = _handleLogin(event);
        if (isSuccess) {
          emit(AuthenticationSuccess());
        }
      } catch (e) {
        emit(AuthenticationFail());
      }
    });
  }

  bool _onAuthCheck() {
    return UserLocal().getAccessToken() != '';
  }

  bool _handleLogin(LoginEvent event) {
    return true;
  }
}
