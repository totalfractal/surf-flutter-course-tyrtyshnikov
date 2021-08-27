import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/globals.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/widgets/sight_card.dart';

class WantToVisitSightCard extends SightCard {
  final VoidCallback onDeleteTap;
  final VoidCallback onCalendarTap;
  const WantToVisitSightCard({
    required int index,
    required Sight sight,
    required this.onDeleteTap,
    required this.onCalendarTap,
    Key? key,
  }) : super(sight: sight, key: key, index: index);

  @override
  _WantToVisitSightCardState createState() => _WantToVisitSightCardState();

  @override
  Column informationColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text(
            sight.name.isEmpty ? 'Название' : sight.name,
            style: Theme.of(context).primaryTextTheme.headline4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            'Запланировано на 12 окт. 2020',
            textAlign: TextAlign.start,
            style: Theme.of(context).primaryTextTheme.subtitle2!.copyWith(
                  color: isDarkMode ? dmGreenColor : lmGreenColor,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            'закрыто до 9:00',
            textAlign: TextAlign.start,
            style: Theme.of(context).primaryTextTheme.subtitle2,
          ),
        ),
      ],
    );
  }

  @override
  Widget interactionButtons() {
    return Row(
      children: [
        SizedBox(
          width: 45,
          child: Material(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Image.asset(
                'res/icons/other/Calendar.png',
              ),
              onTap: onCalendarTap,
            ),
          ),
        ),
        SizedBox(
          width: 45,
          child: Material(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Image.asset(
                'res/icons/other/Delete.png',
              ),
              onTap: onDeleteTap,
            ),
          ),
        ),
      ],
    );
  }
}

class _WantToVisitSightCardState extends SightCardState<WantToVisitSightCard> {
  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<int>(
      axis: Axis.vertical,
      data: widget.index,
      feedback: widget.cardContainer(context),
      onDragStarted: () {
        setState(() {
          isDrag = true;
        });
      },
      onDragEnd: (details) {
        setState(() {
          isDrag = false;
        });
      },
      child: isDrag ? const SizedBox.shrink() : widget.cardContainer(context),
    );
  }
}
