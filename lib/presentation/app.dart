import 'package:exchange_language_mobile/common/helpers/device_orientation_helper.dart';
import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:exchange_language_mobile/presentation/common-bloc/app_bloc.dart';
import 'package:exchange_language_mobile/presentation/common-bloc/application/application_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/pages/login_screen.dart';
import 'package:exchange_language_mobile/presentation/features/dashboard/pages/dashboard_screen.dart';
import 'package:exchange_language_mobile/routes/scaffold_wrapper.dart';
import 'package:exchange_language_mobile/presentation/features/splash/splash_screen.dart';
import 'package:exchange_language_mobile/presentation/theme/theme.dart';
import 'package:exchange_language_mobile/routes/app_navigator_observer.dart';
import 'package:exchange_language_mobile/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    super.initState();
    DeviceOrientationHelper().setPortrait();
    AppBloc.applicationBloc.add(OnSetupApplication());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: BlocBuilder<ApplicationBloc, ApplicationState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          Widget _screen = const ScaffoldWrapper(child: LoginScreen());
          if (state is ApplicationStart) {
            _screen = const SplashScreen();
          }
          if (state is ApplicationAuthorized) {
            _screen = const DashboardScreen();
          }
          return Sizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp(
                navigatorKey: AppNavigator().navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'Exchange Language',
                //DevicePreview
                /* useInheritedMediaQuery: true, */
                /* locale: DevicePreview.locale(context), */
                /* builder: DevicePreview.appBuilder, */
                //DevicePreview
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', ''), // English, no country code
                  Locale('vi', ''), // Spanish, no country code
                ],
                theme: defaultTheme(),
                onGenerateRoute: (settings) =>
                    AppNavigator().getRoute(settings),
                navigatorObservers: [AppNavigatorObserver()],
                home: _screen,
              );
            },
          );
        },
      ),
    );
  }
}
