import 'dart:math';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';

class NearbySightsFinder {
  final _position = [47.1115, 39.4221];
  List<Sight> allSights = [];

  NearbySightsFinder() {
    _getAllSights();
  }

  bool isPointsNear(
    List<double> checkPoint,
    List<double> centerPoint,
    double km,
  ) {
    const ky = 40000 / 360;
    final kx = cos(pi * centerPoint[0] / 180.0) * ky;
    final dx = (centerPoint[1] - checkPoint[1]).abs() * kx;
    final dy = (centerPoint[0] - checkPoint[0]) * ky;
    return sqrt(dx * dx + dy * dy) <= km;
  }

  List<Sight> calcNearbySights(double km) {
    return <Sight>[
      for (final sight in allSights)
        if (isPointsNear([sight.lat, sight.lon], _position, km)) sight,
    ];
  }

  List<Sight> calcNearbySightsByRange(RangeValues range) {
    // ignore: prefer_final_locals
    var nearbyStartRange = calcNearbySights(range.start / 1000.0);
    // ignore: prefer_final_locals
    var nearbyEndRange = calcNearbySights(range.end / 1000.0);

    final deleteSights = <Sight>[
      for (final sight in nearbyStartRange)
        if (nearbyEndRange.contains(sight)) sight,
      for (final sight in nearbyStartRange)
        if (nearbyEndRange.contains(sight)) sight,
    ];
    for (final element in deleteSights) {
      nearbyEndRange.remove(element);
    }
    return nearbyEndRange;
  }

  void _getAllSights() {
    allSights = [
      for (var element in mocks)
        Sight(
          name: element[0] as String,
          lat: double.parse(element[1] as String),
          lon: double.parse(element[2] as String),
          urls: element[3] as List<String>,
          details: element[4] as String,
          type: element[5] as String,
        ),
    ];
  }
}

