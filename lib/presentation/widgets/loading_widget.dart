import 'package:exchange_language_mobile/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: Center(
        key: const ValueKey('home_LoadingWidget'),
        // child: CupertinoActivityIndicator(),
        child: SpinKitThreeInOut(
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: index.isEven
                    ? AppColors.primaryColor
                    : AppColors.primaryColor.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            );
          },
        ),
      ),
    );
  }
}
