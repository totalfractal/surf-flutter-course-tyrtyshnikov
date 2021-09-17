import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/globals.dart' as globals;
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/res/styles.dart';
import 'package:places/ui/screen/widgets/overscroll_glow_absorber.dart';
import 'package:places/ui/screen/widgets/visiting_screen/visited_sight_card.dart';
import 'package:places/ui/screen/widgets/visiting_screen/visiting_drag_target.dart';
import 'package:places/ui/screen/widgets/visiting_screen/want_to_visit_sight_card.dart';

class VisitingScreenTab extends StatefulWidget {
  final List<Sight> sightList;
  final String title;
  const VisitingScreenTab({
    required this.sightList,
    required this.title,
    Key? key,
  }) : super(key: key);

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
    _globalList = widget.title == 'Хочу посетить'
        ? globals.wantToVisitList
        : globals.visitedList;
    _saveGlobalList();
  }

  //TODO: Скролл списка при перетаскивании
  @override
  Widget build(BuildContext context) {
    return widget.sightList.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'res/icons/other/Card.png',
                height: 64,
                width: 64,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.high,
                color: globals.hexToColor('#7C7E92'),
                scale: 2,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 53),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 24, bottom: 8),
                      child: Text(
                        'Пусто',
                        style: Theme.of(context).primaryTextTheme.headline2,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Отмечайте понравившиеся места и они появятся здесь.',
                        style: Theme.of(context).primaryTextTheme.headline3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : OverscrollGlowAbsorber(
            child: ListView(
              physics: Platform.isAndroid
                  ? const ClampingScrollPhysics()
                  : const BouncingScrollPhysics(),
              children: _allWidgetsMap.entries.map((e) => e.value).toList(),
            ),
          );
  }

  void _getWantToVisitWidgets() {
    _saveGlobalList();
    _allWidgetsMap = {
      'DragTarget 0': VisitingDragTarget(
        index: 0,
        onAccept: _moveSight,
      ),
    };
    for (var index = 0; index < _globalList.length; index++) {
      _allWidgetsMap[_globalList[index].name] = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: widget.title == 'Хочу посетить'
            ? DismissibleWantToVisitSightCard(
                sight: _globalList[index],
                index: index,
                onDelete: (index, key) => _deleteSight(index, key.value),
              )
            : DismissibleVisitedSightCard(
                sight: _globalList[index],
                index: index,
                onDelete: (index, key) => _deleteSight(index, key.value),
              ),
      );
      _allWidgetsMap['DragTarget ${index + 1}'] = VisitingDragTarget(
        index: index + 1,
        onAccept: _moveSight,
      );
    }
  }

  void _moveSight(int dragIndex, int targetIndex) {
    if (targetIndex != dragIndex + 1 && targetIndex != dragIndex) {
      setState(() {
        final movedSight = _globalList.removeAt(dragIndex);
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

class DismissibleWantToVisitSightCard extends StatelessWidget {
  final Sight sight;
  final int index;
  final Function(int index, ValueKey<String> key) onDelete;
  const DismissibleWantToVisitSightCard({
    required this.sight,
    required this.index,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = ValueKey<String>('${sight.name} dismissWant');
    return Dismissible(
      key: key,
      child: WantToVisitSightCard(
        key: ValueKey('${sight.name} cardWant'),
        index: index,
        sight: sight,
        onDeleteTap: () => onDelete(index, key),
        onCalendarTap: () {},
      ),
      background: Container(
        height: 198,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: globals.isDarkMode ? dmRedColor : lmRedColor,
        ),
        child: Container(
          margin: const EdgeInsets.all(16),
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('res/icons/other/Bucket.png'),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Удалить',
                  style: lmRoboto12W400.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onDismissed: (direction) => onDelete(index, key),
      direction: DismissDirection.endToStart,
    );
  }
}

class DismissibleVisitedSightCard extends StatelessWidget {
  final Sight sight;
  final int index;
  final Function(int index, ValueKey<String> key) onDelete;
  const DismissibleVisitedSightCard({
    required this.sight,
    required this.index,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = ValueKey<String>('${sight.name} dismissVisited');
    return Dismissible(
      key: key,
      child: VisitedSightCard(
        key: ValueKey('${sight.name} cardVisited'),
        index: index,
        sight: sight,
        onDeleteTap: () => onDelete(index, key),
        onShareTap: () {},
      ),
      background: Container(
        height: 198,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: globals.isDarkMode ? dmRedColor : lmRedColor,
        ),
        child: Container(
          margin: const EdgeInsets.all(16),
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('res/icons/other/Bucket.png'),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Удалить',
                  style: lmRoboto12W400.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onDismissed: (direction) => onDelete(index, key),
      direction: DismissDirection.endToStart,
    );
  }
}
