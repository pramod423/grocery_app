import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
  double latitube;
  double longitube;
  bool permissionAllowed = false;
  var selectedAddress;

  Future<void> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      this.latitube = position.latitude;
      this.longitube = position.longitude;

      final coordinates = new Coordinates(this.latitube, this.longitube);
      final addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      this.selectedAddress = addresses.first;

      this.permissionAllowed = true;

      notifyListeners();
    } else {
      print('Permission not allow');
    }
  }

  void onCamerMove(CameraPosition cameraPosition) async {
    this.latitube = cameraPosition.target.latitude;
    this.longitube = cameraPosition.target.longitude;
    notifyListeners();
  }

  Future<void> getMoveCamera() async {
    print("${selectedAddress.featureName} : ${selectedAddress.addressLine}");
  }
}
