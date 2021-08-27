import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/globals.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/widgets/overscroll_glow_absorber.dart';

class SightDetailsPageView extends StatefulWidget {
  final Sight sight;
  const SightDetailsPageView({
    required this.sight,
    Key? key,
  }) : super(key: key);

  @override
  _SightDetailsPageViewState createState() => _SightDetailsPageViewState();
}

class _SightDetailsPageViewState extends State<SightDetailsPageView> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / widget.sight.urls.length;
    return OverscrollGlowAbsorber(
      child: Stack(
        children: [
          PageView.builder(
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
                loadingBuilder: (
                  context,
                  child,
                  loadingProgress,
                ) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  );
                },
                fit: BoxFit.cover,
              );
            },
          ),
          Positioned(
            bottom: 0,
            left: width * _currentPage,
            child: SizedBox(
              width: width,
              height: 7.57,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: isDarkMode ? dmWhiteColor : lmMainColor,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
