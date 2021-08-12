import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/widgets/sight_card.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/widgets/visiting_screen/visited_sight_card.dart';
import 'package:places/ui/screen/widgets/visiting_screen/visiting_screen_tab.dart';
import '../../globals.dart';
import '../../mocks.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/visiting_screen/want_to_visit_sight_card.dart';

class VisitingScreen extends StatelessWidget {
  VisitingScreen({Key? key, required this.title}) : super(key: key);

  final title;
  final _titles = ["Хочу посетить", "Посетил"];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorPadding:
                EdgeInsets.only(left: 16, right: 1, top: 6, bottom: 6),
            tabs: _titles
                .map(
                  (String title) => Tab(
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
        bottomNavigationBar: BottomNavBar(),
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
      Sight(
          name: mocks[0][0],
          lat: double.parse(mocks[0][1]),
          lon: double.parse(mocks[0][2]),
          url: mocks[0][3],
          details: mocks[0][4],
          type: mocks[0][5]),
      Sight(
          name: mocks[1][0],
          lat: double.parse(mocks[1][1]),
          lon: double.parse(mocks[1][2]),
          url: mocks[1][3],
          details: mocks[1][4],
          type: mocks[1][5]),
      Sight(
          name: mocks[4][0],
          lat: double.parse(mocks[4][1]),
          lon: double.parse(mocks[4][2]),
          url: mocks[4][3],
          details: mocks[4][4],
          type: mocks[4][5]),
      Sight(
          name: mocks[6][0],
          lat: double.parse(mocks[7][1]),
          lon: double.parse(mocks[7][2]),
          url: mocks[6][3],
          details: mocks[6][4],
          type: mocks[6][5]),
      Sight(
          name: mocks[7][0],
          lat: double.parse(mocks[7][1]),
          lon: double.parse(mocks[7][2]),
          url: mocks[7][3],
          details: mocks[7][4],
          type: mocks[7][5])
    ];
  }

  List<Sight> _getVisitedList() {
    return visitedList = [
      Sight(
          name: mocks[2][0],
          lat: double.parse(mocks[2][1]),
          lon: double.parse(mocks[2][2]),
          url: mocks[2][3],
          details: mocks[2][4],
          type: mocks[2][5]),
      Sight(
          name: mocks[3][0],
          lat: double.parse(mocks[3][1]),
          lon: double.parse(mocks[3][2]),
          url: mocks[3][3],
          details: mocks[3][4],
          type: mocks[3][5]),
      Sight(
          name: mocks[5][0],
          lat: double.parse(mocks[5][1]),
          lon: double.parse(mocks[5][2]),
          url: mocks[5][3],
          details: mocks[5][4],
          type: mocks[5][5]),
      Sight(
          name: mocks[8][0],
          lat: double.parse(mocks[8][1]),
          lon: double.parse(mocks[8][2]),
          url: mocks[8][3],
          details: mocks[8][4],
          type: mocks[8][5]),
      Sight(
          name: mocks[9][0],
          lat: double.parse(mocks[9][1]),
          lon: double.parse(mocks[9][2]),
          url: mocks[9][3],
          details: mocks[9][4],
          type: mocks[9][5])
    ];
  }
}
