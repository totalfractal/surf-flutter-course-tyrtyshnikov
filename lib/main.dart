

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';


void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First App',
      home: VisitingScreen(),
     // home: SightListScreen(title: "Список интересных мест",),
     // home: SightDetails(sight: Sight(mocks[0][0], mocks[0][1], mocks[0][2], mocks[0][3], mocks[0][4], mocks[0][5]),),
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFFFFFFF)),
      
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyFirstStatelessWidget(),
    );
  }
}

class MyFirstStatelessWidget extends StatelessWidget {

  int buildCount = 0;

  @override
  Widget build(BuildContext context) {
    print('Количество вызовов метода build(): ${++buildCount}');
    return Container(

      child: Center(

        child: Text('Hello!'),

      ),

    );
  }


}

class MyFirstStatefulWidget extends StatefulWidget {
  @override
  _MyFirstStatefulWidgetState createState() => _MyFirstStatefulWidgetState();


}

class _MyFirstStatefulWidgetState extends State<MyFirstStatefulWidget> {

  int buildCount = 0;

  void getRuntimeType(){
    print(context.runtimeType);
  }

  @override
  Widget build(BuildContext context) {
    print('Количество вызовов метода build(): ${++buildCount}');
    getRuntimeType();
    return Container(

      child: Center(

        child: Text('Hello!'),

      ),

    );
  }
}