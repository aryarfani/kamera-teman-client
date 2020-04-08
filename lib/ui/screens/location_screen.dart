import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kamera_teman_client/core/providers/maps_provider.dart';
import 'package:kamera_teman_client/core/utils/constant.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapsProv = Provider.of<MapsProvider>(context);
    if (mapsProv.cameraPosition == null) {
      mapsProv.initCamera();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Lokasi Kamera Teman'),
        backgroundColor: Styles.darkPurple,
      ),
      body: Stack(
        children: <Widget>[
          mapsProv.cameraPosition != null
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GoogleMap(
                    tiltGesturesEnabled: false,
                    markers: mapsProv.markers,
                    mapType: MapType.normal,
                    initialCameraPosition: mapsProv.cameraPosition,
                    mapToolbarEnabled: true,
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }
}
