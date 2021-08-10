import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/res/styles.dart';
import 'package:places/ui/screen/widgets/visiting_screen/visiting_drag_target.dart';

import '../../../../globals.dart' as globals;
import 'want_to_visit_sight_card.dart';

class WantToVisitTab extends StatefulWidget {
  const WantToVisitTab({key, required this.wantToVisitList}) : super(key: key);

  final List<Sight> wantToVisitList;

  @override
  _WantToVisitTabState createState() => _WantToVisitTabState();
}

class _WantToVisitTabState extends State<WantToVisitTab> {
  late Column _wantToVisitWidgets;
  Map<String, Widget> _allWidgetsMap = {};

  @override
  void initState() {
    super.initState();
    _wantToVisitWidgets = _getWantToVisitWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return globals.wantToVisitList.isEmpty
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
        : SingleChildScrollView(child: _wantToVisitWidgets);
  }

  Column _getWantToVisitWidgets() {
    _saveGlobalList();
    _allWidgetsMap = {};
    _allWidgetsMap["DragTarget 0"] = VisitingDragTarget(
        index: 0,
        onAccept: (dragIndex, targetIndex) =>
            _moveSight(dragIndex, targetIndex));
    for (int index = 0; index < globals.wantToVisitList.length; index++) {
      _allWidgetsMap[globals.wantToVisitList[index].name] = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Dismissible(
          key: ValueKey(globals.wantToVisitList[index].name + " dismissWant"),
          child: WantToVisitSightCard(
            key: ValueKey(globals.wantToVisitList[index].name + " cardWant"),
            index: index,
            sight: globals.wantToVisitList[index],
            onDeleteTap: () =>
                _deleteSight(index, globals.wantToVisitList[index].name),
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
                      style: lmRoboto12W400.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
          ),
          onDismissed: (direction) =>
              _deleteSight(index, globals.wantToVisitList[index].name),
          direction: DismissDirection.endToStart,
        ),
      );
      _allWidgetsMap["DragTarget ${index + 1}"] = VisitingDragTarget(
          index: index + 1,
          onAccept: (dragIndex, targetIndex) =>
              _moveSight(dragIndex, targetIndex));
    }
    return Column(
      children: _allWidgetsMap.entries.map((e) => e.value).toList(),
    );
  }

  void _moveSight(int dragIndex, int targetIndex) {
    if (targetIndex != dragIndex + 1 && targetIndex != dragIndex) {
      setState(() {
        var movedSight = globals.wantToVisitList.removeAt(dragIndex);
        if (targetIndex == globals.wantToVisitList.length + 1) {
          globals.wantToVisitList.insert(targetIndex - 1, movedSight);
        } else {
          globals.wantToVisitList.insert(targetIndex, movedSight);
        }
        _wantToVisitWidgets = _getWantToVisitWidgets();
      });
    }
  }

  void _deleteSight(int index, String key) {
    setState(() {
      widget.wantToVisitList.removeAt(index);
      _allWidgetsMap.remove(key);
      _wantToVisitWidgets = _getWantToVisitWidgets();
    });
  }

  void _saveGlobalList() {
    globals.wantToVisitList = widget.wantToVisitList;
  }
}
