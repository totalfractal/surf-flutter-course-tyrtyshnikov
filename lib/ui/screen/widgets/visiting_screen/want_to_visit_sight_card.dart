import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/globals.dart';
import 'package:places/ui/screen/res/colors.dart';

import '../../sight_card.dart';

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
                .copyWith(color: isDarkMode ? dmGreenColor : lmGreenColor)),
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