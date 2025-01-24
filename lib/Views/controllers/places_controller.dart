import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Models/Place.dart';
import 'package:location/location.dart';
import 'package:collection/collection.dart';  // Import the collection package for firstWhereOrNull

class PlaceController extends GetxController {
  var places = <Place>[].obs;  // List of saved places
  var selectedPlace = Place(
    name: 'Home',
    address: 'Islamabad, Pakistan',
    location: LatLng(33.6844, 73.0479),
  ).obs;  // Selected place details
  var currentLocation = LatLng(33.6844, 73.0479).obs;  // Current location on the map
  var markers = <Marker>{}.obs;  // Set of markers to be displayed on the map

  GoogleMapController? mapController;
  late Location location;

  @override
  void onInit() {
    super.onInit();
    location = Location();
    getCurrentLocation();
  }

  // Add a new place to the list
  void addPlace(Place place) {
    places.add(place);
  }

  // Update the camera position to a specific location
  void updateCameraPosition(LatLng location) {
    if (mapController != null) {
      mapController!.animateCamera(CameraUpdate.newLatLng(location));
    }
  }

  // Handle map creation and update the camera
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    updateCameraPosition(selectedPlace.value.location);
  }

  // Get the current location of the user
  void getCurrentLocation() async {
    var current = await location.getLocation();
    currentLocation.value = LatLng(current.latitude!, current.longitude!);
    updateCameraPosition(currentLocation.value);

    // Update markers with the current location
    markers.add(Marker(
      markerId: MarkerId('current-location'),
      position: currentLocation.value,
      infoWindow: InfoWindow(title: 'Current Location'),
    ));
  }

  // Function to get the marker by its ID (used when a marker is tapped)
  Marker? getMarkerById(MarkerId markerId) {
    return markers.firstWhereOrNull((marker) => marker.markerId == markerId);
  }

  // Handling marker tap to update the selected place
  void onMarkerTapped(MarkerId markerId) {
    Marker? tappedMarker = getMarkerById(markerId);
    if (tappedMarker != null) {
      // Update the selected place with the tapped marker's info
      selectedPlace.value = Place(
        name: tappedMarker.infoWindow.title ?? 'Untitled',
        address: 'Lat: ${tappedMarker.position.latitude}, Lng: ${tappedMarker.position.longitude}',  // Simple address placeholder
        location: tappedMarker.position,
      );
      print('Marker tapped: ${tappedMarker.infoWindow.title}');
    }
  }

  // Function to add a marker to the map
  void addMarker(Marker marker) {
    markers.add(marker);
  }

  // Function to remove a marker from the map
  void removeMarker(MarkerId markerId) {
    markers.removeWhere((marker) => marker.markerId == markerId);
  }
}
