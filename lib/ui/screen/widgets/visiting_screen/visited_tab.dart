import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

import '../../../../globals.dart' as globals;
import 'visited_sight_card.dart';
import 'visiting_drag_target.dart';

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
            child: Column(
              children: [
                Container(
                  child: Image.asset(
                    "res/icons/other/GO.png",
                    height: 64,
                    width: 64,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                    color: globals.hexToColor("#7C7E92"),
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
            ),
          )
        : SingleChildScrollView(child: _visitedWidgets);
  }

  Column _getVisitedListWidgets() {
    _saveGlobalList();
    List<Widget> list = [];
    list.add(VisitingDragTarget(
        index: 0,
        onAccept: (dragIndex, targetIndex) =>
            _moveSight(dragIndex, targetIndex)));
    for (int index = 0; index < globals.visitedList.length; index++) {
      list.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: VisitedSightCard(
          key: ValueKey(globals.visitedList[index].name),
          index: index,
          sight: globals.visitedList[index],
          onShareTap: () => print("share"),
          onDeleteTap: () => _deleteSight(index),
        ),
      ));
      list.add(VisitingDragTarget(
          index: index + 1,
          onAccept: (dragIndex, targetIndex) =>
              _moveSight(dragIndex, targetIndex)));
    }

    return Column(children: list);
  }

  void _moveSight(int dragIndex, int targetIndex) {
    if (targetIndex != dragIndex + 1 && targetIndex != dragIndex) {
      setState(() {
        var movedSight = globals.visitedList.removeAt(dragIndex);
        if (targetIndex == globals.visitedList.length + 1) {
          globals.visitedList.insert(targetIndex - 1, movedSight);
        } else {
          globals.visitedList.insert(targetIndex, movedSight);
        }

        _visitedWidgets = _getVisitedListWidgets();
      });
    }
  }

  void _deleteSight(int index) {
    setState(() {
      globals.visitedList.removeAt(index);
      _visitedWidgets = _getVisitedListWidgets();
    });
  }

  void _saveGlobalList() {
    globals.visitedList = widget.visitedList;
  }
}
