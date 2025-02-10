import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Controllers/location_controller.dart';
import '../Utils/utils.dart';

class LocationMapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  const LocationMapScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  _LocationMapScreenState createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {
  final LocationController locationController = Get.put(LocationController());
  LatLng staticInitialLocation =
      const LatLng(33.6844, 73.0479); // Default: Islamabad
  late LatLng targetLocation;

  @override
  void initState() {
    super.initState();
    targetLocation = LatLng(widget.latitude, widget.longitude);
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    String? storedLat = await Utils.getString('latitude');
    String? storedLng = await Utils.getString('longitude');

    if (storedLat != null &&
        storedLng != null &&
        storedLat.isNotEmpty &&
        storedLng.isNotEmpty) {
      // Use stored location
      staticInitialLocation =
          LatLng(double.parse(storedLat), double.parse(storedLng));
    } else {
      // Fetch current location if no stored location is found
      LatLng? currentLoc = await locationController.getCurrentLocation();
      if (currentLoc != null) {
        staticInitialLocation = currentLoc;
        print('Current location obtained: $currentLoc');
      } else {
        // Show snackbar if location is unavailable
        Get.snackbar(
          "Location not available",
          "Fetching your current location...",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      }
    }

    print(
        'Static initial location: $staticInitialLocation, Target location: $targetLocation');

    // Update location in controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      locationController.setLocations(staticInitialLocation, targetLocation);
    });

    setState(() {}); // Refresh UI after fetching location
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Route')),
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
