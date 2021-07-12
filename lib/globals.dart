import 'dart:ui';

import 'package:flutter/material.dart';

bool isDarkMode = false;

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

/* class ChangeThemeNotifier extends ChangeNotifier {
  void changeTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
 */
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      items: [
        BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? ImageIcon(AssetImage("res/icons/menu/List Full.png"))
                : ImageIcon(AssetImage("res/icons/menu/List.png")),
            label: ""),
        BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? ImageIcon(AssetImage("res/icons/menu/Map Full.png"))
                : ImageIcon(AssetImage("res/icons/menu/Map.png")),
            label: ""),
        BottomNavigationBarItem(
          icon: _selectedIndex == 2
              ? ImageIcon(AssetImage("res/icons/menu/Heart Full.png"))
              : ImageIcon(AssetImage("res/icons/menu/Heart.png")),
          label: "",
        ),
        BottomNavigationBarItem(
            icon: _selectedIndex == 3
            ? ImageIcon(AssetImage("res/icons/menu/Settings Full.png"))
            : ImageIcon(AssetImage("res/icons/menu/Settings.png")),
            label: ""),
      ],
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}
