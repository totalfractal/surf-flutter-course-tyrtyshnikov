import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/globals.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/res/styles.dart';
import 'package:places/ui/screen/search_screen.dart';
import 'package:places/ui/screen/widgets/font_size_on_scroll_changer.dart';
import 'package:places/ui/screen/widgets/overscroll_glow_absorber.dart';
import 'package:places/ui/screen/widgets/sight_card.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';

class SightListScreen extends StatefulWidget {
  final String title;
  const SightListScreen({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<Sight> _sightsList = [];
  late Widget _currentAppBarText;
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
      floatingActionButton: SizedBox(
        width: 177,
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pushNamed('/add'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(252, 221, 61, 1),
                  Color.fromRGBO(76, 175, 80, 1),
                ],
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
                stops: [0.0, 1.0],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text('НОВОЕ МЕСТО'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //  bottomNavigationBar: const BottomNavBar(),
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
                ? const ClampingScrollPhysics()
                : const BouncingScrollPhysics(),
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
                        child: SearchBar(
                          onFiltersChanged: (value) => _sightsList,
                          onQueryChanged: (query) {},
                          onFocusChanged: (value) {},
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/search');
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
                          name: mocks[index][0] as String,
                          lat: double.parse(mocks[index][1] as String),
                          lon: double.parse(mocks[index][2] as String),
                          urls: mocks[index][3] as List<String>,
                          details: mocks[index][4] as String,
                          type: mocks[index][5] as String,
                        ),
                      ),
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
  final String title;
  const DefaultAppBarTitleText({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: sightListAppBarTextStyle.copyWith(
        color: isDarkMode ? dmWhiteColor : lmMainColor,
      ),
      textAlign: TextAlign.start,
      maxLines: 2,
      softWrap: true,
    );
  }
}

class ScrolledAppBarTitleText extends StatelessWidget {
  final String title;
  const ScrolledAppBarTitleText({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.replaceAll(RegExp(r'\n'), ''),
      style: sightListAppBarTextStyle.copyWith(
        color: isDarkMode ? dmWhiteColor : lmMainColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.start,
      maxLines: 2,
      softWrap: true,
    );
  }
}
