import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/res/styles.dart';

import '../sight_list_screen.dart';

final lightTheme = ThemeData(
  primaryColor: lmPrimaryColor,
    backgroundColor: lmBackgroundColor,
    scaffoldBackgroundColor: lmScaffoldBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: lmBackgroundColor,
      titleTextStyle: lmAppBarTextStyle,
    ),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(40), right: Radius.circular(40)),
        color: hexToColor("#3B3E5B"),
      ),
      labelStyle: TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Colors.white,
      ),
      labelColor: Colors.white,
      labelPadding: EdgeInsets.only(left: 16),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Roboto',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      unselectedLabelColor: hexToColor("#7C7E92"),
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: lmBottomAppBarColor),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: lmBottomNavBarColor),
    primaryTextTheme: TextTheme(
        headline1: TextStyle(
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: hexToColor("#3B3E5B"),
            decoration: TextDecoration.none),
        headline2: TextStyle(
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: hexToColor("#7C7E92"),
                          ),
                          headline3: TextStyle(
                            fontFamily: 'Roboto',
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: hexToColor("#7C7E92"),
                          ),
                          headline4:  TextStyle(
                                  fontFamily: 'Roboto',
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: hexToColor("#3B3E5B"),
                                ),
        subtitle1: TextStyle(
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: hexToColor("#3B3E5B"),
            decoration: TextDecoration.none),
        subtitle2: TextStyle(
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: hexToColor("#7C7E92"),
            decoration: TextDecoration.none),
         
        bodyText1: TextStyle(
            wordSpacing: 15,
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: hexToColor("#3B3E5B"),
            decoration: TextDecoration.none),

      
        caption: TextStyle(
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),

        button: TextStyle(
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none)),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(hexToColor("#4CAF50")),
    )));
   

      
      
