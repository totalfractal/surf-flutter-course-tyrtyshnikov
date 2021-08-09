import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

import '../sight_card.dart';

class VisitedSightCard extends SightCard {
  const VisitedSightCard(
      {key,
      required int index,
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
}