import 'package:exchange_language_mobile/common/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_bloc.dart';
import '../../../widgets/error_dialog_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../authenticate/widgets/auth_button_widget.dart';
import '../bloc/verification_bloc.dart';
import '../widgets/verification_code_widget.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  const VerificationScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String code = '';
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    Size size = MediaQuery.of(context).size;

    Future<void> _onSubmit() async {
      if (code.trim() != '') {
        AppBloc.verificationBloc.add(
          VerifyOTPEvent(
            email: widget.email,
            otp: code.trim(),
          ),
        );
      }
    }

    return BlocConsumer<VerificationBloc, VerificationState>(
      listener: (context, state) {
        if (state is VerificationFail) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
                errorTitle: l10n.verificationError, errorMessage: state.error),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CupertinoNavigationBarBackButton(
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 30.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              l10n.verificationTitle1,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              widget.email,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            SizedBox(height: 20.sp),
                            Container(
                              height: 70,
                              width: size.width,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              decoration: BoxDecoration(
                                // color: Colors.purple,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: VerificationCode(
                                isSecure: true,
                                length: 6,
                                autofocus: true,
                                onCompleted: (text) {
                                  setState(() {
                                    code = text;
                                  });
                                },
                                onEditing: (bool value) {},
                              ),
                            ),
                            SizedBox(height: 30.sp),
                            Text(
                              l10n.verificationTitle2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              l10n.resendCode,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.sp),
                      width: double.infinity,
                      child: AuthButtonWidget(
                        label: l10n.cont,
                        onPressed: () async => _onSubmit(),
                      ),
                    ),
                  ],
                ),
                if (state is VerificationLoading) const LoadingWidget()
              ],
            ),
          ),
        );
      },
    );
  }
}
