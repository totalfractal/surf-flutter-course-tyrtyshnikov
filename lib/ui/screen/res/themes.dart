import 'package:flutter/material.dart';
import 'package:places/globals.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/res/styles.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData light = lightTheme;
  ThemeData dark = darkTheme;
  ThemeData? _selectedTheme;

  ThemeProvider({required bool isDarkMode}) {
    _selectedTheme = isDarkMode ? dark : light;
  }

  ThemeData? get getTheme => _selectedTheme;

  bool isDarkTheme() => _selectedTheme == dark || false;

  void swapTheme() {
    _selectedTheme = _selectedTheme == dark ? light : dark;
    isDarkMode = _selectedTheme == dark || false;
    notifyListeners();
  }
}

final lightTheme = ThemeData(
  primaryColor: lmPrimaryColor,
  backgroundColor: lmBackgroundColor,
  scaffoldBackgroundColor: lmScaffoldBackgroundColor,
  appBarTheme: const AppBarTheme(
    backwardsCompatibility: false,
    backgroundColor: lmBackgroundColor,
    titleTextStyle: TextStyle(
      fontFamily: 'Roboto',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: lmSecondaryColor,
    ),
    elevation: 0,
    centerTitle: true,
  ),
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: BoxDecoration(
      borderRadius: const BorderRadius.horizontal(
        left: Radius.circular(40),
      ),
      color: lmTabBarColor,
    ),
    labelStyle: lmRoboto14Bold,
    labelColor: lmPrimaryColor,
    labelPadding: const EdgeInsets.only(left: 16),
    unselectedLabelStyle: lmRoboto14Bold,
    unselectedLabelColor: lmUnselectedLabelColor,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(color: lmBottomAppBarColor),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: lmBottomNavBarColor,
    unselectedItemColor: lmSecondaryColor,
    selectedItemColor: lmSecondaryColor,
  ),
  primaryTextTheme: TextTheme(
    headline1: lmRoboto24W700,
    headline2: lmRoboto18W500,
    headline3: lmRoboto14W400,
    headline4: lmRoboto14W500,
    headline5: lmHeadline5,
    headline6: lmRoboto12W400,
    subtitle1: lmRoboto14BoldSubtitle1,
    subtitle2: lmRoboto14Subtitle2,
    bodyText1: lmRoboto14BodyText,
    bodyText2: lmRoboto16W400,
    caption: lmRoboto14W700Caption,
    button: lmRoboto14W700,
  ),
  sliderTheme: SliderThemeData(
      activeTrackColor: lmGreenColor,
      inactiveTrackColor: lmInactiveBlackColor,
      thumbColor: Colors.white,
      rangeThumbShape:
          const RoundRangeSliderThumbShape(elevation: 4, pressedElevation: 8),
      rangeTrackShape: CustomRectTrackShape(),
      trackHeight: 2),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      fixedSize:
          MaterialStateProperty.all<Size>(const Size(double.infinity, 48)),
      backgroundColor: MaterialStateProperty.all<Color>(lmGreenColor),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            fontSize: 14),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(lmInactiveBlackColor),
      foregroundColor: MaterialStateProperty.all(lmGreenColor),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          fontFamily: 'Roboto',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: lmMainColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    hintStyle: lmRoboto16W400.copyWith(color: lmInactiveBlackColor),
    errorStyle: const TextStyle(height: 0),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: lmRedColor.withOpacity(0.4), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: lmRedColor.withOpacity(0.4)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: lmGreenColor.withOpacity(0.4)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: lmGreenColor.withOpacity(0.4), width: 2),
    ),
  ),
  iconTheme: const IconThemeData(
    color: lmMainColor,
  ),
);

final darkTheme = ThemeData(
  primaryColor: dmPrimaryColor,
  backgroundColor: dmBackgroundColor,
  scaffoldBackgroundColor: dmScaffoldBackgroundColor,
  appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      backgroundColor: dmBackgroundColor,
      titleTextStyle: dmAppBarTextStyle,
      elevation: 0,
      centerTitle: true),
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: const BoxDecoration(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(40),
        right: Radius.circular(40),
      ),
      color: dmTabBarColor,
    ),
    labelStyle: dmRoboto14Bold,
    labelColor: dmPrimaryColor,
    labelPadding: const EdgeInsets.only(left: 16),
    unselectedLabelStyle: dmRoboto14Bold,
    unselectedLabelColor: dmUnselectedLabelColor,
  ),
  canvasColor: dmBottomAppBarColor,
  bottomAppBarTheme: BottomAppBarTheme(
    color: dmBottomAppBarColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: dmBottomNavBarColor,
      selectedItemColor: dmWhiteColor,
      unselectedItemColor: dmWhiteColor),
  primaryTextTheme: TextTheme(
      headline1: dmRoboto24W700,
      headline2: dmRoboto18W500,
      headline3: dmRoboto14W400,
      headline4: dmRoboto14W500,
      headline5: dmHeadline5,
      headline6: dmRoboto12W400,
      subtitle1: dmRoboto14BoldSubtitle1,
      subtitle2: dmRoboto14Subtitle2,
      bodyText1: dmRoboto14BodyText,
      bodyText2: dmRoboto16W400,
      caption: dmRoboto14W700Caption,
      button: dmRoboto14W700),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      fixedSize:
          MaterialStateProperty.all<Size>(const Size(double.infinity, 48)),
      backgroundColor: MaterialStateProperty.all<Color>(dmGreenColor),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontFamily: 'Roboto',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(dmInactiveBlackColor),
      foregroundColor: MaterialStateProperty.all(dmGreenColor),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          fontFamily: 'Roboto',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: dmGreenColor,
    inactiveTrackColor: dmInactiveBlackColor,
    thumbColor: Colors.white,
    rangeThumbShape:
        const RoundRangeSliderThumbShape(elevation: 4, pressedElevation: 8),
    rangeTrackShape: CustomRectTrackShape(),
    trackHeight: 2,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: dmWhiteColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    hintStyle: dmRoboto16W400.copyWith(color: dmInactiveBlackColor),
    errorStyle: const TextStyle(height: 0),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: dmRedColor.withOpacity(0.4), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: dmRedColor.withOpacity(0.4)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: dmGreenColor.withOpacity(0.4)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: dmGreenColor.withOpacity(0.4), width: 2),
    ),
  ),
  iconTheme: const IconThemeData(
    color: dmWhiteColor,
  ),
);

class CustomRectTrackShape extends RoundedRectRangeSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    Offset offset = Offset.zero,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight!;
    final trackLeft = offset.dx + 12;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width - 24;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
