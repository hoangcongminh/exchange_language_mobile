import 'package:device_preview/device_preview.dart';
import 'package:exchange_language_mobile/common/constants/route_constants.dart';
import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:exchange_language_mobile/helpers/device_orientation_helper.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/bloc/authenticate_bloc.dart';
import 'package:exchange_language_mobile/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';

import 'features/routes.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticateBloc>(create: (context) => AuthenticateBloc()),
      ],
      child: BlocBuilder<AuthenticateBloc, AuthenticateState>(
          builder: (context, snapshot) {
        Logger().i('--- Application build ---');
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Exchange Language',
          //DevicePreview
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
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
          initialRoute: RouteConstants.login,
          onGenerateRoute: Routes.generateRoute,
          theme: defaultTheme(),
        );
      }),
    );
  }
}
