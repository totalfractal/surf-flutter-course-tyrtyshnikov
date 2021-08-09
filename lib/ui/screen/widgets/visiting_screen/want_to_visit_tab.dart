import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

import '../../../../globals.dart';
import 'want_to_visit_sight_card.dart';

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
          key: ValueKey(widget.wantToVisitList[index].name),
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