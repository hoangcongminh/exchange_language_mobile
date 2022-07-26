import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
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
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: SafeArea(
        bottom: false,
        child: SettingsList(
          sections: [
            SettingsSection(
              title: const Text('Common'),
              tiles: [
                SettingsTile.navigation(
                  leading: const Icon(Icons.language),
                  title: const Text('Language'),
                  value: Text(AppBloc.localeCubit.getLocaleName()),
                  onPressed: (context) {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        cancelButton: CupertinoActionSheetAction(
                          isDestructiveAction: true,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () {
                              AppBloc.localeCubit.toEnglish();
                              Navigator.pop(context);
                              setState(() {});
                            },
                            child: const Text('English'),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              AppBloc.localeCubit.toVietnamese();
                              Navigator.pop(context);
                              setState(() {});
                            },
                            child: const Text('Vietnamese'),
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
              // title: const Text('common'),
            ),
            SettingsSection(
              title: const Text('Account'),
              tiles: [
                SettingsTile(
                  title: Text(l10n.updateInfo),
                  leading: const Icon(Icons.person),
                  onPressed: (context) {
                    AppBloc.updateProfileInfoBloc.add(FetchProfileInfoEvent());
                    AppNavigator().push(RouteConstants.updateProfileInfo);
                  },
                ),
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
