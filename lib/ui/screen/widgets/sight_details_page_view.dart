import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/globals.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/widgets/overscroll_glow_absorber.dart';

class SightDetailsPageView extends StatefulWidget {
  SightDetailsPageView({
    Key? key,
    required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  _SightDetailsPageViewState createState() => _SightDetailsPageViewState();
}

class _SightDetailsPageViewState extends State<SightDetailsPageView> {
  PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / widget.sight.urls.length;
    return OverscrollGlowAbsorber(
      child: Stack(
        children: [
          pageViewBuilder(),
          Positioned(
              bottom: 0,
              left: width * _currentPage,
              child: pageViewIndicator(width: width))
        ],
      ),
    );
  }

  Widget pageViewIndicator({required double width}) {
    return SizedBox(
      width: width,
      height: 7.57,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isDarkMode ? dmWhiteColor : lmMainColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  PageView pageViewBuilder() {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.sight.urls.length,
      onPageChanged: (nextIndex) {
        setState(() {
          _currentPage = nextIndex;
        });
      },
      itemBuilder: (context, index) {
        return Image.network(
          widget.sight.urls[index % widget.sight.urls.length],
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            );
          },
          fit: BoxFit.cover,
        );
      },
    );
  }
}
