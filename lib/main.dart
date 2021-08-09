import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/filter_screen.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/search_screen.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:provider/provider.dart';

import 'globals.dart' as globals;

void main() {
  return runApp(ChangeNotifierProvider(
    child: App(),
    create: (BuildContext context) => ThemeProvider(isDarkMode: false),
  ));
}

class App extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'First App',
          //  home: SearchScreen(),
          // home: AddSightScreenCategory(setCategory: (value){}),
          // home: AddSightScreenCategory(setCategory: (value){} ),
          home: AddSightScreen(),
          // home: SettingsScreen(),
          // home: FilterScreen(),
          // home: VisitingScreen(),
          /*  home: SightListScreen(
            title: "Список интересных мест",
          ), */
          // home: SightDetails(sight: Sight(name: mocks[0][0], lat: mocks[0][1], lon: mocks[0][2], url: mocks[0][3], details: mocks[0][4], type: mocks[0][5]),),
          //theme: globals.isDarkMode ? darkTheme : lightTheme,
          theme: themeProvider.getTheme,
        );
      },
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

  void getRuntimeType() {
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
