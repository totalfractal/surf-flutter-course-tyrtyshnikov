import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/globals.dart' as globals;
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/res/styles.dart';

import 'visiting_drag_target.dart';
import 'want_to_visit_sight_card.dart';

class VisitingScreenTab extends StatefulWidget {
  const VisitingScreenTab(
      {Key? key, required this.sightList, required this.title})
      : super(key: key);

  final List<Sight> sightList;
  final String title;

  @override
  _VisitingScreenTabState createState() => _VisitingScreenTabState();
}

class _VisitingScreenTabState extends State<VisitingScreenTab> {
  Map<String, Widget> _allWidgetsMap = {};
  late List<Sight> _globalList;

  @override
  void initState() {
    super.initState();
    _getWantToVisitWidgets();
    _globalList =
        widget.title == "Хочу посетить" ? _globalList : globals.visitedList;
    _saveGlobalList();
  }

  @override
  Widget build(BuildContext context) {
    return widget.sightList.isEmpty
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
        : ListView(
            physics: Platform.isAndroid
                ? ClampingScrollPhysics()
                : BouncingScrollPhysics(),
            children: _allWidgetsMap.entries.map((e) => e.value).toList(),
          );
  }

  void _getWantToVisitWidgets() {
    _saveGlobalList();
    _allWidgetsMap = {
      "DragTarget 0": VisitingDragTarget(
          index: 0,
          onAccept: (dragIndex, targetIndex) =>
              _moveSight(dragIndex, targetIndex)),
    };
    for (int index = 0; index < _globalList.length; index++) {
      _allWidgetsMap[_globalList[index].name] = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _getDismissibleSightCard(index),
      );
      _allWidgetsMap["DragTarget ${index + 1}"] = VisitingDragTarget(
          index: index + 1,
          onAccept: (dragIndex, targetIndex) =>
              _moveSight(dragIndex, targetIndex));
    }
  }

  Dismissible _getDismissibleSightCard(int index) {
    return Dismissible(
      key: ValueKey(_globalList[index].name + " dismissWant"),
      child: WantToVisitSightCard(
        key: ValueKey(_globalList[index].name + " cardWant"),
        index: index,
        sight: _globalList[index],
        onDeleteTap: () => _deleteSight(index, _globalList[index].name),
        onCalendarTap: () => print("add to calendar"),
      ),
      background: Container(
        height: 198,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: globals.isDarkMode ? dmRedColor : lmRedColor,
        ),
        child: Container(
          margin: EdgeInsets.all(16),
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("res/icons/other/Bucket.png"),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Удалить",
                  style: lmRoboto12W400.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
      onDismissed: (direction) => _deleteSight(index, _globalList[index].name),
      direction: DismissDirection.endToStart,
    );
  }

  void _moveSight(int dragIndex, int targetIndex) {
    if (targetIndex != dragIndex + 1 && targetIndex != dragIndex) {
      setState(() {
        var movedSight = _globalList.removeAt(dragIndex);
        if (targetIndex == _globalList.length + 1) {
          _globalList.insert(targetIndex - 1, movedSight);
        } else {
          _globalList.insert(targetIndex, movedSight);
        }
        _getWantToVisitWidgets();
      });
    }
  }

  void _deleteSight(int index, String key) {
    setState(() {
      widget.sightList.removeAt(index);
      _allWidgetsMap.remove(key);
      _getWantToVisitWidgets();
    });
  }

  void _saveGlobalList() {
    _globalList = widget.sightList;
  }
}
