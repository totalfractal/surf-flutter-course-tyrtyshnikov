import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/res/styles.dart';

import '../../../globals.dart';

final lightTheme = ThemeData(
    primaryColor: lmPrimaryColor,
    backgroundColor: lmBackgroundColor,
    scaffoldBackgroundColor: lmScaffoldBackgroundColor,
    appBarTheme: AppBarTheme(
        backgroundColor: lmBackgroundColor,
        titleTextStyle: TextStyle(
          fontFamily: 'Roboto',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: Color.fromRGBO(37, 40, 73, 1),
        ),
        centerTitle: true),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(40), right: Radius.circular(40)),
        color: lmTabBarColor,
      ),
      labelStyle: lmRoboto14Bold,
      labelColor: lmPrimaryColor,
      labelPadding: EdgeInsets.only(left: 16),
      unselectedLabelStyle: lmRoboto14Bold,
      unselectedLabelColor: lmUnselectedLabelColor,
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: lmBottomAppBarColor),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: lmBottomNavBarColor),
    primaryTextTheme: TextTheme(
        headline1: lmRoboto24W700,
        headline2: lmRoboto18W500,
        headline3: lmRoboto14W400,
        headline4: lmRoboto14W500,
        headline5: lmHeadline5,
        subtitle1: lmRoboto14BoldSubtitle1,
        subtitle2: lmRoboto14Subtitle2,
        bodyText1: lmRoboto14BodyText,
        caption: lmRoboto14W700Caption,
        button: lmRoboto14W700),
    sliderTheme: SliderThemeData(
        activeTrackColor: Color.fromRGBO(76, 175, 80, 1),
        thumbColor: Colors.white,
        rangeThumbShape:
            RoundRangeSliderThumbShape(elevation: 4, pressedElevation: 8),
        rangeTrackShape: CustomRectTrackShape(),
        trackHeight: 2),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: dmElevatedButtonBackgroundColor,
            foregroundColor: MaterialStateProperty.all(Colors.white),
            textStyle: MaterialStateProperty.all(TextStyle(
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                fontSize: 14)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            )))),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
      color: hexToColor("#3B3E5B"),
    )))));

final darkTheme = ThemeData(
    primaryColor: dmPrimaryColor,
    backgroundColor: dmBackgroundColor,
    scaffoldBackgroundColor: dmScaffoldBackgroundColor,
    appBarTheme: AppBarTheme(
        backgroundColor: dmBackgroundColor,
        titleTextStyle: dmAppBarTextStyle,
        centerTitle: true),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(40), right: Radius.circular(40)),
        color: dmTabBarColor,
      ),
      labelStyle: dmRoboto14Bold,
      labelColor: dmPrimaryColor,
      labelPadding: EdgeInsets.only(left: 16),
      unselectedLabelStyle: dmRoboto14Bold,
      unselectedLabelColor: dmUnselectedLabelColor,
    ),
    canvasColor: dmBottomAppBarColor,
    bottomAppBarTheme: BottomAppBarTheme(
      color: dmBottomAppBarColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: dmBottomNavBarColor,
        unselectedItemColor: Colors.white),
    primaryTextTheme: TextTheme(
        headline1: dmRoboto24W700,
        headline2: dmRoboto18W500,
        headline3: dmRoboto14W400,
        headline4: dmRoboto14W500,
        headline5: dmHeadline5,
        subtitle1: dmRoboto14BoldSubtitle1,
        subtitle2: dmRoboto14Subtitle2,
        bodyText1: dmRoboto14BodyText,
        caption: dmRoboto14W700Caption,
        button: dmRoboto14W700),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: dmElevatedButtonBackgroundColor,
            foregroundColor: MaterialStateProperty.all(Colors.white),
            textStyle: MaterialStateProperty.all(TextStyle(
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                fontSize: 14)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            )))),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
      ),
    ));

class CustomRectTrackShape extends RoundedRectRangeSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx + 12;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 24;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
