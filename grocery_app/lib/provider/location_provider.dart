import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  double latitube;
  double longitube;
  bool permissionAllowed = false;

  Future<void> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      this.latitube = position.latitude;
      this.longitube = position.longitude;
      this.permissionAllowed = true;
      notifyListeners();
    } else {
      print('Permission not allow');
    }
  }
}
