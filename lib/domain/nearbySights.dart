import 'package:geolocator/geolocator.dart';

class UserLocator{
var _geolocator = Geolocator();
Position _position;

List<double> getPosition(){
  _checkPermissons();
  _updateLocation();
  var longLat = [_position.longitude, _position.latitude];
  print(longLat);
  return longLat;
}

 void _updateLocation() async {
    try {
      Position newPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .timeout(new Duration(seconds: 5));
      _position = newPosition;
     
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  void _checkPermissons() async {
    await Geolocator.checkPermission();

  }
}

