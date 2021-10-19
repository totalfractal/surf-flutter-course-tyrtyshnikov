import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/globals.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/res/styles.dart';
import 'package:places/ui/screen/widgets/sight_card.dart';
import 'package:places/ui/screen/widgets/visiting_screen/want_to_visit_sight_card.dart';

class DismissibleSightCard extends StatelessWidget {
  final Sight sight;
  final int index;
  final SightCard card;
  final Function(int index, ValueKey<String> key) onDelete;
  const DismissibleSightCard({
    required this.sight,
    required this.index,
    required this.card,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = ValueKey<String>('${sight.name} dismissWant');
    return Dismissible(
      key: key,
      child: card,
      background: Container(
        height: 198,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: isDarkMode ? dmRedColor : lmRedColor,
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
