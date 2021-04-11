import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text(widget.title),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: Icon(Icons.person),
      ), 
    );
  }
}