import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../Api Services/apiservice.dart';
import 'package:http/http.dart' as http;

import '../Utils/utils.dart';
import 'package:geocoding/geocoding.dart';

class SOSController extends GetxController {
  final ApiService apiService = ApiService();

  var isLoading = false.obs;
  var responseMessage = ''.obs;
  var isTimerRunning = false.obs;
  var isTimerEnded = false.obs;
  var timerText = '10'.obs;

  /// Fetches the current location
  Future<Position?> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar(
          'Error',
          'Location services are disabled. Please enable them in settings.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return null;
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          Get.snackbar(
            'Error',
            'Location permission denied. Please allow access in settings.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          'Error',
          'Location permission permanently denied. Please allow access in settings.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return null;
      }

      // Retrieve current position
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get current location: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    }
  }

  /// Sends a help request after fetching the location
  Future<void> sendHelpRequest() async {
    try {
      isLoading.value = true;

      // Get the user's current location
      Position? position = await getCurrentLocation();
      if (position == null) {
        responseMessage.value = 'Unable to get location.';

        // get the location exact location name from position
        // final exactLocation = position.what ....

        return;
      }
// Get the exact location name from latitude and longitude
      String exactLocationName = await getExactLocationName(position.latitude, position.longitude);
      final fullName = await Utils.getString("name");

      String message = '$fullName Needs Immediate Help! My location is: $exactLocationName.';
      print('Sending help request with message: $message');
      await _sendNotificationToResponders(position.latitude, position.longitude);

      final response = await apiService.requestHelp(
        message: message,
        latitude: position.latitude,
        longitude: position.longitude,
      );
      await _sendNotificationToResponders(position.latitude, position.longitude);

      responseMessage.value = response['message'];
      Get.snackbar(
        'Help Requested',
        responseMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Send notification to responders

      // Close the screen after showing success
      Future.delayed(const Duration(seconds: 2), () {
        Get.back();
      });
    } catch (e) {
      responseMessage.value = 'Error: $e';
      Get.snackbar(
        'Error',
        responseMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }


  Future<String> getExactLocationName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String locationName = "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        print("Exact location: $locationName");
        return locationName;
      } else {
        return "Unknown location";
      }
    } catch (e) {
      print("Error getting location name: $e");
      return "Error retrieving location";
    }
  }

  Future<bool> _sendNotificationToResponders(double latitude, double longitude) async {
    const String backendEndpoint = 'https://sos.piffers.net/public/api/sendNotification';

    final response = await http.post(
      Uri.parse(backendEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'latitude': latitude,
        'longitude': longitude,
      }),
    );

    if (response.statusCode == 200) {
      print('Notification request sent successfully to the backend');
      return true;
    } else {
      print('Failed to send request: ${response.statusCode}');
      return false;
    }
  }


  /// Starts the timer for SOS
  void startTimer() {
    isTimerRunning.value = true;
    isTimerEnded.value = false;
    timerText.value = '10';

    for (int i = 1; i <= 10; i++) {
      Future.delayed(Duration(seconds: i), () {
        if (isTimerRunning.value && !isTimerEnded.value) {
          timerText.value = (10 - i).toString();
        }
      });
    }

    Future.delayed(const Duration(seconds: 10), () async {
      if (isTimerRunning.value) {
        isTimerEnded.value = true;
        timerText.value = '!';
        await sendHelpRequest(); // Fetch location and send the help request
        resetTimer();
      }
    });
  }

  /// Cancels the timer
  void cancelTimer() {
    isTimerRunning.value = false;
    isTimerEnded.value = true;
    resetTimer();
  }

  /// Resets the timer values
  void resetTimer() {
    isTimerRunning.value = false;
    isTimerEnded.value = false;
    timerText.value = '10';
  }
}
