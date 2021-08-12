import 'package:flutter/material.dart';

class OverscrollGlowAbsorber extends StatelessWidget {
  const OverscrollGlowAbsorber({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: child,
      onNotification: (notififcation) {
        if (notififcation is OverscrollIndicatorNotification) {
          notififcation.disallowGlow();
        }
        return false;
      },
    );
  }
}
