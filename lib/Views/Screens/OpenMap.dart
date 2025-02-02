import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  const LocationMapScreen({required this.latitude, required this.longitude});

  @override
  _LocationMapScreenState createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {
  late GoogleMapController mapController;
  late LatLng _locationCoordinates;

  @override
  void initState() {
    super.initState();
    _locationCoordinates = LatLng(widget.latitude, widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location for Help Request'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _locationCoordinates,
          zoom: 15.0,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('helpRequest'),
            position: _locationCoordinates,
            infoWindow: const InfoWindow(title: 'Help Requested'),
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapController.animateCamera(
            CameraUpdate.newLatLngZoom(_locationCoordinates, 16.0),
          );
        },
        child: const Icon(Icons.directions),
      ),
    );
  }
}
