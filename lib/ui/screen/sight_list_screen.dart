import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_card.dart';

import '../../globals.dart';

class SightListScreen extends StatefulWidget {
  SightListScreen({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width * 0.7, 75),
        child: AppBar(
          title: Container(
            child: AppBarTitleText(
              title: widget.title,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: getSightCardsList(),
            // children: [
            //   SightCard(sight: Sight(mocks[0], 0, 0, "1", "2", "3")),
            // ],
          ),
        ),
      ),
      
    );
  }

  List<Widget> getSightCardsList() {
    List<Widget> sightCards = [];
    mocks.forEach((element) {
      sightCards.add(Padding(
        padding: const EdgeInsets.all(16.0),
        child: SightCard(
            sight: Sight(
                name: element[0],
                lat: double.parse(element[1]),
          lon: double.parse(element[2]),
                url: element[3],
                details: element[4],
                type: element[5])),
      ));
    });
    return sightCards;
  }
}



class AppBarTitleText extends StatelessWidget {
  const AppBarTitleText({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      // style: lmSightListAppBarTextStyle,
      textAlign: TextAlign.start,
      maxLines: 2,
      softWrap: true,
    );
  }
}
