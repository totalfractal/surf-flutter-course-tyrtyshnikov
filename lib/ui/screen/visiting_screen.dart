import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/globals.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/widgets/bottom_nav_bar.dart';
import 'package:places/ui/screen/widgets/visiting_screen/visiting_screen_tab.dart';

class VisitingScreen extends StatelessWidget {
  static const _titles = ['Хочу посетить', 'Посетил'];
  final String title;
  const VisitingScreen({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicatorPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            tabs: _titles
                .map(
                  (title) => Tab(
                    text: title,
                  ),
                )
                .toList(),
          ),
          title: Text(
            title,
          ),
          elevation: 0,
        ),
        //   bottomNavigationBar: const BottomNavBar(),
        body: TabBarView(
          children: [
            VisitingScreenTab(sightList: _getwantToisitList(), title: title),
            VisitingScreenTab(sightList: _getVisitedList(), title: title),
          ],
        ),
      ),
    );
  }

  List<Sight> _getwantToisitList() {
    return wantToVisitList = [
      for (int i = 0; i <= 4; i++)
        Sight(
          name: mocks[i][0] as String,
          lat: double.parse(mocks[i][1] as String),
          lon: double.parse(mocks[i][2] as String),
          urls: mocks[i][3] as List<String>,
          details: mocks[i][4] as String,
          type: mocks[i][5] as String,
        ),
    ];
  }

  List<Sight> _getVisitedList() {
    return visitedList = [
      for (int i = 4; i <= 8; i++)
        Sight(
          name: mocks[i][0] as String,
          lat: double.parse(mocks[i][1] as String),
          lon: double.parse(mocks[i][2] as String),
          urls: mocks[i][3] as List<String>,
          details: mocks[i][4] as String,
          type: mocks[i][5] as String,
        ),
    ];
  }
}
