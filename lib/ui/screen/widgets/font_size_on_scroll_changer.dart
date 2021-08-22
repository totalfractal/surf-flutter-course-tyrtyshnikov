import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FontSizeOnScrollChanger extends StatelessWidget {
  final Widget child;
  final VoidCallback onScrollDown;
  final VoidCallback onScrollUp;
  final ScrollController scrollController;
  const FontSizeOnScrollChanger({
    required this.child,
    required this.onScrollDown,
    required this.onScrollUp,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

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
