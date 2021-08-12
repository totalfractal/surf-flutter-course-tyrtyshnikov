import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/search_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width - 32, 40),
            child: InkWell(
              child: IgnorePointer(
                  ignoring: true,
                  child: SearchBar(
                    onFiltersChanged: (List<Sight> value) => _sightsList,
                    onQueryChanged: (String query) {},
                    onFocusChanged: (bool value) {},
                  )),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
            ),
          ),
          title: Container(
            child: AppBarTitleText(
              title: widget.title,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      body: Center(
        child: ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: Platform.isAndroid
                ? ClampingScrollPhysics()
                : BouncingScrollPhysics(),
            itemCount: mocks.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SightCard(
                    sight: Sight(
                        name: mocks[index][0],
                        lat: double.parse(mocks[index][1]),
                        lon: double.parse(mocks[index][2]),
                        url: mocks[index][3],
                        details: mocks[index][4],
                        type: mocks[index][5])),
              );
            }),
      ),
    );
  }
}

class AppBarTitleText extends StatelessWidget {
  const AppBarTitleText({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      // style: lmSightListAppBarTextStyle,
      textAlign: TextAlign.start,
      maxLines: 2,
      softWrap: true,
    );
  }
}
