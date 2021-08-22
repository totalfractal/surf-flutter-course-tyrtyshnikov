import 'package:flutter/material.dart';

class OverscrollGlowAbsorber extends StatelessWidget {
  final Widget child;
  const OverscrollGlowAbsorber({
    required this.child,
    Key? key,
  }) : super(key: key);

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
