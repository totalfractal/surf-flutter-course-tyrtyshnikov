import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/globals.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/sight_details_screen.dart';

class SightCard extends StatefulWidget {
  final Sight sight;
  final int? index;
  const SightCard({
    required this.sight,
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  SightCardState createState() => SightCardState();
}

class SightCardState<T extends SightCard> extends State<T> {
  GlobalKey globalKey = GlobalKey();
  bool isDrag = false;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: cardContainer);
  }

  Widget cardContainer(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 96,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black38,
                      Colors.black12,
                    ],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.topRight,
                    stops: [0.0, 1.0],
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.network(
                        widget.sight.urls[0],
                        loadingBuilder: (
                          context,
                          child,
                          loadingProgress,
                        ) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(12),
                    bottomStart: Radius.circular(12),
                  ),
                  color: isDarkMode
                      ? dmSightCardContainerColor
                      : lmSightCardContainerColor,
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: Builder(builder: informationColumn),
              ),
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _showDetails,
                customBorder: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.sight.type.isEmpty
                        ? 'категория'
                        : widget.sight.type.toLowerCase(),
                    style: Theme.of(context).primaryTextTheme.caption,
                  ),
                ),
                interactionButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget interactionButtons() {
    return SizedBox(
      width: 45,
      child: Material(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Ink(
            child: Image.asset(
              'res/icons/menu/Heart.png',
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }

  Column informationColumn(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text(
          widget.sight.name.isEmpty ? 'Название' : widget.sight.name,
          style: Theme.of(context).primaryTextTheme.headline5,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Text(
        'закрыто до 9:00',
        textAlign: TextAlign.start,
        style: Theme.of(context).primaryTextTheme.subtitle2,
      ),
    ]);
  }

  void _showDetails() {
    showModalBottomSheet<void>(
        context: context,
        builder: (_) {
          return SightDetailsScreen(sight: widget.sight);
        },
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - 64,
        ),
        isScrollControlled: true);
  }
}
