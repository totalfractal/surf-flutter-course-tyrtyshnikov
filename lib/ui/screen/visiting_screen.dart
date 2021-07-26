import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/colors.dart';
import '../../globals.dart';
import '../../mocks.dart';

//TODO: Сделать наследование для карточек

class VisitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          WantToVisitTab(visitList: [
            Sight(
                name: mocks[0][0],
                lat: double.parse(mocks[0][1]),
                lon: double.parse(mocks[0][2]),
                url: mocks[0][3],
                details: mocks[0][4],
                type: mocks[0][5])
          ]),
          VisitedTab(visitedList: [
            Sight(
                name: mocks[1][0],
                lat: double.parse(mocks[1][1]),
                lon: double.parse(mocks[1][2]),
                url: mocks[1][3],
                details: mocks[1][4],
                type: mocks[1][5])
          ])
        ]),
      ),
    );
  }
}

class WantToVisitTab extends StatelessWidget {
  const WantToVisitTab({
    key,
    required this.visitList,
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
                    "res/icons/other/Card.png",
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
                          style: Theme.of(context).primaryTextTheme.headline2,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "Отмечайте понравившиеся места и они появятся здесь.",
                          style: Theme.of(context).primaryTextTheme.headline3,
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

  List<Widget> _getWantToVisitListWidgets() {
    List<Widget> list = [];
    visitList.forEach((element) {
      list.add(Padding(
        padding: const EdgeInsets.all(16),
        child: WantToVisitSightCard(
          sight: element,
        ),
      ));
    });
    return list;
  }
}

class VisitedTab extends StatelessWidget {
  const VisitedTab({
    key,
    required this.visitedList,
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
                    "res/icons/other/GO.png",
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
                          style: Theme.of(context).primaryTextTheme.headline2,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 53),
                        child: Text(
                          "Завершите маршрут, чтобы место попало сюда.",
                          style: Theme.of(context).primaryTextTheme.headline3,
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

  List<Widget> _getVisitedListWidgets() {
    List<Widget> list = [];
    visitedList.forEach((element) {
      list.add(Padding(
        padding: const EdgeInsets.all(16),
        child: VisitedSightCard(
          sight: element,
        ),
      ));
    });
    return list;
  }
}

class WantToVisitSightCard extends StatelessWidget {
  const WantToVisitSightCard({
    key,
    required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Column(
            children: [
              Container(
                height: 96,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
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
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      child: Image.network(
                        sight.url!,
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
                            ),
                          );
                        },
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16, left: 16),
                      alignment: Alignment.topCenter,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                sight.type!.isEmpty
                                    ? "категория"
                                    : sight.type!.toLowerCase(),
                                style:
                                    Theme.of(context).primaryTextTheme.caption,
                              ),
                            ),
                          ),
                          ButtonBar(buttonPadding: EdgeInsets.zero, children: [
                            Container(
                                alignment: Alignment.topCenter,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.topCenter,
                                  icon: Image.asset(
                                    "res/icons/other/Calendar.png",
                                  ),
                                  onPressed: () {
                                    print("Добавить в календарь");
                                  },
                                )),
                            Container(
                                alignment: Alignment.topCenter,
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.topCenter,
                                    icon: Image.asset(
                                      "res/icons/other/Delete.png",
                                    ),
                                    onPressed: () {
                                      print("Удалить");
                                    }))
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(12),
                      bottomStart: Radius.circular(12),
                    ),
                    color: isDarkMode
                        ? dmSightCardContainerColor
                        : lmSightCardContainerColor),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                              sight.name!.isEmpty ? "Название" : sight.name!,
                              style:
                                  Theme.of(context).primaryTextTheme.headline4),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 2),
                          child: Text("Запланировано на 12 окт. 2020",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .subtitle2!
                                  .copyWith(color: hexToColor("#4CAF50"))),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16),
                          child: Text("закрыто до 9:00",
                              textAlign: TextAlign.start,
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle2),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
        new Positioned.fill(
            child: new Material(
                color: Colors.transparent,
                child: new InkWell(
                  onTap: () {
                    print("InkWell");
                  },
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                )))
      ],
    );
  }
}

class VisitedSightCard extends StatelessWidget {
  const VisitedSightCard({
    key,
    required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Column(
            children: [
              Container(
                height: 96,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
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
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      child: Image.network(
                        sight.url!,
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
                            ),
                          );
                        },
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 16,
                        left: 16,
                      ),
                      alignment: Alignment.topCenter,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                  sight.type!.isEmpty
                                      ? "категория"
                                      : sight.type!.toLowerCase(),
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
                                    "res/icons/other/Share.png",
                                  ),
                                  onPressed: () {
                                    print("Поделиться");
                                  },
                                )),
                            Container(
                                alignment: Alignment.topCenter,
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.topCenter,
                                    icon: Image.asset(
                                      "res/icons/other/Delete.png",
                                    ),
                                    onPressed: () {
                                      print("Удалить");
                                    }))
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(12),
                      bottomStart: Radius.circular(12),
                    ),
                    color: isDarkMode
                        ? dmSightCardContainerColor
                        : lmSightCardContainerColor),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            sight.name!.isEmpty ? "Название" : sight.name!,
                            style: Theme.of(context).primaryTextTheme.headline4,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 2),
                          child: Text("Цель достигнута 12 окт. 2020",
                              textAlign: TextAlign.start,
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle2),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16),
                          child: Text("закрыто до 9:00",
                              textAlign: TextAlign.start,
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle2),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
        new Positioned.fill(
            child: new Material(
                color: Colors.transparent,
                child: new InkWell(
                  onTap: () {
                    print("InkWell");
                  },
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                )))
      ],
    );
  }
}
