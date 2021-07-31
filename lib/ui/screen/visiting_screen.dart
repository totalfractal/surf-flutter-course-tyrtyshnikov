import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/sight_details.dart';
import '../../globals.dart';
import '../../mocks.dart';

//TODO: Сделать наследование для карточек

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
          type: mocks[1][5])
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

class WantToVisitTab extends StatefulWidget {
  const WantToVisitTab({key, required this.wantToVisitList}) : super(key: key);

  final List<Sight> wantToVisitList;

  @override
  _WantToVisitTabState createState() => _WantToVisitTabState();
}

class _WantToVisitTabState extends State<WantToVisitTab> {
  late Column _wantToVisitWidgets;

  @override
  void initState() {
    // _wantToVisitCardsList = _getWantToVisitListWidgets();
    super.initState();
    _wantToVisitWidgets = _getWantToVisitWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return widget.wantToVisitList.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
          )
        : SingleChildScrollView(child: _wantToVisitWidgets);
  }

  Column _getWantToVisitWidgets() {
    List<Widget> list = [];
    for (int index = 0; index < widget.wantToVisitList.length; index++) {
      list.add(Padding(
        padding: const EdgeInsets.all(16),
        child: WantToVisitSightCard(
          // key: ValueKey(widget.wantToVisitList[index].toString()),
          sight: widget.wantToVisitList[index],
          onDeleteTap: () => _deleteSight(index),
          onCalendarTap: () => print("add to calendar"),
        ),
      ));
    }
    return Column(
      children: list,
    );
  }

  void _deleteSight(int index) {
    setState(() {
      widget.wantToVisitList.removeAt(index);
      _wantToVisitWidgets = _getWantToVisitWidgets();
    });
  }
}

class WantToVisitSightCard extends SightCard {
  const WantToVisitSightCard(
      {Key? key,
      required Sight sight,
      required this.onDeleteTap,
      required this.onCalendarTap})
      : super(sight: sight, key: key);

  final VoidCallback onDeleteTap;
  final VoidCallback onCalendarTap;

  @override
  Column informationColumn(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Text(sight.name.isEmpty ? "Название" : sight.name,
            style: Theme.of(context).primaryTextTheme.headline4),
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
            style: Theme.of(context).primaryTextTheme.subtitle2),
      ),
    ]);
  }

  @override
  Widget interactionButtons() {
    return Row(children: [
      Container(
        width: 45,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Image.asset(
              "res/icons/other/Calendar.png",
            ),
            onTap: () => onCalendarTap(),
          ),
        ),
      ),
      Container(
        width: 45,
        child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.asset(
                "res/icons/other/Delete.png",
              ),
              onTap: () => onDeleteTap(),
            )),
      )
    ]);
  }
}

class VisitedTab extends StatefulWidget {
  const VisitedTab({
    key,
    required this.visitedList,
  }) : super(key: key);

  final List<Sight> visitedList;

  @override
  _VisitedTabState createState() => _VisitedTabState();
}

class _VisitedTabState extends State<VisitedTab> {
  late Column _visitedWidgets;

  @override
  void initState() {
    super.initState();
    _visitedWidgets = _getVisitedListWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return widget.visitedList.isEmpty
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
        : _visitedWidgets;
  }

  Column _getVisitedListWidgets() {
    List<Widget> list = [];
    for (int index = 0; index < widget.visitedList.length; index++) {
      list.add(Padding(
        padding: const EdgeInsets.all(16),
        child: VisitedSightCard(
          sight: widget.visitedList[index],
          onShareTap: () => print("share"),
          onDeleteTap: () => _deleteSight(index),
        ),
      ));
    }
    return Column(children: list);
  }

  void _deleteSight(int index) {
    setState(() {
      widget.visitedList.removeAt(index);
      _visitedWidgets = _getVisitedListWidgets();
    });
  }
}

class VisitedSightCard extends SightCard {
  const VisitedSightCard(
      {key,
      required Sight sight,
      required this.onShareTap,
      required this.onDeleteTap})
      : super(key: key, sight: sight);

  final VoidCallback onShareTap;
  final VoidCallback onDeleteTap;

  @override
  Column informationColumn(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Text(
          sight.name.isEmpty ? "Название" : sight.name,
          style: Theme.of(context).primaryTextTheme.headline4,
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 2),
        child: Text("Цель достигнута 12 окт. 2020",
            textAlign: TextAlign.start,
            style: Theme.of(context).primaryTextTheme.subtitle2),
      ),
      Container(
        padding: EdgeInsets.only(top: 16),
        child: Text("закрыто до 9:00",
            textAlign: TextAlign.start,
            style: Theme.of(context).primaryTextTheme.subtitle2),
      ),
    ]);
  }

  @override
  Widget interactionButtons() {
    return Row(children: [
      Container(
        width: 45,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Image.asset(
              "res/icons/other/Share.png",
            ),
            onTap: () => onShareTap(),
          ),
        ),
      ),
      Container(
        width: 45,
        child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.asset(
                "res/icons/other/Delete.png",
              ),
              onTap: () => onDeleteTap(),
            )),
      )
    ]);
  }

  /* @override
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
                        sight.url,
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
                            sight.name.isEmpty ? "Название" : sight.name,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SightDetails(
                                  sight: sight,
                                )));
                  },
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                )))
      ],
    );
  } */
}
