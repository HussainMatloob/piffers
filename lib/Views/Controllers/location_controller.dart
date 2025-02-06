import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LocationController extends GetxController {
  late GoogleMapController mapController;
  var markers = <Marker>{}.obs;
  var routePolyline = Rxn<Polyline>();
  var currentLocation = Rxn<LatLng>(); // Store user's current location

  late LatLng initialLocation;
  late LatLng targetLocation;

  final String apiKey = "FGCwTz-_43hxdE9hme9egmDTrbk="; // Secure your API key

  // Get current location and request permissions if necessary
  Future<LatLng?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Error", "Location services are disabled. Enable them in settings.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return null;
    }

    // Check and request location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Error", "Location permission denied. Enable it in settings.",
            backgroundColor: Colors.red, colorText: Colors.white);
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Error", "Location permissions are permanently denied.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return null;
    }

    // Fetch the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    LatLng userLocation = LatLng(position.latitude, position.longitude);
    currentLocation.value = userLocation;

    // Add a marker for the current location
    markers.add(
      Marker(
        markerId: const MarkerId("currentLocation"),
        position: userLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(title: "Your Location"),
      ),
    );

    // Move the camera to the current location
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(userLocation, 15.0),
    );

    return userLocation;
  }

  // Set initial and target coordinates
  void setLocations(LatLng initial, LatLng target) {
    initialLocation = initial;
    targetLocation = target;

    // Clear old markers before adding new ones
    markers.clear();
    markers.addAll([
      Marker(
        markerId: const MarkerId('initialLocation'),
        position: initialLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: 'Start Location'),
      ),
      Marker(
        markerId: const MarkerId('targetLocation'),
        position: targetLocation,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: 'Destination'),
      ),
    ]);

    _fetchRoutePolyline();
  }

  // Fetch route data using Google Directions API
  Future<void> _fetchRoutePolyline() async {
    final String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialLocation.latitude},${initialLocation.longitude}&destination=${targetLocation.latitude},${targetLocation.longitude}&key=$apiKey";

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if (data["status"] == "OK") {
      List<LatLng> polylineCoordinates = [];
      List<PointLatLng> result = PolylinePoints().decodePolyline(
        data["routes"][0]["overview_polyline"]["points"],
      );

      for (var point in result) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      // Update route polyline with fetched data
      routePolyline.value = Polyline(
        polylineId: const PolylineId("routePolyline"),
        color: Colors.blue,
        width: 5,
        points: polylineCoordinates,
      );
    } else {
      Get.snackbar("Error", "Failed to fetch route",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Handle map creation
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Zoom to target location
  void zoomToTargetLocation() {
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(targetLocation, 15.0),
    );
  }
}
