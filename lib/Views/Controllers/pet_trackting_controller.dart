import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Models/Pets.dart';

class PetTrackingController extends GetxController {
  var pets = <Pet>[
    Pet(name: 'Buddy', status: 'At Home', time: 'Since 9:00 am', location: LatLng(37.7749, -122.4194)),
    Pet(name: 'Max', status: 'At Park', time: 'Since 10:00 am', location: LatLng(51.5074, -0.1278)),
    Pet(name: 'Bella', status: 'At Vet', time: 'Since 11:00 am', location: LatLng(35.6895, 139.6917)),
  ].obs;

  var selectedPet = Pet(name: 'Buddy', status: 'At Home', time: 'Since 9:00 am', location: LatLng(37.7749, -122.4194)).obs;

  GoogleMapController? mapController;

  void selectPet(Pet pet) {
    selectedPet.value = pet;
    updateCameraPosition(pet.location);
  }

  void updateCameraPosition(LatLng location) {
    if (mapController != null) {
      mapController!.animateCamera(CameraUpdate.newLatLng(location));
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    updateCameraPosition(selectedPet.value.location);
  }
}
