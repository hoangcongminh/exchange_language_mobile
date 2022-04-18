import 'package:flutter/material.dart';

class ScaffoldWrapper extends StatefulWidget {
  final Widget child;
  const ScaffoldWrapper({Key? key, required this.child}) : super(key: key);

  @override
  State<ScaffoldWrapper> createState() => _ScaffoldWrapperState();
}

class _ScaffoldWrapperState extends State<ScaffoldWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async => true,
      child: GestureDetector(
        onTap: () => _hideKeyboard(),
        child: Scaffold(
          body: widget.child,
        ),
      ),
    );
  }

  _hideKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }
}
