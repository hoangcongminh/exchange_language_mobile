import 'package:exchange_language_mobile/presentation/common/app_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/authenticate/widgets/auth_button_widget.dart';
import 'package:exchange_language_mobile/presentation/features/verification/bloc/verification_bloc.dart';
import 'package:exchange_language_mobile/presentation/features/verification/widgets/verification_code_widget.dart';
import 'package:exchange_language_mobile/presentation/widgets/error_dialog_widget.dart';
import 'package:exchange_language_mobile/presentation/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

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
                errorTitle: 'Verification error', errorMessage: state.error),
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
                            const Text(
                              'Enter the 6-digit code we have sent to',
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
                            const Text(
                              'Didn’t receive the code?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Text(
                              'Resend code',
                              textAlign: TextAlign.center,
                              style: TextStyle(
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
                        label: 'Continue',
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
