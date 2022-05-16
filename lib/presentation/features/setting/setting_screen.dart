import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../routes/app_pages.dart';
import '../../common/app_bloc.dart';
import '../authenticate/bloc/authenticate_bloc.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String text = AppBloc.localeCubit.language;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SettingsList(
          sections: [
            SettingsSection(
              tiles: [
                SettingsTile(
                  title: const Text('Language'),
                  leading: const Icon(Icons.language),
                  value: Text(text),
                  onPressed: (context) {
                    AppBloc.localeCubit.language == "Vietnamese"
                        ? AppBloc.localeCubit.toEnglish()
                        : AppBloc.localeCubit.toVietnamese();
                    AppNavigator().pop();
                  },
                ),
              ],
              title: const Text('common'),
            ),
            SettingsSection(
              tiles: [
                SettingsTile(
                  title: const Text('Logout'),
                  leading: const Icon(Icons.logout),
                  onPressed: (context) {
                    AppBloc.authenticateBloc.add(LogoutEvent());
                  },
                ),
                SettingsTile(
                  title: const Text('Back'),
                  leading: const Icon(Icons.arrow_back_ios),
                  onPressed: (context) {
                    AppNavigator().pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
