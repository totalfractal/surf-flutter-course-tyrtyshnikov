import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../mocks.dart';
import 'sight.dart';

class NearbySightsFinder {

  NearbySightsFinder(){
    _getAllSights();
    /* _checkPermissons();
    _updateLocation(); */
  }
  
  var _position = [47.1115, 39.4221];
  List<Sight> allSights = [];
  List<Sight> _nearbySights = [];

   void _getAllSights() {
    mocks.forEach((element) {
      allSights.add(Sight(
          name: element[0],
          lat: double.parse(element[1]),
          lon: double.parse(element[2]),
          url: element[3],
          details: element[4],
          type: element[5]));
    });

  }

 /*  void _updateLocation() async {
    try {
      Position newPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _position = newPosition;
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
 
  void _checkPermissons() async {
    await Geolocator.checkPermission();
  } */

  bool isPointsNear(List<double> checkPoint, List<double> centerPoint, double km) {
    var ky = 40000 / 360;
    var kx = cos(pi * centerPoint[0] / 180.0) * ky;
    var dx = (centerPoint[1] - checkPoint[1]).abs() * kx;
    var dy = (centerPoint[0] - checkPoint[0]) * ky;
    return sqrt(dx * dx + dy * dy) <= km;
  }
 
  List<Sight> calcNearbySights(double km) {
    List<Sight> nearbySights = [];
    allSights.forEach((element) {
      var checkPoint = [element.lat, element.lon];
      if (isPointsNear(checkPoint, _position, km)){
        nearbySights.add(element);
      }
    }
    );
    return nearbySights;
  }

  List<Sight> calcNearbySightsByRange(RangeValues range) {
    var nearbyStartRange = calcNearbySights(range.start / 1000.0);
    var nearbyEndRange = calcNearbySights(range.end / 1000.0);
    
    var deleteSights = [];
    
    nearbyStartRange.forEach((element) {
      if (nearbyEndRange.contains(element)) {
        deleteSights.add(element);
      }
    });
    deleteSights.forEach((element) {
      nearbyEndRange.remove(element);
    });
    return nearbyEndRange;
  }
}
