import 'package:flutter/material.dart';
import '../../../globals.dart';
import '../sight_list_screen.dart';

//Light Theme

const lmPrimaryColor = Colors.white,
lmBackgroundColor = Colors.white,
    lmScaffoldBackgroundColor = Colors.white,
    lmBottomAppBarColor = Colors.white,
    lmBottomNavBarColor = Colors.white;
final lmHeadline1Color = hexToColor("#3B3E5B"),
      lmHeadline2Color =  hexToColor("#7C7E92"),
      lmHeadline3Color = hexToColor("#3B3E5B"),
      lmHeadline4Color =  hexToColor("#3B3E5B"),
      lmHeadline5Color =  hexToColor("#3B3E5B"),
      lmSubtitle1Color = hexToColor("#3B3E5B"),
      lmSubtitle2Color = hexToColor("#7C7E92"),
      lmBodyText1Color = hexToColor("#3B3E5B"),
      lmCaptionColor = Colors.white,
      lmButtonTextColor = Colors.white;
final lmElevatedButtonBackgroundColor = MaterialStateProperty.all<Color>(hexToColor("#4CAF50"));
final lmUnselectedLabelColor = hexToColor("#7C7E92");
final lmTabBarColor = hexToColor("#3B3E5B");
final lmSightCardContainerColor = Colors.white;

//Dark Theme

final dmPrimaryColor = hexToColor("#2E2E2E"),
dmBackgroundColor = hexToColor("#21222C"),
    dmScaffoldBackgroundColor = hexToColor("#21222C"),
    dmBottomAppBarColor = hexToColor("#21222C"),
    dmBottomNavBarColor = hexToColor("#21222C");
final dmHeadline1Color = Colors.white,
      dmHeadline2Color =  hexToColor("#7C7E92"),
      dmHeadline3Color = hexToColor("#7C7E92"),
      dmHeadline4Color =  Colors.white,
      dmHeadline5Color =  Colors.white,
      dmSubtitle1Color = Color.fromRGBO(124, 126, 146, 1),
      dmSubtitle2Color = Color.fromRGBO(124, 126, 146, 0.56),
      dmBodyText1Color = Colors.white,
      dmCaptionColor = Colors.white,
      dmButtonTextColor = Colors.white;
final dmElevatedButtonBackgroundColor = MaterialStateProperty.all<Color>(hexToColor("#4CAF50"));
final dmUnselectedLabelColor = hexToColor("#7C7E92");
final dmTabBarColor = Colors.white;
final dmSightCardContainerColor = Color.fromRGBO(26, 26, 32, 1);
