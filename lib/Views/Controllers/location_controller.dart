import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class LocationController extends GetxController {
  late GoogleMapController mapController;
  var markers = <Marker>{}.obs;
  var routePolyline = Rxn<Polyline>();

  late LatLng initialLocation;
  late LatLng targetLocation;

  // Set initial and target coordinates
  void setLocations(LatLng initial, LatLng target) {
    initialLocation = initial;
    targetLocation = target;

    // Set markers for both locations
    markers.addAll([
      Marker(
        markerId: const MarkerId('initialLocation'),
        position: initialLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: 'Static Initial Location'),
      ),
      Marker(
        markerId: const MarkerId('targetLocation'),
        position: targetLocation,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: 'Requested Location'),
      ),
    ]);

    _drawRoutePolyline();
  }

  // Draw a simple route between initial and target locations
  void _drawRoutePolyline() {
    final polyline = Polyline(
      polylineId: const PolylineId('routePolyline'),
      points: [initialLocation, targetLocation],
      color: Colors.blue,
      width: 5,
    );
    routePolyline.value = polyline;
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void zoomToTargetLocation() {
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(targetLocation, 16.0),
    );
  }
}
