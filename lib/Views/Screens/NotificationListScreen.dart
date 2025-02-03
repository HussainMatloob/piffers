import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/notification_controller.dart';
import 'OpenMap.dart';
import 'package:google_maps_url_extractor/google_maps_url_extractor.dart';

class NotificationListScreen extends StatelessWidget {
  final NotificationController notificationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Help Requests'),
      ),
      body: Obx(() {
        if (notificationController.notifications.isEmpty) {
          return const Center(
            child: Text('No new help requests.'),
          );
        }
        return ListView.builder(
          itemCount: notificationController.notifications.length,
          itemBuilder: (context, index) {
            final notification = notificationController.notifications[index];

            print('Notification data: ${notification.data}');
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: ListTile(
                leading: const Icon(Icons.notification_important, color: Colors.red),
                title: Text(
                  notification.notification?.title ?? 'Help Request',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  notification.notification?.body ?? 'Emergency reported',
                ),
                trailing: ElevatedButton(
                  onPressed: () async {
                    final latitude = notification.data['latitude'];
                    final longitude = notification.data['longitude'];

                    print('Latitude: $latitude, Longitude: $longitude');
                    // Convert latitude and longitude to double if they are Strings
                    double latitudeDouble = 0.0;  // Default value
                    double longitudeDouble = 0.0; // Default value

                    if (latitude is String) {
                      latitudeDouble = double.tryParse(latitude) ?? 0.0; // Default to 0.0 if invalid
                    } else if (latitude is num) {
                      latitudeDouble = latitude.toDouble();
                    }

                    if (longitude is String) {
                      longitudeDouble = double.tryParse(longitude) ?? 0.0; // Default to 0.0 if invalid
                    } else if (longitude is num) {
                      longitudeDouble = longitude.toDouble();
                    }
                    // Now we are sure latitudeDouble and longitudeDouble are valid doubles
                    Get.to(() => LocationMapScreen(latitude: latitudeDouble, longitude: longitudeDouble));
                  },
                  child: const Text('Navigate'),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
