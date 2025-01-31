import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationController extends GetxController {
  var notificationList = <Map<String, String>>[].obs;
  var notificationCount = 0.obs;
  var notifications = <RemoteMessage>[].obs;

  // Add new notification
  void addNotification(Map<String, String> notification) {
    notificationList.add(notification);
  }

  // Increment notification count (can be useful for displaying a badge)
  void incrementNotification(RemoteMessage message) {
    notifications.add(message);
  }
}
