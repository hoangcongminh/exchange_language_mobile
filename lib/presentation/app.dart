import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';

import '../common/helpers/device_orientation_helper.dart';
import '../common/l10n/l10n.dart';
import '../routes/app_navigator_observer.dart';
import '../routes/app_pages.dart';
import '../routes/scaffold_wrapper.dart';
import 'common/app_bloc.dart';
import 'common/application/application_bloc.dart';
import 'common/locale/cubit/locale_cubit.dart';
import 'features/authenticate/pages/login_screen.dart';
import 'features/dashboard/pages/dashboard_screen.dart';
import 'features/splash/splash_screen.dart';
import 'theme/theme.dart';

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
      child: BlocBuilder<LocaleCubit, Locale?>(
        builder: (context, locale) {
          return BlocBuilder<ApplicationBloc, ApplicationState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              Widget screen = const ScaffoldWrapper(child: LoginScreen());
              if (state is ApplicationStart) {
                screen = const ScaffoldWrapper(child: SplashScreen());
              }
              if (state is ApplicationAuthorized) {
                screen = const ScaffoldWrapper(child: DashboardScreen());
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
                    theme: defaultTheme(),
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('en'),
                      Locale('vi'),
                    ],
                    locale: locale,
                    onGenerateRoute: (settings) =>
                        AppNavigator().getRoute(settings),
                    navigatorObservers: [
                      AppNavigatorObserver(),
                    ],
                    home: screen,
                    // home: const ScaffoldWrapper(child: DashboardScreen()),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
