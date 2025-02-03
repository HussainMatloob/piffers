import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Controllers/location_controller.dart';

class LocationMapScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  const LocationMapScreen({required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    final LocationController locationController = Get.put(LocationController());

    // Static initial coordinates for testing (Islamabad, for example)
    final LatLng staticInitialLocation = LatLng(33.6844, 73.0479);
    final LatLng targetLocation = LatLng(latitude, longitude);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      locationController.setLocations(staticInitialLocation, targetLocation);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Location for Help Request'),
      ),
      body: Obx(() {
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: staticInitialLocation,
            zoom: 15.0,
          ),
          markers: locationController.markers,
          polylines: locationController.routePolyline.value != null
              ? {locationController.routePolyline.value!}
              : {},
          onMapCreated: locationController.onMapCreated,
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: locationController.zoomToTargetLocation,
        child: const Icon(Icons.zoom_in),
      ),
    );
  }
}
