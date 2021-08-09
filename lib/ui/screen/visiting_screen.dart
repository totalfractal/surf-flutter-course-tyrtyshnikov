import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/widgets/visiting_screen/visited_sight_card.dart';
import '../../globals.dart';
import '../../mocks.dart';
import 'widgets/visiting_screen/visited_tab.dart';
import 'widgets/visiting_screen/want_to_visit_sight_card.dart';
import 'widgets/visiting_screen/want_to_visit_tab.dart';

class VisitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var wantToVisitList = [
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
          type: mocks[4][5])
    ];
    var visitedList = [
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
          type: mocks[5][5])
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorPadding:
                EdgeInsets.only(left: 16, right: 1, top: 6, bottom: 6),
            tabs: [
              Container(
                  padding: EdgeInsets.only(left: 16),
                  width: double.infinity,
                  child: Tab(
                    text: "Хочу посетить",
                  )),
              Container(
                  padding: EdgeInsets.only(left: 16),
                  width: double.infinity,
                  child: Tab(
                    text: "Посетил",
                  ))
            ],
          ),
          title: Container(
            child: Text(
              "Избранное",
            ),
            alignment: Alignment.center,
          ),
          elevation: 0,
        ),
        bottomNavigationBar: BottomNavBar(),
        body: TabBarView(children: [
          WantToVisitTab(wantToVisitList: wantToVisitList),
          VisitedTab(visitedList: visitedList)
        ]),
      ),
    );
  }
}



