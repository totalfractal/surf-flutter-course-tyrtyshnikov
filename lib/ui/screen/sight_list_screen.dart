import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  SightListScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

TextStyle _sightListAppBarTextStyle = 
  TextStyle(
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontSize: 32,
    color: hexToColor("#252849"),);

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          //child: AppBarTitleText(title: widget.title),
          child: AppBarTitleText(title: widget.title),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight: 75,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Hello!"
            ),
          ],
        ),
      ),
    );
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
    return Text(title,
          style: _sightListAppBarTextStyle,
          textAlign: TextAlign.start,
          maxLines: 2,
          softWrap: true,);
  }
}

