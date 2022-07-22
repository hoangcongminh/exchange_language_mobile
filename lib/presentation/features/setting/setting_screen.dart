import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../common/constants/constants.dart';
import '../../../routes/app_pages.dart';
import '../../common/app_bloc.dart';
import '../authenticate/bloc/authenticate_bloc.dart';
import '../update-profile-info/bloc/update_profile_info_bloc.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String currentLanguage = AppBloc.localeCubit.state.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        bottom: false,
        child: SettingsList(
          sections: [
            SettingsSection(
              tiles: [
                SettingsTile(
                  title: const Text('Language'),
                  leading: const Icon(Icons.language),
                  value: Text(currentLanguage),
                  onPressed: (context) {
                    AppBloc.localeCubit.switchLanguage();
                    AppNavigator().pop();
                  },
                ),
                SettingsTile(
                  title: const Text('Update info'),
                  leading: const Icon(Icons.person),
                  onPressed: (context) {
                    AppBloc.updateProfileInfoBloc.add(FetchProfileInfoEvent());
                    AppNavigator().push(RouteConstants.updateProfileInfo);
                  },
                ),
              ],
              // title: const Text('common'),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
