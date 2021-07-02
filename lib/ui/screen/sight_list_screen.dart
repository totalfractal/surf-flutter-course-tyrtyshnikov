import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/styles.dart';
import 'package:places/ui/screen/sight_card.dart';

import '../../globals.dart';




class SightListScreen extends StatefulWidget {
  SightListScreen({Key key, this.title}) : super(key: key);

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
            //width: MediaQuery.of(context).size.width * 0.7,
            //child: AppBarTitleText(title: widget.title),
            child: AppBarTitleText(
              title: widget.title,
            ),
          ),
          elevation: 0,
          toolbarHeight: 75,
        ),
      ),
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
      bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Image.asset("res/icons/List.png", color: isDarkMode ? Colors.white : hexToColor("#3B3E5B"),), label: ""),
          BottomNavigationBarItem(icon: Image.asset("res/icons/Map.png", color: isDarkMode ? Colors.white : hexToColor("#3B3E5B")), label: ""),
          BottomNavigationBarItem(icon: Image.asset("res/icons/Heart.png", color: isDarkMode ? Colors.white : hexToColor("#3B3E5B")), label: "", ),
          BottomNavigationBarItem(icon: Image.asset("res/icons/Settings.png", color: isDarkMode ? Colors.white : hexToColor("#3B3E5B")), label: ""),
        ],
        ),
    );
  }
}

List<SightCard> getSightCardsList() {
  List<SightCard> sightCards = [];
  mocks.forEach((element) {
    sightCards.add(SightCard(
        sight: Sight(name: element[0], lat: element[1], lon: element[2], 
          url: element[3], details: element[4], type: element[5]) ));
  });
  return sightCards;
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


