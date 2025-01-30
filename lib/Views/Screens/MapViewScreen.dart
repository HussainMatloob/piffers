import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Models/Place.dart';
import '../Controllers/places_controller.dart';
import '../utils/utils.dart';

class MapViewScreen extends StatefulWidget {
  final String placeType;
  MapViewScreen({required this.placeType});

  @override
  _MapViewScreenState createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  late GoogleMapController mapController;

  final PlaceController placeController = Get.put(PlaceController());

  TextEditingController _placeNameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Listen to selectedPlace to update the text fields when a place is selected
    placeController.selectedPlace.listen((place) {
      _placeNameController.text = place.name;
      _locationController.text = place.address; // Assuming address is available
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    placeController.onMapCreated(controller);
  }

  void _onCameraMove(CameraPosition position) {
    // Update camera position
  }

  void _onMapLongPressed(LatLng position) {
    // Create a new marker at the long-pressed location
    final marker = Marker(
      markerId: MarkerId(position.toString()),
      position: position,
      infoWindow: InfoWindow(title: _placeNameController.text, snippet: 'Lat: ${position.latitude}, Lng: ${position.longitude}'),
    );

    // Add the marker to the map via the controller
    placeController.addMarker(marker);

    // Set the place's name and location in the controller
    placeController.selectedPlace.value = Place(
      name: _placeNameController.text.isEmpty ? 'Untitled' : _placeNameController.text,
      address: _locationController.text.isEmpty ? 'Unknown Address' : _locationController.text,
      location: position,
    );

    // Update the location text field with the long-pressed coordinates
    _locationController.text = 'Lat: ${position.latitude}, Lng: ${position.longitude}';
  }

  Future<void> _savePlace() async {
    final place = Place(
      name: _placeNameController.text,
      address: _locationController.text,
      location: placeController.currentLocation.value,
    );

    _placeNameController.clear();
    _locationController.clear();
    // Save place name and location in SharedPreferences
    Utils.saveString("place_name", _placeNameController.text);
    Utils.saveString("place_location", _locationController.text);

    String? placeName = await Utils.getString("place_name");
    String? placeLocation = await Utils.getString("place_location");

    print("Place Name: $placeName");
    print("Place Location: $placeLocation");

    placeController.addPlace(place);
    Get.back();  // Navigate back after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Place'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _savePlace,
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: placeController.currentLocation.value,
              zoom: 11.0,
            ),
            onCameraMove: _onCameraMove,
            markers: placeController.markers,
            onLongPress: _onMapLongPressed,  // Long press to add marker
          ),
          Positioned(
            top: 10,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Place Name TextField
                  TextField(
                    controller: _placeNameController,
                    decoration: const InputDecoration(
                      labelText: 'Place Name',
                      prefixIcon: Icon(Icons.location_city),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Location TextField
                  TextField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      prefixIcon: Icon(Icons.pin_drop),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              child: const Icon(Icons.my_location),
              onPressed: placeController.getCurrentLocation,
            ),
          ),
        ],
      ),
    );
  }
}
