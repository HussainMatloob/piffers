import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/notification_controller.dart';
import 'OpenMap.dart';

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
                  onPressed: () {
                    String location = notification.data['location'] ?? '';
                    if (location.isNotEmpty) {
                      final coordinates = location.split(',');
                      if (coordinates.length == 2) {
                        double latitude = double.parse(coordinates[0]);
                        double longitude = double.parse(coordinates[1]);

                        // Navigate to LocationMapScreen
                        Get.to(() => LocationMapScreen(
                          location: '$latitude,$longitude',
                        ));
                      }
                    } else {
                      Get.snackbar('Error', 'Location not available for this notification');
                    }
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
