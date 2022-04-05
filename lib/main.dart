import 'package:exchange_language_mobile/common/helpers/utils/logger_utils.dart';
import 'package:exchange_language_mobile/presentation/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(() {
    runApp(
      const Application(),
    );
  }, blocObserver: AppBlocObserver());

  // runApp(
  //   /* DevicePreview( */
  //   /*   builder: (context) => const Application(), */
  //   /* ), */
  //   const Application(),
  // );
}

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    LoggerUtils.log(mode: 'd', message: 'onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    LoggerUtils.log(
        mode: 'd', message: 'onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    LoggerUtils.log(
        mode: 'd', message: 'onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    LoggerUtils.log(
        mode: 'd', message: 'onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    LoggerUtils.log(
        mode: 'd', message: 'onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    LoggerUtils.log(mode: 'd', message: 'onClose -- ${bloc.runtimeType}');
  }
}
