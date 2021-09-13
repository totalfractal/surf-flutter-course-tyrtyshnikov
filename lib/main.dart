import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/root_screen.dart';
import 'package:places/ui/screen/search_screen.dart';
import 'package:places/ui/screen/sight_details_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';
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
          routes: {
            '/': (context) => const SplashScreen(),
            '/root': (context) => const RootScreen(),
            '/onboarding': (context) => const OnboardingScreen(),
            '/search': (context) => const SearchScreen(),
            '/add': (context) => const AddSightScreen(),
            '/list': (context) =>
                const SightListScreen(title: 'Список \nинтересных мест'),
            '/favorites': (context) => const VisitingScreen(title: 'Избранное'),
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/details') {
              final sight = settings.arguments as Sight;
              return MaterialPageRoute<SightDetailsScreen>(
                builder: (context) => SightDetailsScreen(sight: sight),
              );
            }
          },
          // home: const RootScreen(),
          theme: themeProvider.getTheme,
        );
      },
    );
  }
}
