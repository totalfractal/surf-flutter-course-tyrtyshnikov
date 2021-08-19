import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/res/styles.dart';
import 'package:places/ui/screen/search_screen.dart';
import 'package:places/ui/screen/widgets/font_size_on_scroll_changer.dart';
import 'package:places/ui/screen/widgets/overscroll_glow_absorber.dart';
import 'package:places/ui/screen/widgets/sight_card.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';

import '../../globals.dart';
import 'widgets/bottom_nav_bar.dart';

class SightListScreen extends StatefulWidget {
  SightListScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  List<Sight> _sightsList = [];
  late Widget _currentAppBarText;
  ScrollController _scrollController = ScrollController();
  bool _centerTitle = false;
  double _toolBarHeight = 140;

  @override
  void initState() {
    super.initState();
    _currentAppBarText = DefaultAppBarTitleText(title: widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: OverscrollGlowAbsorber(
        child: FontSizeOnScrollChanger(
          scrollController: _scrollController,
          onScrollDown: () {
            setState(() {
              _currentAppBarText = ScrolledAppBarTitleText(title: widget.title);
              _centerTitle = true;
              _toolBarHeight = 70;
            });
          },
          onScrollUp: () {
            setState(() {
              _currentAppBarText = DefaultAppBarTitleText(title: widget.title);
              _centerTitle = false;
              _toolBarHeight = 140;
            });
          },
          child: CustomScrollView(
            controller: _scrollController,
            physics: Platform.isAndroid
                ? ClampingScrollPhysics()
                : BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                pinned: true,
                title: _currentAppBarText,
                centerTitle: _centerTitle,
                expandedHeight: 160,
                toolbarHeight: _toolBarHeight,
                flexibleSpace: FlexibleSpaceBar(
                  background: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      child: IgnorePointer(
                        ignoring: true,
                        child: SearchBar(
                          onFiltersChanged: (List<Sight> value) => _sightsList,
                          onQueryChanged: (String query) {},
                          onFocusChanged: (bool value) {},
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchScreen()));
                      },
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SightCard(
                          sight: Sight(
                              name: mocks[index][0],
                              lat: double.parse(mocks[index][1]),
                              lon: double.parse(mocks[index][2]),
                              urls: mocks[index][3],
                              details: mocks[index][4],
                              type: mocks[index][5])),
                    );
                  },
                  childCount: mocks.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DefaultAppBarTitleText extends StatelessWidget {
  const DefaultAppBarTitleText({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: sightListAppBarTextStyle.copyWith(
          color: isDarkMode ? dmWhiteColor : lmMainColor),
      textAlign: TextAlign.start,
      maxLines: 2,
      softWrap: true,
    );
  }
}

class ScrolledAppBarTitleText extends StatelessWidget {
  const ScrolledAppBarTitleText({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.replaceAll(RegExp(r'\n'), ''),
      style: sightListAppBarTextStyle.copyWith(
          color: isDarkMode ? dmWhiteColor : lmMainColor,
          fontSize: 18,
          fontWeight: FontWeight.w500),
      textAlign: TextAlign.start,
      maxLines: 2,
      softWrap: true,
    );
  }
}
