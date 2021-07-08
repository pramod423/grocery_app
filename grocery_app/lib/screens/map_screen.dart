import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_app/provider/location_provider.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  static const String id = 'map-screen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng currentLocation;
  GoogleMapController _mapController;
  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<LocationProvider>(context);
    setState(() {
      currentLocation = LatLng(locationData.latitube, locationData.longitube);
    });

    void onCreated(GoogleMapController controller) {
      _mapController = controller;
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: currentLocation, zoom: 14.4746),
              zoomControlsEnabled: false,
              minMaxZoomPreference: MinMaxZoomPreference(1.5, 20.8),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              mapToolbarEnabled: true,
              onCameraMove: (CameraPosition postion) {
                locationData.onCamerMove(postion);
              },
              onMapCreated: onCreated,
              onCameraIdle: () {
                locationData.getMoveCamera();
              },
            ),
            Center(
              child: Container(
                height: 50,
                margin: EdgeInsets.only(bottom: 40),
                child: Image.asset("images/location.png"),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.orangeAccent,
                child: Column(
                  children: [
                    Text(locationData.selectedAddress.featureName),
                    Text(locationData.selectedAddress.addressLine),
                    SizedBox(
                      height: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
