import 'package:intl/intl.dart';

import '../../../presentation/common/app_bloc.dart';

extension StringUtils on String {
  bool get isEmail => hasMatch(this,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  String get formatTime =>
      DateFormat.yMMMMd(AppBloc.localeCubit.state.toString())
          .format(DateTime.parse(this));
}

bool hasMatch(String? value, String pattern) {
  return (value == null) ? false : RegExp(pattern).hasMatch(value);
}
