import 'dart:ui';

import 'package:flutter/material.dart';

final isDarkMode = false;

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Image.asset(
              "res/icons/menu/List.png",
              color: isDarkMode ? Colors.white : hexToColor("#3B3E5B"),
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: Image.asset("res/icons/menu/Map.png",
                color: isDarkMode ? Colors.white : hexToColor("#3B3E5B")),
            label: ""),
        BottomNavigationBarItem(
          icon: Image.asset("res/icons/menu/Heart.png",
              color: isDarkMode ? Colors.white : hexToColor("#3B3E5B")),
          label: "",
        ),
        BottomNavigationBarItem(
            icon: Image.asset("res/icons/menu/Settings.png",
                color: isDarkMode ? Colors.white : hexToColor("#3B3E5B")),
            label: ""),
      ],
    );
  }
}