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
          WantToVisitTab(visitList: []),
          SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              WantToVisitSightCard(
                sight: Sight(mocks[1][0], mocks[1][1], mocks[1][2], mocks[1][3],
                    mocks[1][4], mocks[1][5]),
              ),
            ]),
          ),
        ]),
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
                    fit: BoxFit.fill, filterQuality: FilterQuality.high,
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
            children: _getVisitListWidgets(),
          );
  }

  List<WantToVisitSightCard> _getVisitListWidgets() {
    List<WantToVisitSightCard> list = [];
    visitList.forEach((element) {
      list.add(WantToVisitSightCard(
        sight: Sight(element.name, element.lat, element.lon, element.url,
            element.details, element.type),
      ));
    });
    return list;
  }
}

class VisitedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
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
                        Container(
                          color: Colors.green,
                          width: 20,
                          height: 20,
                        ),
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
