import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authenticate_event.dart';
part 'authenticate_state.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  AuthenticateBloc() : super(AuthenticateInitial()) {
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

  bool _handleLogin(LoginEvent event) {
    return true;
  }
}
