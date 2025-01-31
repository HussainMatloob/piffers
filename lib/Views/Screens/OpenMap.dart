import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMapScreen extends StatefulWidget {
  final String location; // The location string from the notification payload

  const LocationMapScreen({required this.location});

  @override
  _LocationMapScreenState createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {
  late GoogleMapController mapController;
  late LatLng _locationCoordinates;
  bool _isValidCoordinates = false;

  @override
  void initState() {
    super.initState();
    _parseLocation();
  }

  void _parseLocation() {
    try {
      final coordinates = widget.location.split(',');
      if (coordinates.length == 2) {
        _locationCoordinates = LatLng(
          double.parse(coordinates[0]),
          double.parse(coordinates[1]),
        );
        _isValidCoordinates = true;
      }
    } catch (e) {
      _isValidCoordinates = false;
      debugPrint("Error parsing location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location for Help Request'),
      ),
      body: _isValidCoordinates
          ? GoogleMap(
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
      )
          : const Center(
        child: Text(
          'Invalid location data. Unable to display map.',
          style: TextStyle(color: Colors.red),
        ),
      ),
      floatingActionButton: _isValidCoordinates
          ? FloatingActionButton(
        onPressed: () {
          mapController.animateCamera(
            CameraUpdate.newLatLngZoom(_locationCoordinates, 16.0),
          );
        },
        child: const Icon(Icons.directions),
      )
          : null,
    );
  }
}
