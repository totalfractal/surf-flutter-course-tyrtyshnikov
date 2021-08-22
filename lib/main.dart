import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(ChangeNotifierProvider(
    child: const App(),
    create: (context) => ThemeProvider(isDarkMode: true),
  ));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
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
          //home: SearchScreen(),
          //home: AddSightScreen(),
          // home: SettingsScreen(),
          // home: FilterScreen(),
          home: const VisitingScreen(title: 'Избранное'),
          // home: SightListScreen(title: "Список \nинтересных мест"),
          /* home: SightDetails(
            sight: Sight(
                name: mocks[0][0],
                lat: double.parse(mocks[0][1]),
                lon: double.parse(mocks[0][2]),
                urls: mocks[0][3],
                details: mocks[0][4],
                type: mocks[0][5]),
          ), */
          // home: const OnboardingScreen(),
          //theme: globals.isDarkMode ? darkTheme : lightTheme,
          theme: themeProvider.getTheme,
        );
      },
    );
  }
}
