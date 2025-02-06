import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Controllers/location_controller.dart';
import '../Utils/utils.dart';

class LocationMapScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  const LocationMapScreen({super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    final LocationController locationController = Get.put(LocationController());

    // Default location (Islamabad)
    LatLng staticInitialLocation = const LatLng(33.6844, 73.0479);
    LatLng targetLocation = LatLng(latitude, longitude);

    // Retrieve stored latitude & longitude
    Utils.getString('latitude').then((Clatitude) {
      Utils.getString('longitude').then((Clongitude) {
        if (Clatitude != null && Clongitude != null && Clatitude.isNotEmpty && Clongitude.isNotEmpty) {
          staticInitialLocation = LatLng(double.parse(Clatitude), double.parse(Clongitude));
          targetLocation = LatLng(latitude, longitude);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            locationController.setLocations(staticInitialLocation, targetLocation);
          });
        } else {
          // Fetch current location if stored location is unavailable
          locationController.getCurrentLocation().then((LatLng? currentLoc) {
            if (currentLoc != null) {
              staticInitialLocation = currentLoc;
            }

            // Set location after getting permission and current location
            WidgetsBinding.instance.addPostFrameCallback((_) {
              locationController.setLocations(staticInitialLocation, targetLocation);
            });
          });

          // Show snackbar if no location found
          Get.snackbar(
            "Location not available",
            "Fetching your current location...",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Route'),
      ),
      body: Obx(() {
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: staticInitialLocation,
            zoom: 14.0,
          ),
          markers: locationController.markers,
          polylines: locationController.routePolyline.value != null
              ? {locationController.routePolyline.value!}
              : {},
          onMapCreated: locationController.onMapCreated,
          myLocationEnabled: true,
          zoomControlsEnabled: true,
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: locationController.zoomToTargetLocation,
        child: const Icon(Icons.navigation),
      ),
    );
  }
}
