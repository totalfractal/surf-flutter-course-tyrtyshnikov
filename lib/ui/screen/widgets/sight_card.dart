import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/sight_details.dart';

import '../../../globals.dart';

class SightCard extends StatefulWidget {
  const SightCard({
    Key? key,
    this.index,
    required this.sight,
  }) : super(key: key);

  final Sight sight;
  final int? index;

  @override
  _SightCardState createState() => _SightCardState();

  Widget interactionButtons() {
    return Container(
      width: 45,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Ink(
              child: Image.asset(
            "res/icons/menu/Heart.png",
          )),
          onTap: () => {
            print("you like this!"),
          },
        ),
      ),
    );
  }

  Column informationColumn(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(
            sight.name.isEmpty ? "Название" : sight.name,
            style: Theme.of(context).primaryTextTheme.headline5,
          )),
      Container(
        child: Text("закрыто до 9:00",
            textAlign: TextAlign.start,
            style: Theme.of(context).primaryTextTheme.subtitle2),
      ),
    ]);
  }
}

class _SightCardState extends State<SightCard> {
  GlobalKey globalKey = GlobalKey();
  bool isDrag = false;
  @override
  Widget build(BuildContext context) {
    var cardStack = Container(
      width: MediaQuery.of(context).size.width-32,
      child: Stack(
        key: globalKey,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            child: Column(
              children: [
                Container(
                  height: 96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    gradient: new LinearGradient(
                        colors: [
                          Colors.black38,
                          Colors.black12,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        child: Image.network(
                          widget.sight.url,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
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
                      borderRadius: BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(12),
                        bottomStart: Radius.circular(12),
                      ),
                      color: isDarkMode
                          ? dmSightCardContainerColor
                          : lmSightCardContainerColor),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(16.0),
                  child: widget.informationColumn(context),
                ),
              ],
            ),
          ),
          new Positioned.fill(
              child: new Material(
                  color: Colors.transparent,
                  child: new InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SightDetails(
                                    sight: widget.sight,
                                  )));
                    },
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ))),
          Container(
            margin: EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                        widget.sight.type.isEmpty
                            ? "категория"
                            : widget.sight.type.toLowerCase(),
                        style: Theme.of(context).primaryTextTheme.caption),
                  ),
                ),
                widget.interactionButtons(),
              ],
            ),
          ),
        ],
      ),
    );

    return Draggable<int>(
      data: widget.index,
      feedback: cardStack,
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
      child: isDrag ? SizedBox.shrink() : cardStack,
    );
  }
}
