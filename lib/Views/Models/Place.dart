import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String name;
  final String address;
  final LatLng location;

  Place({required this.name, required this.address, required this.location});
}
