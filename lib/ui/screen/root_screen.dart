import 'package:flutter/material.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:places/ui/screen/widgets/bottom_nav_bar.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  //FIXME: Сделать переменную в одном месте
  static int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: currentTab,
        children: [
          const SightListScreen(title: 'Список \nинтересных мест'),
          Container(),
          const VisitingScreen(title: 'Избранное'),
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(onTap: _selectTab),
    );
  }

  void _selectTab(int index) {
    setState(() {
      currentTab = index;
    });
  }
}
