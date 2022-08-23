import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants/constants.dart';
import '../../../../domain/entities/language.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/app_bloc.dart';
import '../../../widgets/error_dialog_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../authenticate/widgets/auth_button_widget.dart';
import '../../filter/bloc/filter_bloc.dart';
import '../../filter/widgets/pick_select_widget.dart';
import '../bloc/update_profile_info_bloc.dart';

class RegisterTeacherScreen extends StatefulWidget {
  const RegisterTeacherScreen({Key? key}) : super(key: key);

  @override
  State<RegisterTeacherScreen> createState() => _RegisterTeacherScreenState();
}

class _RegisterTeacherScreenState extends State<RegisterTeacherScreen> {
  List<Language> teaching = [];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.registerTeacher),
      ),
      body: BlocConsumer<UpdateProfileInfoBloc, UpdateProfileInfoState>(
          listener: (context, state) {
        if (state is UpdateProfileInfoFailure) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              errorTitle: l10n.registerTeacherError,
              errorMessage: state.message,
            ),
          );
        } else if (state is UpdateProfileInfoSuccess) {
          AppNavigator().pop();
          AppBloc.initialHomeBloc();
        }
      }, builder: (context, state) {
        return Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(l10n.teaching)),
                    PickSelectWidget(
                      title: l10n.enterLanguage,
                      selectedLanguages: teaching,
                      onTap: () async {
                        AppBloc.filterBloc.add(SelectLanguageEvent());
                        final result = await AppNavigator().push(
                            RouteConstants.filterSelect,
                            arguments: {'selectedLanguage': teaching});
                        setState(() {
                          teaching = result;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: AuthButtonWidget(
                        label: l10n.registerTeacher,
                        onPressed: () => AppBloc.updateProfileInfoBloc
                            .add(RegisterTeacherEvent(teach: teaching)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (state is UpdateProfileInfoLoading)
              const Opacity(
                opacity: 0.8,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              ),
            if (state is UpdateProfileInfoLoading) const LoadingWidget()
          ],
        );
      }),
    );
  }
}
