import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_list_screen.dart';

import '../../mocks.dart';

class VisitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            
            indicatorPadding: EdgeInsets.only(left: 16, right: 1, top: 6, bottom: 6),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(40), right: Radius.circular(40)),
              color: hexToColor("#3B3E5B"),
            ),
            labelStyle: TextStyle(
              fontFamily: 'Roboto',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Roboto',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            unselectedLabelColor: hexToColor("#7C7E92"),
            tabs: [
              Container(
                padding: EdgeInsets.only(left: 16),
                  width: double.infinity,
                  // color: hexToColor("#3B3E5B"),
                  child: Tab(
                    text: "Хочу посетить",
                  )),
              Container(
                padding: EdgeInsets.only(left: 16),
                  width: double.infinity,
                  // color: hexToColor("#3B3E5B"),
                  child: Tab(
                    text: "Посетил",
                  ))
            ],
          ),
          title: Container(
            child: Text(
              "Избранное",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: hexToColor("#252849"),
              ),
            ),
            alignment: Alignment.center,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: TabBarView(children: [
          WantToVisitTab(visitList: [
            /* Sight(
                name: mocks[0][0],
                lat: mocks[0][1],
                lon: mocks[0][2],
                url: mocks[0][3],
                details: mocks[0][4],
                type: mocks[0][5]) */
          ]),
          VisitedTab(visitedList: [
            /* Sight(
                name: mocks[1][0],
                lat: mocks[1][1],
                lon: mocks[1][2],
                url: mocks[1][3],
                details: mocks[1][4],
                type: mocks[1][5]) */
          ])
        ]),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Image.asset("res/icons/List.png"), label: ""),
          BottomNavigationBarItem(icon: Image.asset("res/icons/Map.png"), label: ""),
          BottomNavigationBarItem(icon: Image.asset("res/icons/Heart Full.png", color: hexToColor("#252849"),), label: "", ),
          BottomNavigationBarItem(icon: Image.asset("res/icons/Settings.png"), label: ""),
        ],
        ),
      ),
    );
  }
}

class WantToVisitTab extends StatelessWidget {
  const WantToVisitTab({
    key,
    @required this.visitList,
  }) : super(key: key);

  final List<Sight> visitList;

  @override
  Widget build(BuildContext context) {
    return visitList.isEmpty
        ? Center(
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  child: Image.asset(
                    "res/icons/Card.png",
                    height: 64,
                    width: 64,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                    color: hexToColor("#7C7E92"),
                    scale: 2,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 53),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 24, bottom: 8),
                        child: Text(
                          "Пусто",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: hexToColor("#7C7E92"),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "Отмечайте понравившиеся места и они появятся здесь.",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: hexToColor("#7C7E92"),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          )
        : Column(
            children: _getWantToVisitListWidgets(),
          );
  }

  List<WantToVisitSightCard> _getWantToVisitListWidgets() {
    List<WantToVisitSightCard> list = [];
    visitList.forEach((element) {
      list.add(WantToVisitSightCard(
        sight: element,
      ));
    });
    return list;
  }
}

class VisitedTab extends StatelessWidget {
  const VisitedTab({
    key,
    @required this.visitedList,
  }) : super(key: key);

  final List<Sight> visitedList;

  @override
  Widget build(BuildContext context) {
    return visitedList.isEmpty
        ? Center(
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  child: Image.asset(
                    "res/icons/GO.png",
                    height: 64,
                    width: 64,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                    color: hexToColor("#7C7E92"),
                    scale: 2,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 53),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 24, bottom: 8),
                        child: Text(
                          "Пусто",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: hexToColor("#7C7E92"),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 53),
                        child: Text(
                          "Завершите маршрут, чтобы место попало сюда.",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: hexToColor("#7C7E92"),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          )
        : Column(
            children: _getVisitedListWidgets(),
          );
  }

  List<VisitedSightCard> _getVisitedListWidgets() {
    List<VisitedSightCard> list = [];
    visitedList.forEach((element) {
      list.add(VisitedSightCard(
        sight: element,
      ));
    });
    return list;
  }
}

class WantToVisitSightCard extends StatelessWidget {
  const WantToVisitSightCard({
    key,
    @required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          children: [
            Container(
              height: 96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                gradient: new LinearGradient(
                    colors: [
                      Colors.black38,
                      Colors.black12,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    child: Image.network(
                      sight.url,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    alignment: Alignment.topCenter,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                                sight.type.isEmpty
                                    ? "категория"
                                    : sight.type.toLowerCase(),
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        ButtonBar(buttonPadding: EdgeInsets.zero, children: [
                          Container(
                              alignment: Alignment.topCenter,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.topCenter,
                                icon: Image.asset(
                                  "res/icons/Calendar.png",
                                  height: 24,
                                  width: 24,
                                ),
                                onPressed: () {},
                              )),
                          Container(
                              alignment: Alignment.topCenter,
                              child: IconButton(
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.topCenter,
                                  icon: Image.asset(
                                    "res/icons/Delete.png",
                                    height: 24,
                                    width: 24,
                                  ),
                                  onPressed: () {}))
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child:
                            Text(sight.name.isEmpty ? "Название" : sight.name,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: hexToColor("#3B3E5B"),
                                )),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 2),
                        child: Text("Запланировано на 12 окт. 2020",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: hexToColor("#4CAF50"),
                                decoration: TextDecoration.none)),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16),
                        child: Text("закрыто до 9:00",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: hexToColor("#7C7E92"),
                                decoration: TextDecoration.none)),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VisitedSightCard extends StatelessWidget {
  const VisitedSightCard({
    key,
    @required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          children: [
            Container(
              height: 96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                gradient: new LinearGradient(
                    colors: [
                      Colors.black38,
                      Colors.black12,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    child: Image.network(
                      sight.url,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    alignment: Alignment.topCenter,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                                sight.type.isEmpty
                                    ? "категория"
                                    : sight.type.toLowerCase(),
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        ButtonBar(buttonPadding: EdgeInsets.zero, children: [
                          Container(
                              alignment: Alignment.topCenter,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.topCenter,
                                icon: Image.asset(
                                  "res/icons/Share.png",
                                  height: 24,
                                  width: 24,
                                ),
                                onPressed: () {},
                              )),
                          Container(
                              alignment: Alignment.topCenter,
                              child: IconButton(
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.topCenter,
                                  icon: Image.asset(
                                    "res/icons/Delete.png",
                                    height: 24,
                                    width: 24,
                                  ),
                                  onPressed: () {}))
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child:
                            Text(sight.name.isEmpty ? "Название" : sight.name,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: hexToColor("#3B3E5B"),
                                )),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 2),
                        child: Text("Цель достигнута 12 окт. 2020",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: hexToColor("#7C7E92"),
                                decoration: TextDecoration.none)),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16),
                        child: Text("закрыто до 9:00",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: hexToColor("#7C7E92"),
                                decoration: TextDecoration.none)),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
