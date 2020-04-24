import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsProvider extends ChangeNotifier {
  //------------------------//
  //   PROPERTY SECTIONS    //
  //------------------------//

  //Property zoom camera
  double _cameraZoom = 16;
  double get cameraZoom => _cameraZoom;

  //Property camera position
  CameraPosition _cameraPosition;
  CameraPosition get cameraPosition => _cameraPosition;

  //Property my location data
  LatLng _sourceLocation;
  LatLng get sourceLocation => _sourceLocation;

  //Property to save all markers
  Set<Marker> _markers = LinkedHashSet();
  Set<Marker> get markers => _markers;

  //Property location services
  Location location = new Location();

  //------------------------//
  //   FUNCTION SECTIONS   //
  //------------------------//

  //Function to initialize camera
  Future initCamera() async {
    //Get current locations
    await initLocation();
    //Set current location to camera
    _cameraPosition = CameraPosition(zoom: cameraZoom, target: sourceLocation);
    notifyListeners();
  }

  //Function to get current locations
  Future initLocation() async {
    var locData = await location.getLocation();
    _sourceLocation = LatLng(locData.latitude, locData.longitude);
    print('${locData.latitude}, ${locData.longitude}');
    addMarker();
  }

  void addMarker() {
    _markers.add(Marker(
        markerId: MarkerId('tempat'),
        position: LatLng(-7.829333, 111.996128),
        infoWindow: InfoWindow(title: 'Kios Kamera Teman'),
        icon: BitmapDescriptor.defaultMarker));
  }
}
