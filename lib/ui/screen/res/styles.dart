//Light Theme
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/globals.dart';
import 'package:places/ui/screen/res/colors.dart';

const TextStyle _text =
    TextStyle(fontFamily: 'Roboto', fontStyle: FontStyle.normal);

final sightListAppBarTextStyle =
    _text.copyWith(fontWeight: FontWeight.w700, fontSize: 32);

//TODO: Сделать стили по Figma

//Light Theme
TextStyle lmRoboto14Bold = _text.copyWith(
  fontWeight: FontWeight.bold,
  fontSize: 14,
  color: Colors.white,
);
TextStyle lmRoboto24W700 = _text.copyWith(
  fontSize: 24,
  fontWeight: FontWeight.w700,
  color: lmHeadline1Color,
);
TextStyle lmRoboto18W500 = _text.copyWith(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: lmHeadline2Color,
);
TextStyle lmRoboto14W400 = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: lmHeadline3Color,
);
TextStyle lmRoboto14W500 = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: lmHeadline4Color,
);
TextStyle lmHeadline5 = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: lmSubtitle1Color,
);
TextStyle lmRoboto14BoldSubtitle1 = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: lmSubtitle1Color,
);
TextStyle lmRoboto14Subtitle2 = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.normal,
  color: lmSubtitle2Color,
);
TextStyle lmRoboto14BodyText = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.normal,
  color: lmBodyText1Color,
);
TextStyle lmRoboto14W700Caption = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  color: lmCaptionColor,
);
TextStyle lmRoboto14W700 = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  color: lmPrimaryColor,
);

TextStyle lmRoboto16W400 = _text.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: lmMainColor,
);
TextStyle lmRoboto12W400 = _text.copyWith(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: lmInactiveBlackColor,
);

final lmAppBarTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  fontSize: 18,
  color: hexToColor('#252849'),
);

final lmSightDetailsTypeTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontStyle: FontStyle.normal,
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: hexToColor('#3B3E5B'),
  decoration: TextDecoration.none,
);
//Dark Theme
TextStyle dmRoboto14Bold = _text.copyWith(
  fontWeight: FontWeight.bold,
  fontSize: 14,
  color: Colors.white,
);
TextStyle dmRoboto24W700 = _text.copyWith(
  fontSize: 24,
  fontWeight: FontWeight.w700,
  color: dmHeadline1Color,
);
TextStyle dmRoboto18W500 = _text.copyWith(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: dmHeadline2Color,
);
TextStyle dmRoboto14W400 = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: dmHeadline3Color,
);
TextStyle dmRoboto14W500 = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: dmHeadline4Color,
);
TextStyle dmHeadline5 = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: dmHeadline5Color,
);
TextStyle dmRoboto14BoldSubtitle1 = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: dmSubtitle1Color,
);
TextStyle dmRoboto14Subtitle2 = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.normal,
  color: dmSubtitle2Color,
);
TextStyle dmRoboto14BodyText = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.normal,
  color: dmBodyText1Color,
);
TextStyle dmRoboto14W700Caption = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  color: dmCaptionColor,
);
TextStyle dmRoboto14W700 = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  color: dmPrimaryColor,
);

TextStyle dmRoboto16W400 = _text.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);
TextStyle dmRoboto12W400 = _text.copyWith(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: dmInactiveBlackColor,
);
const dmAppBarTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  fontSize: 18,
  color: Colors.white,
);
