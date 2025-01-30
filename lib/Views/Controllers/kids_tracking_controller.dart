import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Models/Kids.dart';

class KidTrackingController extends GetxController {
  var kids = <Kid>[
    Kid(name: 'Sam', status: 'At School', time: 'Since 8:00 am', location: LatLng(37.7749, -122.4194)),
    Kid(name: 'Liza', status: 'At School', time: 'Since 8:00 am', location: LatLng(51.5074, -0.1278)),
    Kid(name: 'Sami', status: 'At School', time: 'Since 8:00 am', location: LatLng(35.6895, 139.6917)),
  ].obs;

  var selectedKid = Kid(name: 'Sam', status: 'At School', time: 'Since 8:00 am', location: LatLng(37.7749, -122.4194)).obs;

  GoogleMapController? mapController;

  void selectKid(Kid kid) {
    selectedKid.value = kid;
    updateCameraPosition(kid.location);
  }

  void updateCameraPosition(LatLng location) {
    if (mapController != null) {
      mapController!.animateCamera(CameraUpdate.newLatLng(location));
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    updateCameraPosition(selectedKid.value.location);
  }
}
