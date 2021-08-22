import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

bool isDarkMode = true;

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

List<Sight> visitedList = [];
List<Sight> wantToVisitList = [];
