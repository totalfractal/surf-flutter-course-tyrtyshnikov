import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FontSizeOnScrollChanger extends StatelessWidget {
  const FontSizeOnScrollChanger(
      {Key? key,
      required this.child,
      required this.onScrollDown,
      required this.onScrollUp,
      required this.scrollController})
      : super(key: key);

  final Widget child;
  final VoidCallback onScrollDown;
  final VoidCallback onScrollUp;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      child: child,
      onNotification: (notififcation) {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          onScrollDown();
        } else {
          if (scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
            onScrollUp();
          }
        }
        return false;
      },
    );
  }
}
