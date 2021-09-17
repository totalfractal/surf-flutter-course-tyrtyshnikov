import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/widgets/sight_card.dart';

class VisitedSightCard extends SightCard {
  final VoidCallback onShareTap;
  final VoidCallback onDeleteTap;
  const VisitedSightCard({
    required int index,
    required Sight sight,
    required this.onShareTap,
    required this.onDeleteTap,
    Key? key,
  }) : super(key: key, sight: sight, index: index);

  @override
  _VisitedSightCardState createState() => _VisitedSightCardState();
}

class _VisitedSightCardState extends SightCardState<VisitedSightCard> {
  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<int>(
      axis: Axis.vertical,
      data: widget.index,
      feedback: cardContainer(context),
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
      child: isDrag ? const SizedBox.shrink() : cardContainer(context),
    );
  }

  @override
  Column informationColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text(
            widget.sight.name.isEmpty ? 'Название' : widget.sight.name,
            style: Theme.of(context).primaryTextTheme.headline4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            'Цель достигнута 12 окт. 2020',
            textAlign: TextAlign.start,
            style: Theme.of(context).primaryTextTheme.subtitle2,
          ),
        ),
        Container(
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
                'res/icons/other/Share.png',
              ),
              onTap: widget.onShareTap,
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
              onTap: widget.onDeleteTap,
            ),
          ),
        ),
      ],
    );
  }
}
