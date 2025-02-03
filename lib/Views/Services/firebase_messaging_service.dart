import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../Controllers/notification_controller.dart';
import '../Screens/OpenMap.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final NotificationController notificationController = Get.put(NotificationController());
  String? fullName;

  // Initialize the local notifications plugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Initialize the local notifications plugin
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, );

    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
      _logNotificationData(message); // Log notification data
      // _showNotification(message);
      notificationController.incrementNotification(message);
    });

    // App opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
      _logNotificationData(message); // Log notification data
      _handleNotification(message);
    });

    // Background and terminated state messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Background message handler
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    _logNotificationData(message); // Log notification data

    // Add notification to the list when the app is in background or terminated
    NotificationController notificationController = Get.find();
    notificationController.addNotification({
      'title': message.notification?.title ?? 'New Request',
      'body': message.notification?.body ?? 'You have a new help request',
      'location': message.data['location'] ?? 'No location provided',
    });

    // Show local notification for background messages
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'Your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title ?? 'New Help Request from SOS!', // Title
      message.notification?.body ?? 'Help Requested', // Body
      notificationDetails,
      payload: message.data['location'], // Pass location data as payload
    );
  }

  // Show notification in foreground
  void _showNotification(RemoteMessage message) {
    Get.snackbar(
      'New Help Request',
      message.notification?.body ?? 'Help Requested',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  // Handle notification click (navigate to the map screen)
  void _handleNotification(RemoteMessage message) async {
    final latitude = message.data['latitude'];
    final longitude = message.data['longitude'];

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
  }




  // Helper function to log notification data
  static void _logNotificationData(RemoteMessage message) {
    print('Notification Data:');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Data: ${message.data}');
    print('Latitude: ${message.data['latitude']}');
    print('Longitude: ${message.data['longitude']}');
  }
}