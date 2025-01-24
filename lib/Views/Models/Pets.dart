import 'package:google_maps_flutter/google_maps_flutter.dart';

class Pet {
  final String name;
  final String status;
  final String time;
  final LatLng location;

  Pet({required this.name, required this.status, required this.time, required this.location});
}
